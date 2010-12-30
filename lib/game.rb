#!/usr/bin/env ruby
require 'rubygems' rescue nil
require 'chingu'
include Gosu
Image.autoload_dirs << File.dirname(__FILE__) + "/../media"

require File.dirname(__FILE__) + '/level1'

class Game < Chingu::Window

  def initialize
    super(640, 480, false)
    self.input = {:escape => :exit}
    @level = Level1.new
    push_game_state(@level)
  end

end

