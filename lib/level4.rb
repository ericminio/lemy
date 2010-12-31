require File.dirname(__FILE__) + '/lem'
require File.dirname(__FILE__) + '/platform'
require File.dirname(__FILE__) + '/level1'
require File.dirname(__FILE__) + '/passenger'

class Level4 < Level1

  attr_accessor :gauge, :gauge_label, :passenger, :passenger_loaded

  def initialize(options = {})
    super
    @title = 'Level 4'
    @passenger = Passenger.create()
    @passenger.x, @passenger.y = @start.x - @lem.width - 10, @start.y - @passenger.height
    @passenger_loaded = false
    reset
  end

  def passenger_on?(platform)
    (@passenger.y + @passenger.height) == platform.y &&
        @passenger.x >= (platform.x - platform.width/2) &&
        @passenger.x <= (platform.x + platform.width/2)
  end

  def update_lost
    @lost = (@lem.x >= @game.width) | (@lem.y >= @game.height)
  end

  def update_done
    @done = (lem_on?(@target) & !@lem.engine_started & @passenger_loaded)
  end


end