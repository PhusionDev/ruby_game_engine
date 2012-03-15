class Camera
  include Positionable

  attr_accessor :view_bounds
  
  def initialize(x = 0, y = 0)
    move_to(x, y)
    @half_width = $game_window.width.to_i/2
    @half_height = $game_window.height.to_i/2
    update_view_bounds
  end
  
  def play
    
  end
  
  def stop
    
  end
  
  def update
    update_view_bounds if view_changed?
  end
  
  def display_to(display)
  
  end
  
  # Protected Methods
  protected
  
  # Private Methods
  private
  
  def view_changed?
    if not(x == @view_bounds.x_center) || not(y == @view_bounds.y_center)
      return true
    end
    return false
  end
  
  def update_view_bounds
    @view_bounds = Rectangle.new(x - @half_width, x + @half_width,
                                 y - @half_height, y + @half_height)
  end
end