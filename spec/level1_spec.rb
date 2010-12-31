require "rspec"
require 'chingu'

require File.dirname(__FILE__) + '/../lib/game'
require File.dirname(__FILE__) + '/../lib/level1'

def given_the_lem_is_on_the_platform(platform)
  @lem.y = platform.y - @lem.height
  @lem.x = platform.x
  keep_current_position
end

def given_the_engine_is_started
  @lem.start_vertical_engine
end

def given_the_engine_is_stopped
  @lem.stop_vertical_engine
end

def given_the_lem_is_not_in_the_target_platform
  given_the_lem_is_on_the_platform(@target)
  @lem.y -= 20
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

  describe "features" do

    before(:each) do
      @level  = Level1.new
      @level.game = @game

      @lem    = @level.lem
      @start  = @level.start
      @target = @level.target
    end

    specify "player inputs" do
      @lem.input[:holding_up_arrow].first.should == @lem.method(:start_vertical_engine)
      @lem.input[:released_up_arrow].first.should == @lem.method(:stop_vertical_engine)
      @lem.input[:holding_right_arrow].first.should == @lem.method(:start_right_engine)
      @lem.input[:released_right_arrow].first.should == @lem.method(:stop_right_engine)
    end

    specify "lem should fall when the game starts" do
      keep_current_position
      @level.update
      current_position[:y].should > @kept_position[:y]
    end

    specify "lem should move up when the engine is started" do
      @lem.start_vertical_engine
      keep_current_position
      @level.update
      current_position[:y].should < @kept_position[:y]
    end



    specify "lem should fall unless landed on a platform" do
      given_the_lem_is_on_the_platform(@start)
      @level.update
      current_position.should == @kept_position
    end

    specify "lem can take off from a platform" do
      given_the_lem_is_on_the_platform(@start)
      @lem.start_vertical_engine
      @level.update
      current_position[:y].should < @kept_position[:y]
    end




    specify "title" do
      @level.title.should == "Level 1"
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

    specify "target platform is far away" do
      @target.x.should == 600
      @target.y.should == 100
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


  end

  describe "done" do

    before(:each) do
      @level  = Level1.new
      @level.game = @game
      
      @lem    = @level.lem
      @start  = @level.start
      @target = @level.target
    end

    specify "when the lem is on the target platform with engine stopped" do
      given_the_lem_is_on_the_platform(@start)
      @level.update_done
      @level.done.should be_false

      given_the_lem_is_on_the_platform(@target)
      given_the_engine_is_started
      @level.update_done
      @level.done.should == false

      given_the_lem_is_on_the_platform(@target)
      given_the_engine_is_stopped
      @level.update_done
      @level.done.should == true
    end

    it "should remember when the level is done" do
      @level.done = true
      given_the_lem_is_not_in_the_target_platform
      @level.update_done
      @level.done.should be_true
    end

  end


end