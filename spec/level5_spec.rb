require "rspec"
require 'chingu'

require File.dirname(__FILE__) + '/helpers'
require File.dirname(__FILE__) + '/../lib/game'
require File.dirname(__FILE__) + '/../lib/level5'


describe "Level5" do

  before(:all) do
    @game = Game.new
  end

  after(:all) do
    @game.close
  end

  describe "features" do

    before(:each) do
      @level      = Level5.new
      @level.game = @game
      @lem        = @level.lem
    end

    specify "all features of level 3" do
      Level5.new.is_a?(Level3).should be_true
    end

    specify "title" do
      @level.title.should == "Level 5"
    end

    specify "lem starts with full tank" do
      @level.lem.fuel.should == Lem::TANK_CAPACITY
    end

    specify "the gaz station is at the other side" do
      station = @level.station
      station.x.should == 600
      station.y.should == 400
    end

    specify "there is a seat view" do
      @level.seat.x.should == 20
      @level.seat.y.should == 100
      @level.loaded_passenger.should be_false
    end

    specify "there is a waiting platform" do
      @level.waiting.x.should == 50
      @level.waiting.y.should == 250
      @level.platforms.include?(@level.waiting).should be_true
    end

    specify "lem appears below the waiting platform" do
      @level.lem.y.should > (@level.waiting.y + @level.waiting.height)
      @level.lem.x.should == 50
    end

    specify "there is 2 passengers on the waiting platform" do
      @level.passengers.size.should == 2
      first = @level.passengers[0]
      object_on_platform?(first, @level.waiting).should be_true
      second = @level.passengers[1]
      object_on_platform?(second, @level.waiting).should be_true
      first.x.should_not == second.x
    end

    specify "the lem can only take one passenger" do
      first  = @level.passengers[0]
      second = @level.passengers[1]

      @lem.x = first.x + 1
      @lem.y = first.y
      @level.update
      first.x.should == @level.seat.x
      first.y.should == @level.seat.y
      @level.loaded_passenger.should == first

      @lem.x = second.x + 1
      @lem.y = second.y
      @level.update_loaded_passenger.should == first
      object_on_platform?(second, @level.waiting).should be_true
    end

    specify "passenger goes down the lem when the lem is on the target platform" do
      passenger  = @level.passengers[0]
      @lem.x = passenger.x
      @lem.y = passenger.y
      @level.update

      having_on_the_platform(@level.target, @lem)
      @level.update
      @level.loaded_passenger.should be_nil
      object_on_platform?(passenger, @level.target).should be_true
    end

    specify "passenger does not go down when engine is started" do
      @lem.start_vertical_engine
      passenger  = @level.passengers[0]
      @level.loaded_passenger = passenger
      @level.stub!(:lem_on?).and_return(true)
      
      @level.update
      @level.loaded_passenger.should == passenger
    end

    specify "is done when no passenger is waiting and last passenger has left the lem" do
      @level.done.should be_false
      @level.passengers.each { |passenger| passenger.x = @game.width + 1}
      @level.loaded_passenger = false
      @level.update_done
      @level.done.should be_true
    end

    specify "reset" do
      passenger  = @level.passengers[0]
      @lem.x = passenger.x
      @lem.y = passenger.y
      @level.update

      @level.reset
      @level.loaded_passenger.should be_nil
      object_on_platform?(@level.passengers[0], @level.waiting).should be_true
      object_on_platform?(@level.passengers[1], @level.waiting).should be_true
    end

  end
end

