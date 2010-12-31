#!/usr/bin/env ruby
require 'rubygems' rescue nil
require 'chingu'
include Gosu
Image.autoload_dirs << File.dirname(__FILE__) + "/../media"

require File.dirname(__FILE__) + '/level1'
require File.dirname(__FILE__) + '/level2'
require File.dirname(__FILE__) + '/level3'
require File.dirname(__FILE__) + '/level4'

class Game < Chingu::Window

  attr_accessor :title, :next_level_available_mention, :level, :levels, :restart_mention

  def initialize
    super(640, 480, false)

    @title                        = Chingu::Text.create(
        :text => 'title', :size => 25, :x => 280, :y => 10, :color => Color::WHITE)
    @next_level_available_mention = Chingu::Text.create(
        :text => "press (n) for next level", :size => 25, :x => 200, :y => 300, :color => Color::BLACK)
    center_text(@next_level_available_mention)
    @restart_mention = Chingu::Text.create(
        :text => "press (r) to retry", :size => 25, :x => 200, :y => 250)
    center_text(@restart_mention)

    start
  end

  def start
    @restart_mention.color = Color::BLACK
    @levels                = [Level4.new, Level3.new, Level2.new, Level1.new]
    next_level
  end

  def next_level
    activate_level(@levels.pop)
  end

  def init_texts()
    @title.text  = @level.title
    @title.color = Color::WHITE
    center_text(@title)
    @next_level_available_mention.color = Color::BLACK
    @restart_mention.color = Color::BLACK
  end

  def activate_level(level)
    self.input   = {:escape => :exit}
    level.game   = self
    @level       = level
    init_texts()
    push_game_state(level)
  end

  def level_done
    @title.text  = @level.title + ' completed'
    @title.color = Color::GREEN
    center_text(@title)

    if @levels.size > 0
      @next_level_available_mention.color = Color::GREEN
      self.input                          = {:escape => :exit, :n => :next_level}
    else
      @restart_mention.color = Color::GREEN
      self.input             = {:escape => :exit, :r => :start}
    end
  end

  def level_lost
    @title.text  = @level.title + ' lost'
    @title.color = Color::RED
    center_text(@title)
    
    @restart_mention.color = Color::RED
    self.input             = {:escape => :exit, :r => :retry}
  end

  def retry
    self.input   = {:escape => :exit}
    init_texts()
    @level.reset
  end

  def center_text(text)
    text.x = self.width/2 - text.width/2
  end

end

