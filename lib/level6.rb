require File.dirname(__FILE__) + '/level5'
require File.dirname(__FILE__) + '/monster'

class Level6 < Level5

  attr_accessor :monster

  def initialize(options = {})
    super
    @title   = 'Level 6'
    @monster   = Monster.create()
    reset
  end

  def reset
    super
    init_level6
  end

  def init_level6
    @monster.x, @monster.y = 200, 150
  end

  def update_lost
    super
    lem_rect = Rect.new(@lem.x, @lem.y, 20, 20)
    @lost |= lem_rect.collide_rect?(Rect.new(@monster.x, @monster.y, 20, 20))
  end

  def update_monster_position
    @monster.x += 1 if @lem.x > @monster.x unless @done
    @monster.x -= 1 if @lem.x < @monster.x unless @done

    @monster.y += 1 if @lem.y > @monster.y unless @done
    @monster.y -= 1 if @lem.y < @monster.y unless @done
  end

  def update
    super
    update_monster_position
  end

end