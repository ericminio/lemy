#!/usr/bin/env ruby
require 'rubygems' rescue nil
require 'chingu'
include Gosu
Image.autoload_dirs << File.dirname(__FILE__) + "/../media"

require File.dirname(__FILE__) + '/lem'
require File.dirname(__FILE__) + '/platform'

class Game < Chingu::Window

  attr_accessor :lem, :platform

  def initialize
    super(640, 480, false)
    self.input = {:escape => :exit}

    @lem       = Lem.create(:x => 200, :y => 200, :image => Image["spaceship.png"])
    @lem.input = {:holding_up    => :start_engine,
                  :released_up   => :stop_engine
    }
    @platform  = Platform.create(:x => 200, :y => 400, :image => Image["platform.png"])
  end

  def lem_landed
    landed = false
    landed = true if (@lem.y + @lem.height) >= @platform.y
    landed
  end

  def gravity
    lem_landed ? 0 : 3
  end

  def update
    super
    @lem.y += gravity - @lem.thrust
  end

end

