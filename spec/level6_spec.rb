require "rspec"
require 'chingu'

require File.dirname(__FILE__) + '/../test/helpers'
require File.dirname(__FILE__) + '/../lib/game'
require File.dirname(__FILE__) + '/../lib/level6'


describe "Level6" do

  before(:all) do
    @game = Game.new
  end

  after(:all) do
    @game.close
  end

  describe "features" do

    before(:each) do
      @level      = Level6.new
      @level.game = @game

      @lem        = @level.lem
      @monster    = @level.monster
    end

    specify "all features of level 5" do
      Level6.new.is_a?(Level5).should be_true
    end

    specify "title" do
      @level.title.should == "Level 6"
    end

    specify "there is a monster" do
      @level.monster.x.should == 200
      @level.monster.y.should == 150
    end

    specify "lost if lem collides the monster" do
      @lem.x, @lem.y = @monster.x, @monster.y
      @level.update_lost
      @level.lost.should be_true
    end

    specify "reset" do
      @monster.x, @monster.y = 2000, 2000
      @level.reset
      @level.monster.x.should == 200
      @level.monster.y.should == 150
    end

    specify "monster follows the lem along x axis" do
      @monster.x, @monster.y = 200, 150
      @lem.x, @lem.y = 300, @monster.y
      @level.update_monster_position
      @monster.x.should == 201

      @monster.x, @monster.y = 200, 150
      @lem.x, @lem.y = 100, @monster.y
      @level.update_monster_position
      @monster.x.should == 199
    end

    specify "monster follows the lem along y axis" do
      @monster.x, @monster.y = 200, 150
      @lem.x, @lem.y = @monster.x, 200
      @level.update_monster_position
      @monster.y.should == 151

      @monster.x, @monster.y = 200, 150
      @lem.x, @lem.y = @monster.x, 50
      @level.update_monster_position
      @monster.y.should == 149
    end

    specify "updates monster position every cycle" do
      @level.should_receive(:update_monster_position)
      @level.update
    end

    specify "monster stops when done" do
      @level.done = true
      kept_position = {:x => @monster.x, :y => @monster.y}
      @level.update_monster_position
      @monster.x.should == kept_position[:x]
      @monster.y.should == kept_position[:y]
    end

  end
end

