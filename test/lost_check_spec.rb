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

end