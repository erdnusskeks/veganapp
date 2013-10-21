class Place < ActiveRecord::Base
  attr_accessible :address, :city, :country, :language, :lat, :lon, :name

  # write your model validations here
  # no idea how? => http://guides.rubyonrails.org/active_record_validations.html

end
