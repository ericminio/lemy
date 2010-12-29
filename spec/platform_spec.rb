require "rspec"
require 'chingu'

require File.dirname(__FILE__) + '/../lib/game'

describe "platform" do

  before(:each) do
    @game = Game.new
  end

  after(:each) do
    @game.close
  end

  it "should be visible" do
    @game.platform.x.should > 0
    @game.platform.y.should > 0
    @game.platform.x.should < 640
    @game.platform.y.should < 480
  end



end