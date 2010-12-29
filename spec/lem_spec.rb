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
    @lem.stop_vertical_engine
    @lem.image.name.should == "spaceship.png"
  end

  specify "does display engine when engine is on" do
    @lem.start_vertical_engine
    @lem.image.name.should == "spaceshipengineon.png"
  end
  
  specify "thrust is 6 when the engine is started" do
    @lem.start_vertical_engine
    @lem.vertical_thrust.should == 6
  end

  specify "thrust is 0 when engine is stopped" do
    @lem.stop_vertical_engine
    @lem.vertical_thrust.should == 0
  end

  specify "right thrust is 3 when left engine is started, 0 otherwise" do
    @lem.start_right_engine
    @lem.horizontal_thrust.should == 3
    @lem.stop_right_engine
    @lem.horizontal_thrust.should == 0
  end
  

end
