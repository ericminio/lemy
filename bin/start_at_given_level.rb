require File.dirname(__FILE__) + '/../lib/game'
require File.dirname(__FILE__) + '/../lib/level4'

game = Game.new

level = Level4.new
game.activate_level(level)

game.show