class Particle
  include Positionable
  include Dimensions
  include Gosu_Image
  include Colored
  include Visibility

  Default_Image = "res/images/particles/default.png"
  Default_Color = 0xffffffff
  
  def initialize(output, x=0, y=0, image_file=Default_Image, color=Default_Color)
    move_to(x, y)
    init_gosu_image(output, image_file)
    init_colored(color)
  end
  
  def update
  end
end