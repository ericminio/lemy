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

  specify "player inputs" do
    lem = Lem.new
    lem.input[:holding_up_arrow].first.should == lem.method(:start_vertical_engine)
    lem.input[:released_up_arrow].first.should == lem.method(:stop_vertical_engine)
    lem.input[:holding_right_arrow].first.should == lem.method(:start_right_engine)
    lem.input[:released_right_arrow].first.should == lem.method(:stop_right_engine)
    lem.input[:holding_left_arrow].first.should == lem.method(:start_left_engine)
    lem.input[:released_left_arrow].first.should == lem.method(:stop_left_engine)
  end

  describe "Engines" do
    before(:each) do
      @lem = Lem.new
    end

    it "don't display engine when engine is off" do
      @lem.stop_vertical_engine
      @lem.image.name.should == "spaceship.png"
    end

    it "displays engine when engine is on" do
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

    specify "horizontal thrust is 3 when right engine is started, 0 otherwise" do
      @lem.start_right_engine
      @lem.horizontal_thrust.should == 3
      @lem.stop_right_engine
      @lem.horizontal_thrust.should == 0
    end

    specify "horizontal thrust is -3 when left engine is started, 0 otherwise" do
      @lem.start_left_engine
      @lem.horizontal_thrust.should == -3
      @lem.stop_left_engine
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

    specify "don't decrease when engine is stopped" do
      @lem.stop_vertical_engine
      @lem.update
      @lem.fuel.should == Lem::TANK_CAPACITY
    end

    specify "can be refilled" do
      @lem.fuel = Lem::TANK_CAPACITY / 2
      @lem.refill
      @lem.fuel.should == Lem::TANK_CAPACITY
    end

  end

  describe "End of fuel" do

    before(:each) do
      @lem = Lem.new
    end

    specify "engine stops when fuel is empty" do
      @lem.start_vertical_engine
      @lem.fuel = 1
      @lem.update
      @lem.engine_started.should be_false
    end

    specify "cannot start engine when fuel is empty" do
      @lem.fuel = 0
      @lem.start_vertical_engine
      @lem.engine_started.should be_false
    end

  end


end
