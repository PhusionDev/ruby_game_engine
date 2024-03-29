﻿require_relative 'map_tile'

class Map_Segment
  include Positionable
  include Dimensions
  
  attr_accessor :map_tiles, :map_tiles_active, :bounding_rect
  
  def initialize(x = 0, y = 0, parent_map = nil)
    @map_tiles = []
    @map_tiles_active = []
    move_to(x, y)
  end
  
  def add_map_tile(tile)
    if tile.is_a?(Map_Tile)
      if not(@map_tiles.include?(tile))
        @map_tiles.push(tile)
      end 
    end
  end
  
  def remove_map_tile
  end
  
  def new_map_tile(local_x, local_y, image_file = Map_Tile::Default_Tile)
    world_x = x - local_x
    world_y = y - local_y
    add_map_tile(Map_Tile.new(world_x, world_y, image_file, self))
  end
  
  def update
    map_tiles_active.each do |map_tile|
      map_tile.update
    end
  end
end
