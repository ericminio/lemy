require "rspec"
require 'chingu'

require File.dirname(__FILE__) + '/../lib/game'
require File.dirname(__FILE__) + '/../lib/level1'

describe "Game" do

  before(:each) do
    @game = Game.new
  end

  after(:each) do
    @game.close
  end

  specify "escape exists the game" do
    @game.input[:escape].first.should == @game.method(:exit)
  end

  specify "first level is level 1" do
    @game.game_state_manager.game_states.first.class.should == Level1
  end

  specify "second level is level 2" do
    @game.next_level
    @game.level.class.should == Level2
  end

  specify "title indicates when level is completed" do
    @game.level_done
    @game.title.text.should == 'Level 1 completed'
    @game.title.color.should == Color::GREEN
  end

  specify "next level availability mention is hidden" do
    @game.next_level_available_mention.color.should == Color::BLACK
  end

  specify "indicates next level is available when level is done" do
    @game.level_done
    @game.next_level_available_mention.color.should == Color::GREEN
  end

  specify "hides the next level availability mention when level starts" do
    @game.level_done
    @game.activate_level(Level2.new)
    @game.next_level_available_mention.color.should == Color::BLACK
  end

  specify "indicates title of activated level" do
    level = Level2.new
    @game.activate_level(level)
    @game.title.text.should == level.title
    @game.title.color.should == Color::WHITE
  end

  specify "end of game if no more level" do
    @game.levels = []
    @game.level_done
    @game.next_level_available_mention.color.should == Color::BLACK
    @game.restart_mention.color.should == Color::GREEN
  end

  specify "restart mention is hidden when the game restart" do
    @game.levels = []
    @game.level_done
    @game.start
    @game.restart_mention.color.should == Color::BLACK
  end


end