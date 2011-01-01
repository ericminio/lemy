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
    $window.fill_rect([@x - @width/2, @y - @height/2, @width, @height], @color)
  end

end


