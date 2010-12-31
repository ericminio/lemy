include Chingu

class Platform < Chingu::GameObject

  attr_accessor :width, :height, :color

  def initialize(options = {})
    super
    @width  = 100
    @height = 20
    @color  = Gosu::Color::Constant.new(0xffff8800)
  end

  def draw
    fill_rect([@x - @width/2, @y - @height/2, @width, @height], @color)
  end

  def fill_rect(rect, color, zorder = 0)
    rect = Rect.new(rect) # Make sure it's a rect
    $window.draw_quad(rect.x, rect.y, color,
                      rect.right, rect.y, color,
                      rect.right, rect.bottom, color,
                      rect.x, rect.bottom, color,
                      zorder, :default)
  end

end


