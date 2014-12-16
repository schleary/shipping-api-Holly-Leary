require 'rails_helper'

RSpec.describe Location, :type => :model do

   let(:location) {
    Location.new(
      country: "US",
      state: "NY",
      city: "Binghamton",
      zip: "13795"
    )
  }

  describe 'validations' do
    it "are valid" do
      expect(location).to be_valid
    end
  end

  

end
