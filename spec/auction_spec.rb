require "rspec"
require "./lib/item.rb"
require "./lib/attendee.rb"
require "./lib/auction.rb"

RSpec.describe Auction do

  before(:each) do
    @item1 = Item.new('Chalkware Piggy Bank')
    @item2 = Item.new('Bamboo Picture Frame')
    @item3 = Item.new('Homemade Chocolate Chip Cookies')
    @item4 = Item.new('2 Days Dogsitting')
    @item5 = Item.new('Forever Stamps')
    @attendee = Attendee.new({name: 'Megan', budget: '$50'})
    @attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
    @attendee3 = Attendee.new({name: 'Mike', budget: '$100'})
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

  describe "#add_bid" do
    it "adds an attendee and their bid to an items's bid hash" do
      @attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)
      expect(@item1.bids).to eq({})
      @item1.add_bid(@attendee2, 20)
      @item1.add_bid(@attendee1, 22)
      expect(@item1.bids).to eq({@attendee2 => 20, @attendee1 => 22})
    end
  end

  describe "#current_high_bid" do
    it "returns the highest value that has been bidded on an item" do
      @attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)
      expect(@item1.bids).to eq({})
      @item1.add_bid(@attendee2, 20)
      @item1.add_bid(@attendee1, 22)
      expect(@item1.current_high_bid).to eq(22)
    end
  end

  describe "#unpopular_items" do
    it "returns a list of items that have no bids" do
      @attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)
      @item1.add_bid(@attendee2, 20)
      @item1.add_bid(@attendee1, 22)
      @item4.add_bid(@attendee3, 50)
      expect(@auction.unpopular_items).to eq([@item2, @item3, @item5])
    end
  end

  describe "#potential_revenue" do
    it "will return the total possible sale price of all items (the item's highest bid)" do
      @attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)
      @item1.add_bid(@attendee2, 20)
      @item1.add_bid(@attendee1, 22)
      @item4.add_bid(@attendee3, 50)
      @item3.add_bid(@attendee2, 15)
      expect(@auction.potential_revenue).to eq(87)
    end
  end

  describe "#bidders" do
    it "will return the list of the names of each attendee that have bid on an item" do
      @attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)
      @item1.add_bid(@attendee1, 22)
      @item1.add_bid(@attendee2, 20)
      @item4.add_bid(@attendee3, 50)
      @item3.add_bid(@attendee2, 15)
      expect(@auction.bidders).to eq(["Megan", "Bob", "Mike"])
    end
  end

  xdescribe "#close_bidding" do
    it "will update the item so that it will not accept additional bids" do
      @attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)
      @item1.add_bid(@attendee1, 22)
      @item1.add_bid(@attendee2, 20)
      @item4.add_bid(@attendee3, 50)
      @item3.add_bid(@attendee2, 15)
      expect(@item1.bids).to eq({@attendee2 => 20, @attendee1 => 22})
      @item1.close_bidding
      @item1.add_bid(@attendee3, 70)
      expect(@item1.bids).to eq({@attendee2 => 20, @attendee1 => 22})
      #need to figure out how to do this. Will come back to it
      end
    end

    describe "#bidder_info" do
      it "should return a hash with keys that are attendees, and values that are
        a hash with that attendee's budget and an array of items that attendee
        has bid on" do
        @attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
        @auction.add_item(@item1)
        @auction.add_item(@item2)
        @auction.add_item(@item3)
        @auction.add_item(@item4)
        @auction.add_item(@item5)
        @item1.add_bid(@attendee1, 22)
        @item1.add_bid(@attendee2, 20)
        @item4.add_bid(@attendee3, 50)
        @item3.add_bid(@attendee2, 15)
        expect(@auction.bidder_info).to eq({@attendee1 => {:budget => 50, :items => [@item1]},
                                            @attendee2 => {:budget => 75, :items => [@item1,@item3]},
                                            @attendee3 => {:budget => 100, :items => [@item4]}
                                            })
        end
    end
  end
