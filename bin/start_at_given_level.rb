require File.dirname(__FILE__) + '/../lib/game'
require File.dirname(__FILE__) + '/../lib/level3'

game = Game.new

level = Level3.new
game.activate_level(level)

game.show