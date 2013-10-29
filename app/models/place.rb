class Place < ActiveRecord::Base
  attr_accessible :address, :city, :country, :slug, :lat, :lon, :name, :rating

  # write your model validations here
  # no idea how? => http://guides.rubyonrails.org/active_record_validations.html

  validates :address, presence: true
  validates :city, presence: true
  validates :country, presence: true
  validates :slug, presence: true
  validates :name, presence: true
  validates :lat, presence: true, numericality: true
  validates :lon, presence: true, numericality: true
  validates :rating, presence: true, numericality: true

  def description(format)
    if format == :short
      "#{name} (#{city})"
    elsif format == :long
      "#{name}: #{address}, #{city} (Lat: #{lat.round(2)} | Long: #{lon.round(2)})"
    end
  end
end

