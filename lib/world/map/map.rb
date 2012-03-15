require_relative 'map_segment'

class Map
  include Positionable
  
  attr_accessor :map_segments, :active_map_segments, :bounding_rect
  
  def initialize(x = 0, y = 0)
    @map_segments = {}
    @active_map_segments = []
    @x = x
    @y = y
  end
  
  def add_map_segment(name, map_segment)

  end
  
  def new_map_segment(name, local_x, local_y)

  end
  
  def activate_map_segment(name)

  end
  
  def deactivate_map_segment(name)

  end
  
  def update
    @active_map_segments.each do |map_segment|
      map_segment.update
    end
  end
  
  # Load/Save XML Data
  def from_xml(xml_file)
  end
  
  def to_xml
  end
  
  protected # Protected Methods #

  private # Private Methods #
  
end