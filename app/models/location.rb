class Location < ActiveRecord::Base

  validates :country, :state, :city, :zip, presence: true

  composed_of :address, mapping: [ %w(address_street street), %w(address_city city) ]
end
