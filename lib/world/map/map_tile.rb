class Map_Tile
  include Positionable
  include Dimensions
  include Visibility
  include Gosu_Image
  include Colored
  
  Default_Tile = "res/images/tiles/default.png"
  
  def initialize(x = 0, y = 0, image_file = Default_Tile)
    move_to(x, y)
    @image_file = image_file
    init_colored(0xffffffff)
  end
end
