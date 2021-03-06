class Lem < Chingu::GameObject

  TANK_CAPACITY = 200
  attr_accessor :fuel, :vertical_engine_started, :left_engine_started, :right_engine_started

  def initialize(options = {})
    super
    init_inputs
    refill
  end

  def init_inputs
    self.input = {:holding_up     => :start_vertical_engine,
                  :released_up    => :stop_vertical_engine,
                  :holding_right  => :start_right_engine,
                  :released_right => :stop_right_engine,
                  :holding_left  => :start_left_engine,
                  :released_left => :stop_left_engine
    }
  end

  def stop_vertical_engine
    @vertical_engine_started = false
    @image          = Image["spaceship.png"]
  end

  def start_vertical_engine
    if @fuel > 0
      @vertical_engine_started = true
      @image          = Image["spaceshipengineon.png"]
    end
  end

  def vertical_thrust
    @vertical_engine_started ? 6 : 0;
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

  def stop_all_engines
    stop_left_engine
    stop_right_engine
    stop_vertical_engine
  end

  def all_engines_stopped?
    !@left_engine_started & !@vertical_engine_started & !@right_engine_started
  end

  def horizontal_thrust
    thrust = 0
    thrust += 3 if @right_engine_started
    thrust -= 3 if @left_engine_started
    thrust
  end

  def update
    @fuel -= 1 if @vertical_engine_started
    stop_vertical_engine if @fuel == 0
  end

  def refill
    @fuel = TANK_CAPACITY
  end

end


