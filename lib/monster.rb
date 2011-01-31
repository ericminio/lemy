include Chingu

class Monster < Chingu::GameObject

  attr_accessor :width, :height

  def initialize(options = {})
    super
    @width = 20
    @height = 20
    @image = Image["monster.png"]
  end

end