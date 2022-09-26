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
end
