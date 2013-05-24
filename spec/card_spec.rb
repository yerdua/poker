require 'rspec'
require 'card'

describe "Card" do
  context "valid value and symbol" do
    subject(:card) { Card.new(6, :clubs) }

    it "has the correct value" do
      card.value.should == 6
    end

    it "has the correct suit" do
      card.suit.should == :clubs
    end

    it "assigns colors correctly" do
      card.color.should == :black
    end
  end

  it "can't be initialized with an invalid value" do
    expect { Card.new(20, :diamonds) }.to raise_error(ArgumentError)
  end

  it "can't be initialized with an invalid symbol" do
    expect { Card.new(10, :nonsense) }.to raise_error(ArgumentError)
  end
end