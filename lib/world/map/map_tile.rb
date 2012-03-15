class MapTile
  include Positionable
  include Dimensions
  include Visibility
  include Gosu_Image
  include Colored
  
  Width = 128
  Height = 128
  Default_Tile = "res/images/tiles/default.png"
  
  def initialize(x = 0, y = 0, image_file = Default_Tile)
    move_to(x, y)
    @image_file = image_file
  end
  
  def update
  end  
end