require_relative 'color_transition'
require_relative 'fps_object'

class Game_Objects_Manager
  attr_accessor :game_objects
  
  def initialize
    @game_objects = {}
  end

  # generic object methods (add/remove)
  
  def add_object(name, object)
    if not(name.is_a?(Symbol))
      name = name.to_sym
    end
    if @game_objects[name] == nil
      @game_objects.store(name, object)
    end
  end
  
  def remove_object(name)
    if not(@game_objects[name] == nil)
      @game_objects.delete(name)
    end
  end
  
  def object(name)
    return @game_objects[name]
  end
  
  # specific game-object methods

  def new_fps_object

  end

  def new_color_transition

  end  

  # core methods (update/display)
  
  def update
    @game_objects.each_pair do |name, object|
      if object.respond_to? :expired
        remove_object(name) if object.expired
      end
      if not(object == nil)
        object.update if object.respond_to?(:update)
      end
    end
  end
end
