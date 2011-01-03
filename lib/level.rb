require File.dirname(__FILE__) + '/lem'
require File.dirname(__FILE__) + '/platform'


class Level < Chingu::GameState

  VERTICAL_GRAVITY = 3
  attr_accessor :lem, :done, :game, :title, :lost, :platforms

  def initialize(options = {})
    super
    @lem = Lem.create(:x => 200, :y => 200, :image => "spaceship.png")
    @platforms = []
  end

  def update_done
    @done = false
  end

  def update_lost
    @lost = false
  end

  def update
    super
    moves_lem
    update_done_and_lost
  end

  def moves_lem
    delta_y  = vertical_gravity_effect - @lem.vertical_thrust
    platform = will_land_on_a_platform(@lem.x, @lem.y, delta_y)
    if platform
      @lem.y = platform.y - @lem.height
    else
      @lem.y += delta_y
    end

    @lem.x += @lem.horizontal_thrust
  end

  def update_done_and_lost
    if update_done
      @game.level_done
      @lem.input = {}
      @lem.stop_all_engines
    end
    if update_lost
      @game.level_lost
    end
  end

  def vertical_gravity_effect
    lem_landed? ? 0 : VERTICAL_GRAVITY
  end

  def lem_landed?
    @platforms.select { |platform| lem_on?(platform) }.size > 0
  end

  def lem_on?(platform)
    (@lem.y + @lem.height) == platform.y &&
        @lem.x >= (platform.x - platform.width/2) &&
        @lem.x <= (platform.x + platform.width/2)
  end

  def will_land_on_platform?(platform, x, y, delta_y)
    (y + @lem.height) < platform.y &&
        (y + delta_y + @lem.height) > platform.y &&
        x >= (platform.x - platform.width/2) &&
        x <= (platform.x + platform.width/2)
  end

  def will_land_on_a_platform(x, y, delta_y)
    @platforms.select { |platform| will_land_on_platform?(platform, x, y, delta_y) }.first
  end

end

