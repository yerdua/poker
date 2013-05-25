require 'card'

class Deck

  attr_reader :cards

  def initialize(cards = nil)
    @cards = cards || create_cards
  end

  def count
    @cards.count
  end

  def shuffle!
    @cards.shuffle!
  end

  def deal(number = 1)
    if number > count
      raise OutOfCardsError.new("Can't deal more cards than exist in the deck")
    end
    deal = []
    number.times { deal << @cards.shift }
    deal
  end

  private

    def create_cards
      cards = []
      @cards = Card::SUITS.each_key do |suit|
        (1..13).each do |value|
          cards << Card.new(value, suit)
        end
      end
      cards
    end

end

class OutOfCardsError < ArgumentError
end