require 'card'

class Hand
  attr_accessor :cards

  def initialize(cards = nil)
    @cards = cards || []
  end

  def discard(*discards)
    p discards
    unless discards.length.between?(0,3)
      raise InvalidDiscardError.new("Can't discard #{cards.length} cards")
    end

    unless discards.all? { |c| has_card?(c) }
      raise InvalidDiscardError.new("Can't discard cards you don't have")
    end

    discards.each do |dcard|
      @cards.delete_if { |card| card == dcard }
    end

  end

  def has_card?(card)
    @cards.any? { |c| c == card }
  end

end

class InvalidDiscardError < RuntimeError
end