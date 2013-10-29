# encoding: utf-8
require 'xmlrpc/client'

desc "import places data form veganguide.org into database"
task :import_places => [:environment] do

  class XMLRPC::Client
    # File lib/xmlrpc/client.rb, line 500
    def do_rpc(request, async=false)
      header = {
       "User-Agent"     =>  USER_AGENT,
       "Content-Type"   => "text/xml; charset=utf-8",
       "Content-Length" => request.bytesize.to_s,
       "Connection"     => (async ? "close" : "keep-alive")
      }

      header["Cookie"] = @cookie        if @cookie
      header.update(@http_header_extra) if @http_header_extra

      if @auth != nil
        # add authorization header
        header["Authorization"] = @auth
      end

      resp = nil
      @http_last_response = nil

      if async
        # use a new HTTP object for each call
        Net::HTTP.version_1_2
        http = Net::HTTP.new(@host, @port, @proxy_host, @proxy_port)
        http.use_ssl = @use_ssl if @use_ssl
        http.read_timeout = @timeout
        http.open_timeout = @timeout

        # post request
        http.start {
          resp = http.post2(@path, request, header)
        }
      else
        # reuse the HTTP object for each call => connection alive is possible
        # we must start connection explicitely first time so that http.request
        # does not assume that we don't want keepalive
        @http.start if not @http.started?

        # post request
        resp = @http.post2(@path, request, header)
      end

      @http_last_response = resp

      data = resp.body

      if resp.code == "401"
        # Authorization Required
        raise "Authorization failed.\nHTTP-Error: #{resp.code} #{resp.message}"
      elsif resp.code[0,1] != "2"
        raise "HTTP-Error: #{resp.code} #{resp.message}"
      end

      ct = parse_content_type(resp["Content-Type"]).first
      if ct != "application/xml"
        if ct == "text/html"
          raise "Wrong content-type (received '#{ct}' but expected 'text/xml'): \n#{data}"
        else
          raise "Wrong content-type (received '#{ct}' but expected 'text/xml')"
        end
      end

      expected = resp["Content-Length"] || "<unknown>"
      if data.nil? or data.bytesize == 0
        raise "Wrong size. Was #{data.bytesize}, should be #{expected}"
      elsif expected != "<unknown>" and expected.to_i != data.bytesize and resp["Transfer-Encoding"].nil?
        raise "Wrong size. Was #{data.bytesize}, should be #{expected}"
      end

      set_cookies = resp.get_fields("Set-Cookie")
      if set_cookies and !set_cookies.empty?
        require 'webrick/cookie'
        @cookie = set_cookies.collect do |set_cookie|
          cookie = WEBrick::Cookie.parse_set_cookie(set_cookie)
          WEBrick::Cookie.new(cookie.name, cookie.value).to_s
        end.join("; ")
      end

      return data
    end
  end

  def cleaned(attribute)
    attribute.gsub("Ã¶", "ö").gsub("Ã¤", "ä").gsub("Ã©", "é").gsub("Ã¼", "ü").gsub("Ã", "ß").gsub("ß\u009F", "ß")
  end

  client = XMLRPC::Client.new 'veganguide.org', '/api'

  places_from_api = client.call('vg.browse.listPlacesByCity', { 'apikey' => 'c94297mghpgs', 'lang' => 'de', 'city' => 'koeln', 'country' => "germany", 'verbose' => ['address', 'coords', 'rating', 'city', 'country'] })
  places_from_api = places_from_api["data"]

  places_from_api.each do |place|
    place_attributes = {}.tap do |attribute|
      attribute[:slug]    = place["identifier"]
      attribute[:name]    = cleaned(place["name"])
      attribute[:address] = cleaned(place["verbose"]["address"])
      attribute[:rating]  = place["verbose"]["rating"] ? Float(place["verbose"]["rating"]) : 0.0
      attribute[:city]    = cleaned(place["verbose"]["city"])
      attribute[:country] = cleaned(place["verbose"]["country"])
      attribute[:lat]     = Float(place["verbose"]["coords"]["lat"])
      attribute[:lon]     = Float(place["verbose"]["coords"]["lon"])
    end

    if Place.where(slug: place_attributes[:slug]).present?
      puts "present: #{place_attributes[:slug]}"
    else
      puts "created: #{Place.create(place_attributes).slug}"
    end

  end
end
