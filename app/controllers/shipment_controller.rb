class ShipmentController < ApplicationController
require 'active_shipping'
include ActiveMerchant::Shipping

  def new
    @shipment = Shipment.new()
  end

  def index
    @shipments = Shipment.all
    render json: @shipments
    render json: @shipments.as_json(only: [:id, :package, :location, :usps, :ups, :fedex]), status: :ok
  end

  # def show
  #   @shipment = {: @shipment.,
  #                : @shipment.,
  #                : @shipment.
  #               }
  #
  #   @shipment = Shipment.find(params[:id])
  #   render json: @shipment, status: :ok
  # end

  def search

    # Package up a poster and a Wii for your nephew.
    packages = [
      Package.new(  100,
                    [93,10],
                    :cylinder => true),

      Package.new(  (7.5 * 16),
                    [15, 10, 4.5],
                    :units => :imperial)
    ]

    # You live in Beverly Hills, he lives in Ottawa
    origin = Location.new(      :country => 'US',
                                :state => 'CA',
                                :city => 'Beverly Hills',
                                :zip => '90210')

    destination = Location.new( :country => 'CA',
                                :province => 'ON',
                                :city => 'Ottawa',
                                :postal_code => 'K1P 1J1')

    # Find out how much it'll be.
    ups = UPS.new(:login => 'auntjudy', :password => 'secret', :key => 'xml-access-key')
    response = ups.find_rates(origin, destination, packages)

    ups_rates = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
    # => [["UPS Standard", 3936],
    #     ["UPS Worldwide Expedited", 8682],
    #     ["UPS Saver", 9348],
    #     ["UPS Express", 9702],
    #     ["UPS Worldwide Express Plus", 14502]]

    # Check out USPS for comparison...
    usps = USPS.new(:login => 'developer-key')
    response = usps.find_rates(origin, destination, packages)

    usps_rates = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
    # => [["USPS Priority Mail International", 4110],
    #     ["USPS Express Mail International (EMS)", 5750],
    #     ["USPS Global Express Guaranteed Non-Document Non-Rectangular", 9400],
    #     ["USPS GXG Envelopes", 9400],
    #     ["USPS Global Express Guaranteed Non-Document Rectangular", 9400],
    #     ["USPS Global Express Guaranteed", 9400]]

    end

end
