require "rspec"
require 'chingu'

require File.dirname(__FILE__) + '/helpers'
require File.dirname(__FILE__) + '/../lib/game'
require File.dirname(__FILE__) + '/../lib/level'

describe "Generic Done status update" do

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

  specify "done status is checked each cycle" do
    @level.should_receive(:update_done)
    @level.update
  end

  specify "notifies the game when level is done" do
    @level.should_receive(:update_done).and_return(true)
    @game.should_receive(:level_done)
    @level.update
  end

  specify "the player cannot move the lem when level is done" do
    @level.should_receive(:update_done).and_return(true)
    @level.update
    @lem.input.should == {}
  end

  specify "stops all engines when level is done" do
    @lem.start_vertical_engine
    @lem.start_right_engine
    @lem.start_left_engine
    @level.should_receive(:update_done).and_return(true)

    @level.update
    @lem.vertical_engine_started.should be_false
    @lem.left_engine_started.should be_false
    @lem.right_engine_started.should be_false
  end

end