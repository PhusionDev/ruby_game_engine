require_relative 'map/map_manager'
require_relative 'sprite/sprite_manager'
require_relative 'particle/particle_manager'
require_relative 'audio/audio_manager'
require_relative 'camera/camera_man'

class World
  attr_accessor :map_manager, :sprite_manager, :particle_manager, :audio_manager, :camera_man
  
  def initialize
    @map_manager = Map_Manager.new
    @sprite_manager = Sprite_Manager.new
    @particle_manager = Particle_Manager.new
    @audio_manager = Audio_Manager.new
    @camera_man = Camera_Man.new
  end
  
  def add_map(map)
    @maps.push(map) if map.is_a?(Map)
  end
  
  def check_for_active_maps
  end
  
  def calculate_map_adjacency
  end
  
  def activate_map(map)
    if map.is_a?(Map) && @maps.include?(map)
      map.activate
      @maps_active.push(map)
    end
  end
  
  def deactivate_map(map)
    if map.is_a?(Map) && @maps.include?(map)
      map.deactivate
      @maps_active.delete(map)
    end
  end
  
  def update
    @map_manager.update
    @sprite_manager.update
    @particle_manager.update
    @audio_manager.update
    @camera_man.update
  end
  
  def display
    @camera_man.display
  end
  
  # Load/Save XML Data
  def from_xml(xml_file)
  end
  
  def to_xml
  end
end