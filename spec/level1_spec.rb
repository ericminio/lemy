require "rspec"
require 'chingu'

require File.dirname(__FILE__) + '/../lib/game'
require File.dirname(__FILE__) + '/../lib/level1'

def given_the_lem_is_on_the_platform(platform)
  @lem.y = platform.y - @lem.height
  @lem.x = platform.x
  keep_current_position
end

def keep_current_position
  @kept_position = {:x => @lem.x, :y => @lem.y}
end

def current_position
  {:x => @lem.x, :y => @lem.y}
end

describe "Level1" do

  before(:all) do
    @game = Game.new
  end

  after(:all) do
    @game.close
  end

  describe "discovering the game" do

    before(:each) do
      @level  = Level1.new

      @lem    = @level.lem
      @start  = @level.start
      @target = @level.target
    end

    specify "player inputs" do
      @lem.input[:holding_up_arrow].first.should == @lem.method(:start_vertical_engine)
      @lem.input[:released_up_arrow].first.should == @lem.method(:stop_vertical_engine)
      @lem.input[:holding_right_arrow].first.should == @lem.method(:start_right_engine)
      @lem.input[:released_right_arrow].first.should == @lem.method(:stop_right_engine)

      @level.input[:r].first.should == @level.method(:reset)
    end

    specify "platforms should be visible" do
      @level.platforms.each do |platform|
        platform.x.should > 0
        platform.y.should > 0
        platform.x.should < 640
        platform.y.should < 480
      end
    end

    specify "start platform position" do
      @start.x.should == 50
      @start.y.should == 400
    end

    specify "lem and start platform should be aligned" do
      @lem.x.should == @start.x
    end

    specify "start platform should be below lem" do
      @start.y.should > @lem.y
    end

    specify "lem should fall when the game starts" do
      keep_current_position
      @level.update
      current_position[:y].should > @kept_position[:y]
    end

    specify "lem should fall unless landed on a platform" do
      given_the_lem_is_on_the_platform(@start)
      @level.update
      current_position.should == @kept_position
    end

    specify "lem should move up when the engine is started" do
      @lem.start_vertical_engine
      keep_current_position
      @level.update
      current_position[:y].should < @kept_position[:y]
    end

    specify "lem can take off from a platform" do
      given_the_lem_is_on_the_platform(@start)
      @lem.start_vertical_engine
      @level.update
      current_position[:y].should < @kept_position[:y]
    end

    specify "there is 2 platforms" do
      @level.platforms.size.should == 2
    end

    specify "lem can land on target platform" do
      given_the_lem_is_on_the_platform(@target)
      @level.update
      current_position.should == @kept_position
    end

    specify "lem should move right when right engine is started" do
      @lem.start_right_engine
      keep_current_position
      @level.update
      current_position[:x].should > @kept_position[:x]
    end

    specify "reset re-fill the lem" do
      @lem.should_receive(:refill)
      @level.reset
    end

  end

  describe "gauge" do

    before(:each) do
      @level  = Level1.new

      @lem    = @level.lem
      @gauge  = @level.gauge
      @gauge_label = @level.gauge_label
    end

    specify "display" do
      @gauge.x.should == 50
      @gauge.y.should == 50
      @gauge.size.should == 20

      @gauge_label.x.should == 5
      @gauge_label.y.should == 50
      @gauge_label.text.should == "Fuel:"
    end

    specify "track lem's tank level" do
      @lem.fuel = 50
      @level.update
      @gauge.text.should == "50"
    end

    specify "resets when fuel 0" do
      @level.should_receive(:reset)
      @lem.fuel = 0
      @level.update
    end

  end

end