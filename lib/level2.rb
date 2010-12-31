require File.dirname(__FILE__) + '/lem'
require File.dirname(__FILE__) + '/platform'
require File.dirname(__FILE__) + '/level1'

class Level2 < Level1

  attr_accessor :gauge, :gauge_label

  def initialize(options = {})
    super
    @title = 'Level 2'
    @gauge       = Chingu::Text.create(:text => "gauge", :x => 50, :y => 50, :size =>20, :color => Color::AQUA)
    @gauge_label = Chingu::Text.create(:text => "Fuel:", :x => 5, :y => 50, :size =>20, :color => Color::AQUA)

  end

  def update
    super
    @gauge.text = @lem.fuel.to_s
  end


end