require "rspec"
require 'chingu'

require File.dirname(__FILE__) + '/../lib/game'
require File.dirname(__FILE__) + '/../lib/level4'


describe "Level4" do

  before(:all) do
    @game = Game.new
  end

  after(:all) do
    @game.close
  end

  describe "features" do

    before(:each) do
      @level      = Level4.new
      @level.game = @game

      @lem        = @level.lem
    end

    specify "all features of level 1" do
      Level3.new.is_a?(Level1).should be_true
    end

    specify "title" do
      @level.title.should == "Level 4"
    end

  end

  describe "passenger" do

    before(:each) do
      @level      = Level4.new
      @level.game = @game

      @lem        = @level.lem
      @passenger  = @level.passenger
    end

    specify "is waiting on start platform" do
      start = @level.start
      @level.passenger_on?(start).should be_true
      @level.passenger.x.should == (@lem.x - @lem.width - 10)
    end

  end

  describe "is done" do

    before(:each) do
      @level      = Level4.new
      @level.game = @game

      @lem        = @level.lem
      @start      = @level.start
      @target     = @level.target
    end

    specify "when the lem is on the target platform with engine stopped and passenger" do
      given_the_lem_is_on_the_platform(@target)
      given_the_engine_is_stopped
      @level.update_done
      @level.done.should == false
    end

  end

  describe "is lost" do

    before(:each) do
      @level      = Level4.new
      @level.game = @game

      @lem        = @level.lem
    end

    specify "when lem is out of screen" do
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
      @level      = Level4.new
      @level.game = @game

      @lem        = @level.lem
      @start      = @level.start
    end

    specify "lem restarts above start platform" do
      @level.reset
      @level.lem.x.should == @start.x
    end

  end


end