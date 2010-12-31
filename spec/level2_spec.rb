require "rspec"
require 'chingu'

require File.dirname(__FILE__) + '/../lib/game'
require File.dirname(__FILE__) + '/../lib/level2'
require File.dirname(__FILE__) + '/../lib/level1'

describe "Level2" do

  before(:all) do
    @game = Game.new
  end

  after(:all) do
    @game.close
  end

  describe "features" do

    before(:each) do
      @level  = Level2.new

      @lem    = @level.lem
      @start  = @level.start
      @target = @level.target
    end

    specify "title" do
      @level.title.should == "Level 2"
    end

  end

  describe "gauge" do

    before(:each) do
      @level       = Level2.new

      @lem         = @level.lem
      @gauge       = @level.gauge
      @gauge_label = @level.gauge_label
    end

    specify "display" do
      @gauge.x.should == 50
      @gauge.y.should == 50
      @gauge.size.should == 20
      @gauge.color.should == Color::AQUA

      @gauge_label.x.should == 5
      @gauge_label.y.should == 50
      @gauge_label.text.should == "Fuel:"
      @gauge_label.color.should == Color::AQUA
    end

    specify "track lem's tank level" do
      @lem.fuel = 50
      @level.update
      @gauge.text.should == "50"
    end


  end


end