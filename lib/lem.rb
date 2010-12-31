class Lem < Chingu::GameObject

  TANK_CAPACITY = 200
  attr_accessor :fuel, :engine_started

  def initialize(options = {})
    super
    self.input = {:holding_up     => :start_vertical_engine,
                  :released_up    => :stop_vertical_engine,
                  :holding_right  => :start_right_engine,
                  :released_right => :stop_right_engine,
                  :holding_left  => :start_left_engine,
                  :released_left => :stop_left_engine
    }

    refill
  end

  def stop_vertical_engine
    @engine_started = false
    @image          = Image["spaceship.png"]
  end

  def start_vertical_engine
    if @fuel > 0
      @engine_started = true
      @image          = Image["spaceshipengineon.png"]
    end
  end

  def vertical_thrust
    @engine_started ? 6 : 0;
  end

  def start_right_engine
    @right_engine_started = true
  end

  def stop_right_engine
    @right_engine_started = false
  end

  def start_left_engine
    @left_engine_started = true
  end

  def stop_left_engine
    @left_engine_started = false
  end

  def horizontal_thrust
    thrust = 0
    thrust += 3 if @right_engine_started
    thrust -= 3 if @left_engine_started
    thrust
  end

  def update
    @fuel -= 1 if @engine_started
    stop_vertical_engine if @fuel == 0
  end

  def refill
    @fuel = TANK_CAPACITY
  end

end


