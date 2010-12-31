require File.dirname(__FILE__) + '/lem'
require File.dirname(__FILE__) + '/platform'


class Level1 < Chingu::GameState

  VERTICAL_GRAVITY = 3
  attr_accessor :lem, :done, :game, :title

  attr_accessor :start, :target

  def initialize(options = {})
    super
    @lem       = Lem.create(:x => 200, :y => 200, :image => "spaceship.png")
    @lem.x, @lem.y = 50, 200
    @done = false
    @lem.input = {:holding_up    => :start_vertical_engine,
                  :released_up   => :stop_vertical_engine,
                  :holding_right => :start_right_engine,
                  :released_right => :stop_right_engine
    }

    @start  = Platform.create(:x => 50, :y => 400, :image => Image["platform.png"])
    @target = Platform.create(:x => 600, :y => 100, :image => Image["platform.png"])
    @title = "Level 1"
  end

  def platforms
    [@start, @target]
  end

  def lem_landed
    platforms.select {|platform| lem_on?(platform) }.size > 0
  end

  def lem_on?(platform)
    (@lem.y + @lem.height) == platform.y &&
        @lem.x >= (platform.x - platform.width/2) &&
        @lem.x <= (platform.x + platform.width/2)
  end

  def vertical_gravity_effect
    lem_landed ? 0 : VERTICAL_GRAVITY
  end

  def update_done
    @done |= (lem_on?(@target) & !@lem.engine_started)
  end

  def update
    super

    @lem.y += vertical_gravity_effect - @lem.vertical_thrust
    @lem.x += @lem.horizontal_thrust

    update_done
    @game.level_done if @done
  end

end

