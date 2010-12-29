require "rspec"
require 'chingu'

require File.dirname(__FILE__) + '/../lib/game'

def given_the_lem_is_on_the_platform(platform)
  @lem.y = platform.y - @lem.height
  @lem.x = platform.x
  keep_current_position
end

def keep_current_position
  @kept_position = {:x => @lem.x, :y => @lem.y}
end

def current_position
  { :x => @lem.x, :y => @lem.y}
end

describe "Game" do

  before(:each) do
    @game = Game.new
    @lem = @game.lem
    @start = @game.start
    @target = @game.target
  end

  after(:each) do
    @game.close
  end

  specify "player inputs" do
    @lem.input[:holding_up_arrow].first.should == @lem.method(:start_vertical_engine)
    @lem.input[:released_up_arrow].first.should == @lem.method(:stop_vertical_engine)
    @lem.input[:holding_right_arrow].first.should == @lem.method(:start_right_engine)
    @lem.input[:released_right_arrow].first.should == @lem.method(:stop_right_engine)
  end

  specify "platforms should be visible" do
    @game.platforms.each do|platform|
      platform.x.should > 0
      platform.y.should > 0
      platform.x.should < 640
      platform.y.should < 480
    end
  end

  specify "lem and start platform should be aligned" do
    @lem.x.should == @start.x
  end

  specify "start platform should be below lem" do
    @start.y.should > @lem.y
  end

  specify "lem should fall when the game starts" do
    keep_current_position
    @game.update
    current_position[:y].should > @kept_position[:y]
  end

  specify "lem should fall unless landed on a platform" do
    given_the_lem_is_on_the_platform(@start)
    @game.update
    current_position.should == @kept_position
  end

  specify "lem should move up when the engine is started" do
    @lem.start_vertical_engine
    keep_current_position
    @game.update
    current_position[:y].should < @kept_position[:y]
  end

  specify "lem can take off from a platform" do
    given_the_lem_is_on_the_platform(@start)
    @lem.start_vertical_engine
    @game.update
    current_position[:y].should < @kept_position[:y]
  end

  specify "there is 2 platforms" do
    @game.platforms.size.should == 2
  end

  specify "lem can land on target platform" do
    given_the_lem_is_on_the_platform(@target)
    @game.update
    current_position.should == @kept_position
  end

  specify "lem should move right when right engine is started" do
    @lem.start_right_engine
    keep_current_position
    @game.update
    current_position[:x].should > @kept_position[:x]
  end


end