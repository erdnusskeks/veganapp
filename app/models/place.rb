class Place < ActiveRecord::Base
  attr_accessible :address, :city, :country, :language, :lat, :lon, :name

  # write your model validations here
  # no idea how? => http://guides.rubyonrails.org/active_record_validations.html

  validates :address, presence: true
  validates :city, presence: true
  validates :country, presence: true
  validates :language, presence: true
  validates :name, presence: true
  validates :lat, presence: true, numericality: true
  validates :lon, presence: true, numericality: true

end
