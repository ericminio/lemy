class Lem < Chingu::GameObject

  def initialize(options = {})
    super
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

end


