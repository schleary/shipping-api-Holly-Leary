class Location < ActiveRecord::Base

  validates :country, :state, :city, :zip, presence: true
  
end
