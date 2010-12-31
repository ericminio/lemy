require "rspec"
require 'chingu'

require File.dirname(__FILE__) + '/../lib/game'
require File.dirname(__FILE__) + '/../lib/level2'
require File.dirname(__FILE__) + '/../lib/level1'
require File.dirname(__FILE__) + '/../lib/level3'

def given_the_lem_is_on_the_platform(platform)
  @lem.y = platform.y - @lem.height
  @lem.x = platform.x
end

describe "Level3" do

  before(:all) do
    @game = Game.new
  end

  after(:all) do
    @game.close
  end

  start_with_fuel = 100

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

    specify "lem starts with minimal tank" do
      @lem.fuel.should == start_with_fuel
    end

  end

  describe "fuel station" do

    before(:each) do
      @level      = Level3.new
      @level.game = @game

      @lem        = @level.lem
      @station    = @level.station
    end

    specify "there is a station platform" do
      @station.x.should == 50
      @station.y.should == 150
      @station.color.should == Color::AQUA
    end

    specify "landing on the station refills" do
      given_the_lem_is_on_the_platform(@station)
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

    specify "lem restarts with minimal tank" do
      @level.reset
      @lem.fuel.should == start_with_fuel
    end

  end


end