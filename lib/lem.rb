class Lem < Chingu::GameObject

  attr_accessor :engine_started

  def stop_engine
    @engine_started = false
    @image = Image["spaceship.png"]
  end

  def start_engine
    @engine_started = true
    @image = Image["spaceshipengineon.png"]
  end

  def thrust
    @engine_started ? 6 : 0;
  end

end


