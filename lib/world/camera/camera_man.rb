require_relative 'camera'

class Camera_Man
  attr_accessor :cameras, :held_camera
  
  def initialize
    @cameras = []
    @held_camera = nil
  end
  
  def borrow_camera(camera)
    if camera.is_a? Camera
      if not @cameras.include? camera
        @cameras.push(camera)
      end
    end
  end
  
  def return_camera(camera)
    if camera.is_a? Camera
      if @cameras.include? camera
        @cameras.delete(camera)
      end
    end
  end
  
  def grab_camera(camera)
    if camera.is_a? Camera
      if not @held_camera == nil
        cut
      end
      @held_camera = camera
      action
    else
      @held_camera = nil
    end
  end
  
  def translate_camera(offset_x = 0, offset_y = 0, camera = @held_camera)
    point_camera_to(Chipmunk_Helper::translate(camera.x, camera.y, offset_x, offset_y))
  end
  
  def point_camera_to(x = 0, y = 0, camera = @held_camera)
    camera.set_x(x)
    camera.set_y(y)
  end
  
  def action
    @held_camera.play
  end
  
  def cut
    @held_camera.stop
  end
  
  def update
  end
  
  def display(display = $output.window(:default), camera = @held_camera)
    if not(display == nil) && not(@held_camera == nil)
      if display.is_a?(GameWindow) && camera.is_a?(Camera)
        camera.display_to(display)
      end
    end
  end
  
  # Protected Methods
  protected
  
  # Private Methods
  private
  
end
