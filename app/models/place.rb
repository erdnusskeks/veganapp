class Place < ActiveRecord::Base
  attr_accessible :address, :city, :country, :language, :lat, :lon, :name
end
