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

end
