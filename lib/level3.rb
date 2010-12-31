require File.dirname(__FILE__) + '/lem'
require File.dirname(__FILE__) + '/level2'
require File.dirname(__FILE__) + '/station'

class Level3 < Level2

  attr_accessor :station

  def initialize(options = {})
    super
    @title       = 'Level 3'
    @station     = Station.create(:x => 50, :y => 150)
    reset
  end

  def reset
    super
    @platforms = [@start, @target, @station]
    @lem.fuel = 100
  end

  def update
    super
    @lem.refill if lem_on?(@station)
  end


end