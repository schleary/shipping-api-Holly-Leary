class ShipmentsController < ApplicationController

  #  require 'active_shipping'
  include ActiveMerchant::Shipping

  def search
    puts params.inspect
    # Package up a poster and a Wii for your nephew.

    @package = Package.new(  100,
    [93,10],
    :cylinder => true)

    @origin =Location.new(

    # :country => params["country"],
    #                       :state => params["state"],
    #                       :city => params["city"],
    #                       :zip => params["zip"])

      :country => 'US',
      :state => 'CA',
      :city => 'Beverly Hills',
      :zip => '90210')

    @destination = Location.new(
        :country => params["country"],
        :state => params["state"],
        :city => params["city"],
        :zip => params["zip"])

      # :country => 'CA',
      # :province => 'ON',
      # :city => 'Ottawa',
      # :postal_code => 'K1P 1J1'
      # )

    response = {}
    ups = UPS.new(:login => ENV["UPS_LOGIN"], :password => ENV["UPS_PASSWORD"], :key => ENV["UPS_ACCESS_KEY"])
    puts ups.find_rates(@origin, @destination, @package).inspect
    puts"**********"
    response[:ups] = ups.find_rates(@origin, @destination, @package)

    # render json: response

    usps = USPS.new(:login => ENV["USPS_USERNAME"])
    puts usps.find_rates(@origin, @destination, @package).inspect
    puts"**********"
    response[:usps] = usps.find_rates(@origin, @destination, @package)

    # puts response.inspect
    render json: response

    # fedex = FedEx.new(:login => ENV["FEDEX_LOGIN"], :password => ENV["FEDEX_PASSWORD"], key: ENV["FEDEX_KEY"], account: ENV["FEDEX_ACCOUNT"], :test => true)
    # tracking_info = fedex.find_tracking_info('111111111111', :carrier_code => 'fedex_ground') # Ground package
    # tracking_info.shipment_events.each do |event|
    #   puts "#{event.name} at #{event.location.city}, #{event.location.state} on #{event.time}. #{event.message}"
    # end
    # render json: tracking_info

  end
end
