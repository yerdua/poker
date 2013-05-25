class Card
  SUITS = {
    :hearts => :red,
    :diamonds => :red,
    :clubs => :black,
    :spades => :black
  }

  attr_reader :value, :suit

  def initialize(value, suit)
    self.value = value
    self.suit = suit
  end

  def color
    SUITS[@suit]
  end

  def ==(other_card)
    @value == other_card.value && @suit == other_card.suit
  end

  private

  def value=(val)
    unless val.between?(1,13)
      raise ArgumentError.new("Card cannot have a value of #{val}")
    end

    @value = val
  end

  def suit=(suit)
    unless SUITS.keys.include? suit
      raise ArgumentError.new("#{suit} is not a valid suit")
    end

    @suit = suit
  end


end