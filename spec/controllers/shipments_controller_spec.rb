require 'rails_helper'

RSpec.describe ShipmentsController, :type => :controller do

  let (:package) {
    Package.new(
    100,
    [93,10],
    :cylinder => false
    )
  }

  let (:origin) {
    Location.new(
    :country => 'US',
    :state => 'CA',
    :city => 'Beverly Hills',
    :zip => '90210'
    )
  }

  let (:destination) {
    Location.new(
    :country => 'US',
    :state => 'WA',
    :city => 'Seattle',
    :zip => '98119'
    )
  }

  describe "GET search" do
    it "returns http success" do
      get :search
      expect(response).to have_http_status(:success)
    end
  end

end
