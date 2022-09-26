class Auction
  attr_reader :items

  def initialize
    @items = []
  end

  def add_item(item)
    @items << item
  end

  def item_names
    @items.map do |item|
      item.name
    end
  end

  def unpopular_items
    unpopular_items = []
    items.map do |item|
      if item.bids.empty? == true
        unpopular_items << item
      end
    end
    unpopular_items
  end

  def potential_revenue
    potential_revenue = []
    items.each do |item|
      potential_revenue << item.current_high_bid
      potential_revenue.delete(nil)
    end
      potential_revenue.sum
  end

  def bidders
    bids = []
    bidder_names = []
    items.each do |item|
      if item.bids.empty? == false
        bids << item.bids.keys
      end
    end
    bids.flatten.map do |attendee|
      bidder_names << attendee.name
    end
    bidder_names.uniq
  end

  def close_bidding
  end

  def bidder_info
    attendee_hash = Hash.new(0)
    bids = []
    unique_bidders = []
    items.each do |item|
      if item.bids.empty? == false
        bids << item.bids.keys
      end
    end
    unique_bidders = bids.flatten.uniq
    unique_bidders.each do |attendee|
      attendee_hash[attendee] = {:budget => (attendee.budget), :items => []}
    end
    attendee_hash
    items.each do |item|
      attendee_hash.each do |attendee, info|
        if item.bids.include?(attendee)
        info[:items] = item
        #not getting the return value I want yet, but ran out of time
        end
      end
    end
    attendee_hash
  end
end
