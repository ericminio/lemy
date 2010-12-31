require File.dirname(__FILE__) + '/lem'
require File.dirname(__FILE__) + '/platform'


class Level < Chingu::GameState

  VERTICAL_GRAVITY = 3
  attr_accessor :lem, :done, :game, :title, :lost, :platforms

  def initialize(options = {})
    super
    @lem = Lem.create(:x => 200, :y => 200, :image => "spaceship.png")
  end

  def reset
    @done      = false
    @lost      = false
    @platforms = []
  end

  def lem_landed
    @platforms.select { |platform| lem_on?(platform) }.size > 0
  end

  def lem_on?(platform)
    (@lem.y + @lem.height) == platform.y &&
        @lem.x >= (platform.x - platform.width/2) &&
        @lem.x <= (platform.x + platform.width/2)
  end

  def vertical_gravity_effect
    lem_landed ? 0 : VERTICAL_GRAVITY
  end

  def update
    super

    @lem.y += vertical_gravity_effect - @lem.vertical_thrust
    @lem.x += @lem.horizontal_thrust

    @game.level_done if update_done
    @game.level_lost if update_lost
  end

  def update_done
    @done = false
  end

  def update_lost
    @lost = false
  end


end

