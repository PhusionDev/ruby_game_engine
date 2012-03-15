class Rectangle
  attr_accessor :x_min, :x_max, :y_min, :y_max, :x_center, :y_center, :width, :height, :half_width, :half_height
  
  def initialize(x_min, x_max, y_min, y_max)
    @x_min = x_min
    @x_max = x_max
    @y_min = y_min
    @y_max = y_max
    @x_center = (x_min + x_max)/2
    @y_center = (y_min + y_max)/2
    @width = x_max - x_min
    @height = y_max - y_min
    @half_width = @width/2
    @half_height = @height/2
  end
  
  def contains_coord?(x, y)
    if x >= x_min && x <= x_max
      if y >= y_min && y <= y_max
        return true
      end
    end
    return false
  end
  
  def intersects?(rect_other)
    if rect_other.is_a?(Rectangle)
      if @x_center - rect_other.x_center <= @half_width + rect_other.half_width
        if @y_center - rect_other.y_center <= @half_height + rect_other.half_height
          return true
        end
      end
    end
    return false
  end
end