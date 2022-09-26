require "rspec"
require "./lib/item.rb"

RSpec.describe Item do

  before(:each) do
    @item1 = Item.new('Chalkware Piggy Bank')
  end

  describe "#initialize" do
    it "exists" do
      expect(@item1).to be_an_instance_of(Item)
    end

    it "has readable attributes" do
      expect(@item1.name).to eq("Chalkware Piggy Bank")
      expect(@item1.bids).to eq({})
    end
  end
end
