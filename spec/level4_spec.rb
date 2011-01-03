require "rspec"
require 'chingu'

require File.dirname(__FILE__) + '/../test/helpers'
require File.dirname(__FILE__) + '/../lib/game'
require File.dirname(__FILE__) + '/../lib/level4'


describe "Level4" do

  before(:all) do
    @game = Game.new
  end

  after(:all) do
    @game.close
  end

  describe "features" do

    before(:each) do
      @level      = Level4.new
      @level.game = @game

      @lem        = @level.lem
    end

    specify "all features of level 1" do
      Level4.new.is_a?(Level1).should be_true
    end

    specify "title" do
      @level.title.should == "Level 4"
    end

    specify "there is a passenger" do
      @level.passenger.should_not be_nil
    end

    specify "there is a seat view" do
      @level.seat.should_not be_nil
    end

    specify "fuel is not an issue" do
      @lem.fuel.should == 10000000
    end

  end

  describe "passenger" do

    before(:each) do
      @level      = Level4.new
      @level.game = @game

      @lem        = @level.lem
      @passenger  = @level.passenger
      @start      = @level.start
    end

    specify "is waiting on start platform" do
      object_on_platform?(@passenger, @level.start).should be_true
      @level.passenger.x.should == (@lem.x - @lem.width - 10)
    end

    specify "loading the passenger in the lem" do
      @lem.x = @passenger.x + 1
      @lem.y = @passenger.y
      @level.update_passenger_loaded.should be_true
    end

    specify "the passenger is no longer on the start platform after being loaded" do
      @lem.x = @passenger.x + 1
      @lem.y = @passenger.y
      @level.update
      object_on_platform?(@passenger, @start).should be_false
    end

    specify "loaded passenger stays in the lem" do
      @lem.x = @passenger.x + 1
      @lem.y = @passenger.y
      @level.update
      @level.update
      @level.update_passenger_loaded.should be_true
    end

  end

  describe "seat" do

    before(:each) do
      @level      = Level4.new
      @level.game = @game

      @lem        = @level.lem
      @passenger  = @level.passenger
      @seat       = @level.seat
    end

    specify "position" do
      @seat.x.should == 20
      @seat.y.should == 100
    end

    specify "the passenger is on the seat when loaded in the lem" do
      @level.stub!(:update_passenger_loaded).and_return(true)
      @level.update
      @passenger.x.should == @seat.x
      @passenger.y.should == @seat.y
    end

  end

  describe "is done" do

    before(:each) do
      @level      = Level4.new
      @level.game = @game

      @lem        = @level.lem
      @start      = @level.start
      @target     = @level.target
      @passenger  = @level.passenger
    end

    specify "when the lem is on the target platform with engine stopped and passenger" do
      having_on_the_platform(@target, @lem)
      @lem.stop_vertical_engine

      @level.passenger_loaded = false
      @level.update_done
      @level.done.should == false

      @level.passenger_loaded = true
      @level.update_done
      @level.done.should == true
    end

    specify "passenger goes down the lem when lem on target platform" do
      @lem.x = @passenger.x
      @lem.y = @passenger.y
      @level.update
      having_on_the_platform(@target, @lem)
      @level.update
      @level.passenger_loaded.should be_false
      object_on_platform?(@passenger, @target).should be_true
    end

  end

  describe "is lost" do

    before(:each) do
      @level      = Level4.new
      @level.game = @game

      @lem        = @level.lem
    end

    specify "when lem is out of screen" do
      @lem.x = @game.width
      @lem.y = 0
      @level.update_lost
      @level.lost.should be_true

      @lem.x = 0
      @lem.y = @game.height
      @level.update_lost
      @level.lost.should be_true
    end

  end


  describe "reset" do

    before(:each) do
      @level      = Level4.new
      @level.game = @game

      @lem        = @level.lem
      @start      = @level.start
      @passenger  = @level.passenger

      @lem.x      = @passenger.x
      @lem.y      = @passenger.y
      @level.update
      @level.reset
      @level.update
    end

    specify "lem restarts above start platform" do
      @level.lem.x.should == @start.x
    end

    specify "lem is empty" do
      @level.passenger_loaded.should be_false
    end

    specify "passenger is on the start platform" do
      object_on_platform?(@passenger, @start).should be_true
    end

  end


end