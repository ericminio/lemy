require "rspec"
require 'chingu'

require File.dirname(__FILE__) + '/../lib/game'
require File.dirname(__FILE__) + '/../lib/level2'
require File.dirname(__FILE__) + '/../lib/level1'
require File.dirname(__FILE__) + '/../lib/level3'

describe "Level3" do

  before(:all) do
    @game = Game.new
  end

  after(:all) do
    @game.close
  end

  start_fuel_level = Lem::TANK_CAPACITY / 2

  describe "features" do

    before(:each) do
      @level      = Level3.new
      @level.game = @game

      @lem        = @level.lem
    end

    specify "all features of level 2" do
      Level3.new.is_a?(Level2).should be_true
    end

    specify "title" do
      @level.title.should == "Level 3"
    end

    specify "lem starts with half full tank" do
      @lem.fuel.should == start_fuel_level
    end

    specify "there is a station platform" do
      @station = @level.station
      @station.x.should == 50
      @station.y.should == 150
      @level.platforms.include?(@station).should be_true
    end

    specify "landing on the station refills" do
      having_on_the_platform(@level.station, @lem)
      @level.update
      @lem.fuel.should == Lem::TANK_CAPACITY
    end

  end

  describe "is lost" do

    before(:each) do
      @level      = Level3.new
      @level.game = @game

      @lem        = @level.lem
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

  describe "reset" do

    before(:each) do
      @level      = Level3.new
      @level.game = @game

      @lem        = @level.lem
    end

    specify "lem restarts with half full tank" do
      @level.reset
      @lem.fuel.should == start_fuel_level
    end

  end

end