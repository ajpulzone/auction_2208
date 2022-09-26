class Item
  attr_reader :name, :bids

  def initialize(name, bids = Hash.new(0))
    @name = name
    @bids = Hash.new(0)
  end


end
