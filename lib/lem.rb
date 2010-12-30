class Lem < Chingu::GameObject

  TANK_CAPACITY = 150
  attr_accessor :fuel

  def initialize(options = {})
    super
    refill
  end

  def stop_vertical_engine
    @engine_started = false
    @image = Image["spaceship.png"]
  end

  def start_vertical_engine
    @engine_started = true
    @image = Image["spaceshipengineon.png"]
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

  def horizontal_thrust
    @right_engine_started ? 3 : 0
  end

  def update
    @fuel -= 1 if @engine_started
  end

  def refill
    @fuel = TANK_CAPACITY
  end

end


