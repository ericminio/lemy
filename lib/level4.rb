require File.dirname(__FILE__) + '/level1'
require File.dirname(__FILE__) + '/passenger'
require File.dirname(__FILE__) + '/seat'

class Level4 < Level1

  attr_accessor :seat, :passenger, :passenger_loaded

  has_traits :timer

  def initialize(options = {})
    super
    @title     = 'Level 4'
    @passenger = Passenger.create()
    @seat      = Seat.create(:x => 20, :y =>100)
    init_level4
  end

  def reset
    init_level4
  end

  def init_level4
    @done             = false
    @lost             = false
    @lem.x            = 50
    @lem.y            = 200
    @platforms        = [@start, @target]
    @lem.fuel         = 10000000
    @passenger_loaded = false
    @passenger.x, @passenger.y = @start.x - @lem.width - 10, @start.y - @passenger.height
  end

  def update_lost
    @lost = (@lem.x >= @game.width) | (@lem.y >= @game.height)
  end

  def update_done
    @done = (lem_on?(@target) & !@lem.vertical_engine_started & @passenger_loaded)
  end

  def update_passenger_loaded
    lem_rect          = Rect.new(@lem.x, @lem.y, 20, 20)
    passenger_rect    = Rect.new(@passenger.x, @passenger.y, 20, 20)
    @passenger_loaded |= lem_rect.collide_rect?(passenger_rect)
  end

  def update
    super

    if update_passenger_loaded
      @passenger.x = @seat.x
      @passenger.y = @seat.y
    end

    if update_done
      @passenger_loaded = false
      @passenger.x, @passenger.y = @lem.x + @lem.width/2 + @passenger.width/2 +5, @target.y - @passenger.height
      during(2000) { @passenger.x += 1 }
    end
  end


end