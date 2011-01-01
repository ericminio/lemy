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

