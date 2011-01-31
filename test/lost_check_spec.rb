require "rspec"
require 'chingu'

require File.dirname(__FILE__) + '/../lib/game'
require File.dirname(__FILE__) + '/../lib/level'

describe "Lost status generic update" do

  before(:all) do
    @game = Game.new
  end

  after(:all) do
    @game.close
  end

  before(:each) do
    @level = @game.level
    @lem   = @level.lem
  end

  specify "lost status is checked each cycle" do
    @level.should_receive(:update_lost)
    @level.update
  end

  specify "notifies the game when level is lost" do
    @level.should_receive(:update_lost).and_return(true)
    @game.should_receive(:level_lost)
    @level.update
  end

  specify "the player cannot move the lem when level is lost" do
    @level.should_receive(:update_lost).and_return(true)
    @level.update
    @lem.input.should == {}
  end

  specify "stops all engines when level is lost" do
    @lem.start_vertical_engine
    @lem.start_right_engine
    @lem.start_left_engine
    @level.should_receive(:update_lost).and_return(true)

    @level.update
    @lem.vertical_engine_started.should be_false
    @lem.left_engine_started.should be_false
    @lem.right_engine_started.should be_false
  end

end