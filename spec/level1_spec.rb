require "rspec"
require 'chingu'

require File.dirname(__FILE__) + '/../lib/game'
require File.dirname(__FILE__) + '/../lib/level1'

def given_the_lem_is_on_the_platform(platform)
  @lem.y = platform.y - @lem.height
  @lem.x = platform.x
  keep_current_position
end

def given_the_lem_is_not_in_the_platform(platform)
  given_the_lem_is_on_the_platform(platform)
  @lem.y -= 1
end

def given_the_engine_is_started
  @lem.start_vertical_engine
end

def given_the_engine_is_stopped
  @lem.stop_vertical_engine
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
      @level      = Level1.new
      @level.game = @game

      @lem        = @level.lem
      @start      = @level.start
      @target     = @level.target
    end

    specify "title" do
      @level.title.should == "Level 1"
    end

    specify "start platform position" do
      @start.x.should == 50
      @start.y.should == 400
    end

    specify "lem and start platform are aligned" do
      @lem.x.should == @start.x
    end

    specify "start platform is below lem" do
      @start.y.should > @lem.y
    end

    specify "target platform is far away" do
      @target.x.should == 600
      @target.y.should == 100
    end

    specify "fuel is not an issue" do
      @lem.fuel.should == 10000000
    end

  end

  describe "is done" do

    before(:each) do
      @level      = Level1.new
      @level.game = @game

      @lem        = @level.lem
      @start      = @level.start
      @target     = @level.target
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

  end

  describe "is lost" do

    before(:each) do
      @level      = Level1.new
      @level.game = @game
      @lem        = @level.lem
    end

    specify "when lem out of screen" do
      @lem.x = @game.width
      @lem.y = 0
      @level.update_lost
      @level.lost.should be_true

      @lem.x = 0
      @lem.y = @game.height
      @level.update_lost
      @level.lost.should be_true
    end

  end

  describe "reset" do

    before(:each) do
      @level      = Level1.new
      @level.game = @game
      @lem        = @level.lem
    end

    specify "lem is above start platform" do
      @level.reset
      @lem.x.should == 50
      @lem.y.should == 200
    end

    specify "fuel is not an issue" do
      @level.reset
      @lem.fuel.should == 10000000
    end

  end


end