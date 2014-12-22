class ShipmentsController < ApplicationController

  #  require 'active_shipping'
  include ActiveMerchant::Shipping
  rescue_from Timeout::Error, :with => :rescue_from_timeout

  def search

    if params.blank?
      render json: {error: "Must give complete address fields"}, status: :bad_request
    else

      @package = package_params
      @origin = origin_params
      @destination = destination_params

      response = {}
      rates = {}

      ups = UPS.new(:login => ENV["UPS_LOGIN"], :password => ENV["UPS_PASSWORD"], :key => ENV["UPS_ACCESS_KEY"])
      response[:ups] = ups.find_rates(@origin, @destination, @package)
      rates[:ups_rates] = response[:ups].rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price, rate.delivery_date]}

      usps = USPS.new(:login => ENV["USPS_USERNAME"])
      response[:usps] = usps.find_rates(@origin, @destination, @package)
      rates[:usps_rates] = response[:usps].rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price, rate.delivery_date]}

      render json: rates, status: 200

      # fedex = FedEx.new(:login => ENV["FEDEX_LOGIN"], :password => ENV["FEDEX_PASSWORD"], key: ENV["FEDEX_KEY"], account: ENV["FEDEX_ACCOUNT"], :test => true)

      # tracking_info = fedex.find_tracking_info('111111111111', :carrier_code => 'fedex_ground') # Ground package
      # tracking_info.shipment_events.each do |event|
      #   puts "#{event.name} at #{event.location.city}, #{event.location.state} on #{event.time}. #{event.message}"
      # end
      # render json: tracking_info
    end
  end

  private

  def package_params
    Package.new(
      100,
      [93,10],
      :cylinder => false)
  end

  def origin_params
    Location.new(
      :country => 'US',
      :state => 'CA',
      :city => 'Beverly Hills',
      :zip => '90210'
      # :options => {:shipping_date => DateTime.now}
    )
  end

  def destination_params
    Location.new(
      :country => params["country"],
      :province => params["state"],
      :city => params["city"],
      :postal_code => params["zip"]
      # :options => {:shipping_date => DateTime.now}
    )
  end


  protected

    def rescue_from_timeout(exception)
      render json: {error: "Timeout Error"}, status: 408
    end

end
