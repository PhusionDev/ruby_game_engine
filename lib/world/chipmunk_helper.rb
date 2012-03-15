require 'chipmunk'

module Chipmunk_Helper
  def coord_to_vec2(x = 0, y = 0)
    return CP::Vec2.new(x, y)
  end
  
  def vec2_to_coord(vec2 = CP::Vec2.new(0.0, 0.0))
    coord = []
    coord[0] = vec2.x
    coord[1] = vec2.y
    
    return coord
  end
  
  def translate(x, y, offset_x, offset_y)
    v1 = coord_to_vec2(x, y)
    v2 = coord_to_vec2(offset_x, offset_y)
    v3 = CP::Vec2.new(v1 - v2)
    
    return Array.new(v3.x, v3.y)
  end
end