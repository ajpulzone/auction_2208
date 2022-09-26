class Item
  attr_reader :name, :bids

  def initialize(name, bids = Hash.new(0))
    @name = name
    @bids = Hash.new(0)
  end

  def add_bid(attendee, bid_amount)
    bids[attendee] += bid_amount
  end

  def current_high_bid
    item_bid_values = []
    bids.each do |attendee, bid_amount|
      item_bid_values << bid_amount
    end
    item_bid_values.max
  end
end
