require File.dirname(__FILE__) + '/level3'

class Level5 < Level3

  attr_accessor :seat, :waiting, :passengers, :loaded_passenger

  has_traits :timer

  def initialize(options = {})
    super
    @title   = 'Level 5'
    @seat    = Seat.create(:x => 20, :y =>100)
    @waiting = Platform.create(:x => 50, :y => 250)
    @first   = Passenger.create()
    @second  = Passenger.create()
    init_level5
  end

  def reset
    super
    init_level5
  end

  def init_level5
    @station.x, @station.y = 600, 400
    @lem.fuel   = Lem::TANK_CAPACITY
    @platforms  = [@start, @target, @station, @waiting]
    @lem.x      = 50
    @lem.y      = 280
    @passengers = [@first, @second]
    @first.x, @first.y = @waiting.x, @waiting.y - @first.height
    @second.x, @second.y = @waiting.x - @second.width - 5, @waiting.y - @second.height
    @loaded_passenger = nil
  end

  def update_loaded_passenger
    return @loaded_passenger if @loaded_passenger
    lem_rect          = Rect.new(@lem.x, @lem.y, 20, 20)
    @loaded_passenger = @passengers.select { |passenger|
      lem_rect.collide_rect?(Rect.new(passenger.x, passenger.y, 20, 20))
    }.first
  end

  def update_done
    @done = !@loaded_passenger & (@first.x > @game.width) & (@second.x > @game.width)
  end

  def update
    super

    if update_loaded_passenger
      @loaded_passenger.x = @seat.x
      @loaded_passenger.y = @seat.y
    end

    if lem_on?(@target) & @lem.all_engines_stopped? & @loaded_passenger
      @loaded_passenger.x, @loaded_passenger.y = @lem.x + @lem.width/2 + @loaded_passenger.width/2 +5, @target.y - @loaded_passenger.height
      leaving = @loaded_passenger
      @loaded_passenger = nil
      during(2000) { leaving.x += 1 }
    end
  end

end