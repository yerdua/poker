require 'player'
require 'deck'
require 'hand'
require 'card'

class Game
  
  def initialize(*players)
    @deck = Deck.new
    @players = players
    
  end
end