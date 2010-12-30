require "rspec"
require 'chingu'

require File.dirname(__FILE__) + '/../lib/game'
require File.dirname(__FILE__) + '/../lib/level1'

describe "Game" do

  before(:all) do
    @game = Game.new
  end

  after(:all) do
    @game.close
  end

  specify "escape exists the game" do
    @game.input[:escape].first.should == @game.method(:exit)
  end

  specify "first level is level 1" do
    @game.game_state_manager.game_states.first.class.should == Level1
  end

end