require_relative 'map'

class Map_Manager
  attr_accessor :maps, :maps_active
  
  def initialize
    @maps = {}
    @maps_active = []
  end
  
  def add_map(name, map)
    if not(name.is_a?(Symbol))
      name = name.to_sym
    end
    if @maps[name] == nil
      if map.is_a?(Map)
        @maps.store(name, map)
      end
    end
    return @maps[name]
  end
  
  def activate_map(name)
    map = @maps[name]
    if not(map == nil)
      if not(@maps_active.include?(map))
        map.activate
        @maps_active.push(map)
      end
    end
  end
  
  def deactivate_map(name)
    map = @maps[name]
    if not(map == nil)
      if @maps_active.include?(map)
        @maps_active.delete(map)
        @maps[name].deactivate
      end
    end
  end
  
  def remove_map(name)
  end
  
  def update
    @maps_active.each do |map|
      map.update
    end
  end
  
  # Load/Save XML Data
  def from_xml(xml_file)
  end
  
  def to_xml
  end
end
