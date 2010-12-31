include Chingu

class Passenger < Chingu::GameObject

  attr_accessor :width, :height

  def initialize(options = {})
    super
    @width = 20
    @height = 20
    @image = Image["passenger.png"]
  end

end