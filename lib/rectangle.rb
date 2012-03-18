class Rectangle
  attr_accessor :x_min, :x_max, :y_min, :y_max, :x_center, :y_center, :width, :height, :half_width, :half_height
  
  def initialize(x_min, x_max, y_min, y_max)
    @x_min = x_min
    @x_max = x_max
    @y_min = y_min
    @y_max = y_max
    @x_center = (x_min + x_max)/2.0
    @y_center = (y_min + y_max)/2.0
    @width = (x_max - x_min).abs
    @height = (y_max - y_min).abs
    @half_width = @width/2.0
    @half_height = @height/2.0
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
      @current_distance_x = (@x_center - rect_other.x_center).abs
      @current_distance_y = (@y_center - rect_other.y_center).abs
      if @current_distance_x <= @half_width + rect_other.half_width
        @intersects_x = true
      else
        @intersects_x = false
      end
      if @current_distance_y <= @half_height + rect_other.half_height
        @intersects_y = true
      else
        @intersects_y = false
      end
      return true if @intersects_x || @intersects_y
    end
    return false
  end
  
  def contains?(rect_other)
    if intersects?(rect_other)
      if @intersects_x && @intersects_y
        if @current_distance_x + rect_other.half_width <= @half_width &&
           @current_distance_y + rect_other.half_height <= @half_height
          return true
        else
          return false
        end
      end
    end
  end
end