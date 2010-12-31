require "rspec"
require 'chingu'

require File.dirname(__FILE__) + '/../lib/game'
require File.dirname(__FILE__) + '/../lib/level'

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

describe "Level" do

  before(:all) do
    @game = Game.new
  end

  after(:all) do
    @game.close
  end

  describe "features" do

    before(:each) do
      @level = @game.level
      @lem   = @level.lem
      @lem.stop_vertical_engine
    end

    specify "lem falls when the game starts" do
      keep_current_position
      @level.update
      current_position[:y].should > @kept_position[:y]
    end

    specify "lem moves up when the engine is started" do
      @lem.start_vertical_engine
      keep_current_position
      @level.update
      current_position[:y].should < @kept_position[:y]
    end

    specify "lem falls unless landed on a platform" do
      platform = Platform.create(:x => 100, :y => 100)
      @level.platforms << platform
      given_the_lem_is_on_the_platform(platform)
      @level.update
      current_position.should == @kept_position
    end

    specify "lem can take off from a platform" do
      platform = Platform.create(:x => 100, :y => 100)
      @level.platforms << platform
      given_the_lem_is_on_the_platform(platform)
      @lem.start_vertical_engine
      @level.update
      current_position[:y].should < @kept_position[:y]
    end

    specify "lem moves right when right engine is started" do
      @lem.start_right_engine
      keep_current_position
      @level.update
      current_position[:x].should > @kept_position[:x]
    end

  end

  describe "done" do

    before(:each) do
      @level = @game.level
    end

    specify "notifies the game" do
      @level.should_receive(:update_done).and_return(true)
      @game.should_receive(:level_done)
      @level.update
    end

  end

  describe "lost" do

    before(:each) do
      @level = @game.level
    end

    specify "notifies the game" do
      @level.should_receive(:update_lost).and_return(true)
      @game.should_receive(:level_lost)
      @level.update
    end
  end

  describe "reset" do

    before(:each) do
      @level = @game.level
    end

    specify "not lost and not done" do
      @level.reset
      @level.done.should be_false
      @level.lost.should be_false
    end
  end


end