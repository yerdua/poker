require 'rspec'
require 'card'

describe "Card" do
  context "valid value and symbol" do
    subject(:card) { Card.new(6, :clubs) }

    it "has the correct value" do
      card.value.should == 6
    end

    it "has the correct symbol" do
      card.symbol.should == :clubs
    end

    it "assigns colors correctly" do
      card.color.should == :red
    end
  end

  it "can't be initialized with an invalid value" do
    expect { Card.new(20, :diamonds) }.to raise_error(ArgumentError)
  end

  it "can't be initialized with an invalid symbol"
end