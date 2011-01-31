require File.dirname(__FILE__) + '/lem'
require File.dirname(__FILE__) + '/platform'
require File.dirname(__FILE__) + '/level1'

class Level2 < Level1

  attr_accessor :gauge, :gauge_label

  def initialize(options = {})
    super
    @title       = 'Level 2'
    @gauge       = Chingu::Text.create(:text => "gauge", :x => 50, :y => 50, :size =>20, :color => Color::AQUA)
    @gauge_label = Chingu::Text.create(:text => "Fuel:", :x => 5, :y => 50, :size =>20, :color => Color::AQUA)
    init_level2
  end

  def reset
    super
    init_level2
  end

  def init_level2
    @done      = false
    @lost      = false
    @platforms = [@start, @target]
    @lem.x     = 50
    @lem.y     = 200
    @lem.fuel = Lem::TANK_CAPACITY
  end

  def update
    super
    @gauge.text = @lem.fuel.to_s
  end

  def update_lost
    @lost = (@lem.fuel == 0) & ((@lem.x >= @game.width) | (@lem.y >= @game.height))
  end


end