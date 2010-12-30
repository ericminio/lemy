require "rspec"
require 'chingu'

require File.dirname(__FILE__) + '/../lib/game'
require File.dirname(__FILE__) + '/../lib/lem'

describe "Lem" do

  before(:all) do
    @game = Game.new
  end

  after(:all) do
    @game.close
  end

  describe "Engines" do
    before(:each) do
      @lem = Lem.new
    end

    it "does not display engine when engine is off" do
      @lem.stop_vertical_engine
      @lem.image.name.should == "spaceship.png"
    end

    it "does display engine when engine is on" do
      @lem.start_vertical_engine
      @lem.image.name.should == "spaceshipengineon.png"
    end

    specify "thrust is 6 when the engine is started" do
      @lem.start_vertical_engine
      @lem.vertical_thrust.should == 6
    end

    specify "thrust is 0 when engine is stopped" do
      @lem.stop_vertical_engine
      @lem.vertical_thrust.should == 0
    end

    specify "right thrust is 3 when left engine is started, 0 otherwise" do
      @lem.start_right_engine
      @lem.horizontal_thrust.should == 3
      @lem.stop_right_engine
      @lem.horizontal_thrust.should == 0
    end
  end

  describe "Fuel" do

    before(:each) do
      @lem = Lem.new
    end

    specify "is full at startup" do
      @lem.fuel.should == Lem::TANK_CAPACITY
    end

    specify "decreases when engine is started" do
      @lem.start_vertical_engine
      @lem.update
      @lem.fuel.should == Lem::TANK_CAPACITY - 1
    end

    specify "does not decrease when engine is stopped" do
      @lem.stop_vertical_engine
      @lem.update
      @lem.fuel.should == Lem::TANK_CAPACITY
    end

    specify "refill" do
      @lem.fuel = Lem::TANK_CAPACITY / 2
      @lem.refill
      @lem.fuel.should == Lem::TANK_CAPACITY
    end

  end


end
