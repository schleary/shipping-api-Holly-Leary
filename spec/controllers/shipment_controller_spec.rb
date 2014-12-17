require 'rails_helper'

RSpec.describe ShipmentController, :type => :controller do

  let (:shipment) {
   Shipment.new(
     id: 1,
     location: "NY",
     package: "stuff"
   )
 }
  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
