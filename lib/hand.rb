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

  def has_card?(card)
    @cards.any? { |c| c == card }
  end
  
  def full_hand?
    @cards.count == 5
  end
  
  def <=>(another)
    raise NotImplementedError
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
    @cards.all? { |c| c.suit == @cards.first.suit }
  end
  
  def full_house?
    sorted = @cards.sort
    sorted[0].value == sorted[1].value &&
      sorted[3].value == sorted[4].value &&
      (sorted[2].value == sorted[1].value || 
      sorted[2].value == sorted[3].value)
  end
  
  def four_of_a_kind?
    
  end

end

class InvalidDiscardError < RuntimeError
end