require File.dirname(__FILE__) + '/lem'
require File.dirname(__FILE__) + '/platform'
require File.dirname(__FILE__) + '/level'

class Level1 < Level

  attr_accessor :start, :target

  def initialize(options = {})
    super
    @title     = "Level 1"
    @start     = Platform.create(:x => 50, :y => 400)
    @target    = Platform.create(:x => 600, :y => 100)
    reset
  end

  def reset
    super
    @platforms = [@start, @target]
    @lem.x = 50
    @lem.y = 200
    @lem.fuel = 10000000
  end

  def update_done
    @done |= (lem_on?(@target) & !@lem.engine_started)
  end

  def update_lost
    @lost = (@lem.x >= @game.width) | (@lem.y >= @game.height)
  end

end

