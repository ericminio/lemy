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
      @level       = Level2.new
      @level.game  = @game

      @lem         = @level.lem
      @gauge       = @level.gauge
      @gauge_label = @level.gauge_label
    end

    specify "all features of level 1" do
      Level2.new.is_a?(Level1).should be_true
    end

    specify "title" do
      @level.title.should == "Level 2"
    end

    specify "lem starts with full tank" do
      @lem.fuel.should == Lem::TANK_CAPACITY
    end

    specify "gauge display" do
      @gauge.x.should == 50
      @gauge.y.should == 50
      @gauge.size.should == 20
      @gauge.color.should == Color::AQUA

      @gauge_label.x.should == 5
      @gauge_label.y.should == 50
      @gauge_label.text.should == "Fuel:"
      @gauge_label.color.should == Color::AQUA
    end

    specify "gauge tracks lem's tank level" do
      @lem.fuel = 50
      @level.update
      @gauge.text.should == "50"
    end

  end

  describe "is lost" do

    before(:each) do
      @level       = Level2.new
      @level.game  = @game

      @lem         = @level.lem
    end

    specify "when fuel is empty and lem out of screen" do
      @lem.fuel = 0

      @lem.x    = @game.width
      @lem.y    = 0
      @level.update_lost
      @level.lost.should be_true

      @lem.x = 0
      @lem.y = @game.height
      @level.update_lost
      @level.lost.should be_true
    end

    specify "only when fuel is empty" do
      @lem.fuel = 1

      @lem.x    = @game.width
      @lem.y    = @game.height
      @level.update_lost
      @level.lost.should be_false
    end

  end


end