require "rspec"
require "./lib/item.rb"
require "./lib/attendee.rb"

RSpec.describe Attendee do

  before(:each) do
    @item1 = Item.new('Chalkware Piggy Bank')
    @item2 = Item.new('Bamboo Picture Frame')
    @attendee = Attendee.new({name: 'Megan', budget: '$50'})
  end

  describe "#initialize" do
    it "exists" do
      expect(@attendee).to be_an_instance_of(Attendee)
    end

    it "has readable attributes" do
      expect(@attendee.name).to eq("Megan")
      expect(@attendee.budget).to eq(50)
    end
  end
end
