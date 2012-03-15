class Sprite
  include Positionable
  include Dimensions
  include Visibility
  include Gosu_Image
  include Colored
  
  Default_Image = "res/images/sprites/default.png"
  Default_Color = 0xffffffff
  
  def initialize(output, x=0, y=0, image_file=Default_Image, color=Default_Color)
    @output = output
    @x = x
    @y = y
    @image_file = image_file
    self.color = color
    @active = false
  end
  
  def update
  end
end