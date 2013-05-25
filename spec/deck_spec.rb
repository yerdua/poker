require 'rspec'
require 'deck'

describe "Deck" do
  subject(:deck) { Deck.new }

  it "has 52 cards" do
    subject.count.should == 52
  end

  describe "#shuffle!" do
    it "changes the order of the cards" do
      original_order = subject.cards.dup
      subject.shuffle!
      subject.cards.should_not == original_order
    end
  end

  describe "#deal" do
    it "returns the specified number of cards" do
      subject.deal(5).count == 5
    end

    it "deals one card by default" do
      subject.deal.count == 1
    end

    it "decreases the number of cards in the deck" do
      original_count = subject.count
      subject.deal(5)
      subject.count.should == original_count - 5
    end

    it "removes dealt cards from the deck" do
      card = subject.deal(1).first
      subject.cards.should_not include(card)
    end

    it "raises an error if the number requested exceeds what's left" do
      expect { subject.deal(60) }.to raise_error(OutOfCardsError)
    end
  end
end