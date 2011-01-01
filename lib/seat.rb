include Chingu

class Seat < Chingu::GameObject


  def initialize(options = {})
    super
  end

  def draw
    $window.draw_circle(@x, @y, 20, Color::GREEN)
  end

end