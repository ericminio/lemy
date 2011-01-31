require "rspec"
require 'chingu'

require File.dirname(__FILE__) + '/helpers'
require File.dirname(__FILE__) + '/../lib/game'
require File.dirname(__FILE__) + '/../lib/level'

describe "Level" do

  before(:all) do
    @game = Game.new
  end

  after(:all) do
    @game.close
  end

  describe "features" do

    before(:each) do
      @level = @game.level
      @lem   = @level.lem
      @lem.stop_vertical_engine
      @lem.stop_right_engine
      @lem.stop_left_engine
    end

    specify "lem falls when the game starts" do
      kept_position = {:x => @lem.x, :y => @lem.y}
      @level.update
      @lem.y.should > kept_position[:y]
    end

    specify "lem moves up when the engine is started" do
      @lem.start_vertical_engine
      kept_position = {:x => @lem.x, :y => @lem.y}
      @level.update
      @lem.y.should < kept_position[:y]
    end

    specify "lem does not fall when landed on a platform" do
      platform = Platform.create(:x => 100, :y => 100)
      @level.platforms << platform
      having_on_the_platform(platform, @lem)
      kept_position = {:x => @lem.x, :y => @lem.y}
      @level.update
      {:x => @lem.x, :y => @lem.y}.should == kept_position
    end

    specify "lem moves right when right engine is started" do
      @lem.start_right_engine
      kept_position = {:x => @lem.x, :y => @lem.y}
      @level.update
      @lem.x.should > kept_position[:x]
    end

    specify "lem moves left when left engine is started" do
      @lem.start_left_engine
      kept_position = {:x => @lem.x, :y => @lem.y}
      @level.update
      @lem.x.should < kept_position[:x]
    end

  end

  describe "reset" do

    before(:each) do
      @level = @game.level
    end

    specify "responds to :reset" do
      @level.should respond_to(:reset)
    end

    specify "not lost and not done" do
      @level.reset
      @level.done.should be_false
      @level.lost.should be_false
    end

    specify "player can move the lem again" do
      lem = @level.lem
      lem.input = {}
      @level.reset
      lem.input[:holding_up_arrow].first.should == lem.method(:start_vertical_engine)
      lem.input[:released_up_arrow].first.should == lem.method(:stop_vertical_engine)
      lem.input[:holding_right_arrow].first.should == lem.method(:start_right_engine)
      lem.input[:released_right_arrow].first.should == lem.method(:stop_right_engine)
      lem.input[:holding_left_arrow].first.should == lem.method(:start_left_engine)
      lem.input[:released_left_arrow].first.should == lem.method(:stop_left_engine)
    end

  end


end