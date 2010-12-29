require "rspec"
require 'chingu'

require File.dirname(__FILE__) + '/../lib/game'

def given_the_lem_is_on_the_platform
  @lem.y = @platform.y - @lem.height
  @lem.x = @platform.x
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
    @platform = @game.platform
  end

  after(:each) do
    @game.close
  end

  specify "lem and platform should be aligned" do
    @lem.x.should == @platform.x
  end

  specify "platform should be below lem" do
    @platform.y.should > @lem.y
  end

  specify "lem should fall when the game starts" do
    keep_current_position
    @game.update
    current_position[:y].should > @kept_position[:y]
  end

  specify "lem should fall unless landed on the platform" do
    given_the_lem_is_on_the_platform()
    @game.update
    current_position.should == @kept_position
  end

  it "lem should move up when the engine is started" do
    @lem.start_engine
    keep_current_position
    @game.update
    current_position[:y].should < @kept_position[:y]
  end

  it "lem can take off from the platform" do
    given_the_lem_is_on_the_platform()
    @lem.start_engine
    @game.update
    current_position[:y].should < @kept_position[:y]
  end

end