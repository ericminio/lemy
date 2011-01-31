def having_on_the_platform(platform, object)
  object.y = platform.y - object.height
  object.x = platform.x
end

def not_having_in_the_platform(platform, object)
  having_on_the_platform(platform, object)
  object.y -= 1
end

def object_on_platform?(object, platform)
  (object.y + object.height) == platform.y &&
      object.x >= (platform.x - platform.width/2) &&
      object.x <= (platform.x + platform.width/2)
end

class Having

  def initialize(object)
    @object = object
  end

  def self.object(object)
    Having.new(object)
  end

  def on_the_platform(platform)
    @object.y = platform.y - @object.height
    @object.x = platform.x
  end

end

class NotHaving

  def initialize(object)
    @object = object
  end

  def self.object(object)
    NotHaving.new(object)
  end

  def on_the_platform(platform)
    @object.y = platform.y - @object.height - 1
    @object.x = platform.x
  end

end

