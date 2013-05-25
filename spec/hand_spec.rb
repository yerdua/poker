require 'rspec'
require 'hand'

describe "Hand" do
  subject(:hand) { Hand.new }

  it "is initialized with nothing by default" do
    subject.cards.should be_empty
  end

  context "With a full hand" do
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
  end
end