﻿class Sprite
  include Positionable
  include Dimensions
  include Visibility
  include Gosu_Image
  include Colored
  
  Default_Image = "res/images/sprites/default.png"
  Default_Color = 0xffffffff
  
  def initialize(output, x=0, y=0, image_file=Default_Image, color=Default_Color)
    move_to(x, y)
    init_gosu_image(output, image_file)
    init_colored(color)
  end
  
  def update
  end
end