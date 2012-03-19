require_relative 'ui_element'

class UI_Image < UI_Element
  include Gosu_Image
  include Colored

  Default_Image = "res/images/ui/default.png"
  Default_Color = 0xffffffff
  
  def initialize(output, x=0, y=0, image_file=Default_Image, color=Default_Color)
    super(x, y)
    init_gosu_image(output, image_file)
    init_colored(color)
  end
end