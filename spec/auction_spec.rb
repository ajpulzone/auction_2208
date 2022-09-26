require "rspec"
require "./lib/item.rb"
require "./lib/attendee.rb"
require "./lib/auction.rb"

RSpec.describe Auction do

  before(:each) do
    @item1 = Item.new('Chalkware Piggy Bank')
    @item2 = Item.new('Bamboo Picture Frame')
    @attendee = Attendee.new({name: 'Megan', budget: '$50'})
    @auction = Auction.new
  end

  describe "#initialize" do
    it "exists" do
      expect(@auction).to be_an_instance_of(Auction)
    end

    it "has readable attributes" do
      expect(@auction.items).to eq([])
    end
  end

  describe "#add_item" do
    it "adds item to items array" do
      expect(@auction.items).to eq([])
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      expect(@auction.items).to eq([@item1, @item2])
    end
  end

  describe "#item_names" do
    it "returns and array of the names of auction items within the items array" do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      expect(@auction.items).to eq([@item1, @item2])
      expect(@auction.item_names).to eq(["Chalkware Piggy Bank", "Bamboo Picture Frame"])
    end
  end
end
