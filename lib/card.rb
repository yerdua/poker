class Card
  SYMBOLS = [:hearts, :diamonds, :clubs, :spades]

  attr_reader :value, :symbol

  def initialize(value, symbol)
    self.value = value
    self.symbol = symbol
  end

  private

  def value=(val)
    if val > 13 || val < 1
      raise ArgumentError.new("Card cannot have a value of #{val}")
    end

    @value = val
  end

  def symbol=(symbol)
    unless SYMBOLS.include? symbol
      raise ArgumentError.new("#{symbol} is not a valid symbol")
    end

    @symbol = symbol
  end


end