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

  specify "game levels" do
    #@game.all_levels.should == [Level6.new, Level5.new, Level4.new, Level3.new, Level2.new, Level1.new]
  end

  specify "escape exits the game" do
    @game.input[:escape].first.should == @game.method(:exit)
  end

  specify "first level is level 1" do
    @game.game_state_manager.game_states.first.class.should == Level1
  end

  specify "second level is level 2" do
    @game.next_level
    @game.level.class.should == Level2
  end

  specify "displays the title of the current level" do
    level = Level2.new
    @game.activate_level(level)
    @game.title.text.should == level.title
    @game.title.color.should == Color::WHITE
  end

  specify "displays when a level is done" do
    @game.level_done
    @game.title.text.should == 'Level 1 completed'
    @game.title.color.should == Color::GREEN
  end

  specify "don't display next level availability mention at start" do
    @game.next_level_available_mention.color.should == Color::BLACK
  end

  specify "displays next level availability when level is done" do
    @game.level_done
    @game.next_level_available_mention.color.should == Color::GREEN
  end

  specify "hides next level availability mention when level starts" do
    @game.level_done
    @game.activate_level(Level2.new)
    @game.next_level_available_mention.color.should == Color::BLACK
  end

  specify "display restart mention if end of game (no more level)" do
    @game.levels = []
    @game.level_done
    @game.next_level_available_mention.color.should == Color::BLACK
    @game.restart_mention.color.should == Color::GREEN
  end

  specify "hides restart mention when the game restart" do
    @game.levels = []
    @game.level_done
    @game.start
    @game.restart_mention.color.should == Color::BLACK
  end

  specify "displays when level is lost" do
    level = Level2.new
    @game.activate_level(level)
    @game.level_lost

    @game.title.text.should == level.title + ' lost'
    @game.title.color.should == Color::RED
    @game.restart_mention.color.should == Color::RED
  end

  specify "can retry the level when lost" do
    level = Level2.new
    @game.activate_level(level)
    @game.level_lost
    level.should_receive(:reset)
    @game.retry
    @game.title.color.should == Color::WHITE
    @game.restart_mention.color.should == Color::BLACK
  end


end