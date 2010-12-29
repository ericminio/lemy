#!/usr/bin/env ruby
require 'rubygems' rescue nil
require 'chingu'
include Gosu
Image.autoload_dirs << File.dirname(__FILE__) + "/../media"



require File.dirname(__FILE__) + '/lem'
require File.dirname(__FILE__) + '/platform'

class Game < Chingu::Window

  VERTICAL_GRAVITY = 3
  attr_accessor :lem, :start, :target

  def initialize
    super(640, 480, false)
    self.input = {:escape => :exit}

    @lem       = Lem.create(:x => 200, :y => 200, :image => Image["spaceship.png"])
    @lem.input = {:holding_up    => :start_vertical_engine,
                  :released_up   => :stop_vertical_engine,
                  :holding_right => :start_right_engine,
                  :released_right => :stop_right_engine
    }
    @start  = Platform.create(:x => 200, :y => 400, :image => Image["platform.png"])
    @target = Platform.create(:x => 600, :y => 100, :image => Image["platform.png"])
  end

  def platforms
    [@start, @target]
  end

  def lem_landed
    platforms.select {|platform| lem_on?(platform) }.size > 0
  end

  def lem_on?(platform)
    (@lem.y + @lem.height) >= platform.y &&
        @lem.x >= (platform.x - platform.width/2) &&
        @lem.x <= (platform.x + platform.width/2)
  end

  def vertical_gravity_effect
    lem_landed ? 0 : VERTICAL_GRAVITY
  end

  def update
    super
    @lem.y += vertical_gravity_effect - @lem.vertical_thrust
    @lem.x += @lem.horizontal_thrust
  end

end

