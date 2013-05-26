require 'card'
require 'debugger'

class Hand
  include Comparable
  
  attr_accessor :cards

  def initialize(cards = nil)
    @cards = cards || []
  end

  def discard(*discards)
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
  
  def add_cards(cards)
    if @cards.count + cards.count < 6
      @cards += cards
    else
      raise TooManyCardsError.new("Can't have more than 5 cards")
    end
  end

  def has_card?(card)
    @cards.any? { |c| c == card }
  end
  
  def full_hand?
    @cards.count == 5
  end
  
  def <=>(another)
    raise NotImplementedError
  end
  
  def values
    values = Hash.new(0)
    @cards.each { |c| values[c.value] +=1 }
    values
  end
  
  def suits
    suits = Hash.new(0)
    @cards.each { |c| suits[c.suit] +=1 }
    suits
  end
  
  def highest_card
    @cards.max
  end
  
  def straight?
    sorted = @cards.sort
    (1...sorted.length).each do |i|
      seq = (sorted[i-1].value + 1 == sorted[i].value)
      return false unless seq
    end
    true
  end
  
  def flush?
    suits.count == 1 && suits.has_value?(5)
  end
  
  def full_house?
    vals = values
    vals.count == 2 && vals.has_value?(2) && vals.has_value?(3)
  end
  
  def four_of_a_kind?
    values.has_value?(4)
  end
  
  def three_of_a_kind?
    values.has_value?(3)
  end
  
  def one_pair?
    values.has_value(2)
  end
  
  def two_pairs?
    values.values.count(2) == 2
  end

end

class TooManyCardsError < RuntimeError
end

class InvalidDiscardError < RuntimeError
end