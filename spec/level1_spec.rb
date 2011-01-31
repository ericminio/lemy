require "rspec"
require 'chingu'

require File.dirname(__FILE__) + '/../test/helpers'
require File.dirname(__FILE__) + '/../lib/game'
require File.dirname(__FILE__) + '/../lib/level1'

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

    specify "lem start position" do
      @lem.x.should == 50
      @lem.y.should == 200
    end

    specify "target platform is at he other side of the screen" do
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

    specify "when the lem is on the target platform" do
      Having.object(@lem).on_the_platform(@target)
      @level.update_done

      @level.done.should be_true
    end

    specify "unless the lem is not on the target platform" do
      NotHaving.object(@lem).on_the_platform(@target)
      @level.update_done

      @level.done.should be_false
    end

    specify "when the lem is on the target platform unless engine is started" do
      Having.object(@lem).on_the_platform(@target)
      @lem.start_vertical_engine
      @level.update_done

      @level.done.should be_false
    end

  end

  describe "is lost" do

    before(:each) do
      @level      = Level1.new
      @level.game = @game
      @lem        = @level.lem
      @level.lost.should be_false
    end

    specify "when lem is beyond the right border of the screen" do
      @lem.x = @game.width
      @lem.y = 0
      @level.update_lost
      @level.lost.should be_true
    end

    specify "when lem is below the bottom border of the screen" do
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
      @level.reset
    end

    specify "lem start position" do
      @lem.x.should == 50
      @lem.y.should == 200
    end

    specify "fuel is not an issue" do
      @lem.fuel.should == 10000000
    end

  end


end