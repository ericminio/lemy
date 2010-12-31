require File.dirname(__FILE__) + '/platform'

class Station < Platform

  def initialize(options = {})
    super
    @color  = Color::AQUA
  end

end