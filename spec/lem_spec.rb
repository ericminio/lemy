require "rspec"
require 'chingu'

require File.dirname(__FILE__) + '/../lib/game'

describe "Lem" do

  before(:each) do
    @game = Game.new
    @lem = @game.lem
  end

  after(:each) do
    @game.close
  end

  it "does not display engine when engine is off" do
    @lem.stop_engine
    @lem.image.name.should == "spaceship.png"
  end

  it "does display engine when engine is on" do
    @lem.start_engine
    @lem.image.name.should == "spaceshipengineon.png"
  end
  
  it "thrust is 6 when the engine is started" do
    @lem.start_engine
    @lem.thrust.should == 6
  end

  it "thrust is 0 when engine is stopped" do
    @lem.stop_engine
    @lem.thrust.should == 0
  end

end
