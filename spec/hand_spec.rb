require 'rspec'
require 'hand'

describe "Hand" do
  subject(:hand) { Hand.new }

  it "is initialized with nothing by default" do
    subject.cards.should be_empty
  end

  context "With a full (random) hand" do
    let(:deck) { Deck.new }
    subject(:hand) { Hand.new(deck.deal(5)) }

    describe "#discard" do
      it "raises an error if more than 3 cards are specified" do
        discards = subject.cards[0,4]
        expect { hand.discard(*discards) }.to raise_error(InvalidDiscardError)
      end

      it "raises an error if the cards aren't in the hand" do
        discards = deck.deal
        expect { hand.discard(*discards) }.to raise_error(InvalidDiscardError)
      end

      it "removes the selected cards" do
        card = subject.cards.last
        subject.discard(card)
        subject.has_card?(card).should be_false
      end
    end
    
    describe "#add_cards" do
      it "prevents adding cards to a full hand" do
        expect { hand.add_cards(deck.deal(1)) }.to raise_error(TooManyCardsError)
      end
    end
    
  end
  
  context "With an empty hand" do
    let(:deck) { Deck.new }
    subject(:hand) { Hand.new }
    
    describe "#add_cards" do
      it "adds 5 cards" do
        hand.add_cards(deck.deal(5))
        hand.cards.count.should == 5
      end
      
      it "prevents adding more than 5 cards" do
        expect { hand.add_cards(deck.deal(6)) }.to raise_error(TooManyCardsError)
      end
    end
  end
  
  describe "#flush?" do 
    it "is true when all cards have the same suit" do
      cards = (1..13).to_a.sample(5).map do |v|
        Card.new(v, :spades)
      end
      
      Hand.new(cards).should be_flush
    end
    
    it "is false when the suits don't match" do
      cards = (1..13).to_a.sample(4).map do |v|
        Card.new(v, :spades)
      end
      cards << Card.new(6, :hearts)
      
      Hand.new(cards).should_not be_flush
    end
  end
  
  describe "#straight?" do
    it "is true when the cards are squential" do
      cards = [2,3,4,5].map do |v|
        Card.new(v, :clubs)
      end
      cards << Card.new(6, :spades)
      Hand.new(cards).should be_straight
    end
    
    it "is false when the cards have gaps" do
      cards = [2,4,6,8,1].map do |v|
        Card.new(v, :hearts)
      end
      Hand.new(cards).should_not be_straight
    end
  end
  
  describe "#fullhouse?" do
    it "is true when there's a set of two and a set of three" do
      cards = []
      cards << Card.new(6, :spades)
      cards << Card.new(6, :hearts)
      cards << Card.new(6, :clubs)
      cards << Card.new(10, :clubs)
      cards << Card.new(10, :spades)
      Hand.new(cards).should be_full_house
    end
    
    it "is false when there is not a set of two and a set of three" do
      cards = [1,4,5,7,9].map do |v|
        Card.new(v, :hearts)
      end
      Hand.new(cards).should_not be_full_house
    end
  end
end