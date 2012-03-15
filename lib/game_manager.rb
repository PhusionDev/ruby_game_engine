require 'nokogiri'

#require_relative 'rectangle'
require_relative 'world/world'
require_relative 'ui/ui_manager'
require_relative 'game_objects/color_transition'
require_relative 'game_objects/color_transitions'

class FPS_Object
  attr_reader :fps
  
  def initialize
    update
  end
  
  def update
    @fps = Gosu::fps()
  end
  
  def to_s
    return @fps
  end
  
  private
  
  def fps=(value)
    self.fps = value
  end
end

class Game_Manager
  attr_accessor :world, :ui_manager, :objects

  def initialize
    @world = World.new
    @ui_manager = UI_Manager.new
    @objects = {}
    
    #testing purposes
    create_test_ui
  end
  
  def add_object(name, object)
    if not(name.is_a?(Symbol))
      name = name.to_sym
    end
    if @objects[name] == nil
      @objects.store(name, object)
    end
  end
  
  def remove_object(name)
    if not(@objects[name] == nil)
      @objects.delete(name)
    end
  end
  
  def update_objects
    @objects.each_pair do |name, object|
      if object.respond_to? :expired
        remove_object(name) if object.expired
      end
      if not(object == nil)
        object.update if object.respond_to?(:update)
      end
    end
  end
  
  def update
    check_input
    update_objects
    @world.update
    @ui_manager.update
  end
  
  def display
    @world.display
    @ui_manager.display
  end
  
  def button_down(id)
    check_button_down(id)
  end
  
  private # Private Methods #
  
  def check_input
    check_input_keyboard
    check_input_mouse
    check_input_gamepad
  end
  
  def check_input_keyboard
  end
  
  def check_button_down(id)
    if id == Gosu::KbSpace
      # Test/Debug Code
      color_transitions = [Gosu::Color.argb(0xffffffff),
                           Gosu::Color.argb(0xff7f5f5f),
                           Gosu::Color.argb(0xff5f2034)]
      transition_durations = [5000, 5000, 5000]
      add_object(:ct_scene,
                 Color_Transitions.new(@ui_manager.ui(:ui_default).element(:img_scene),
                                      color_transitions, transition_durations,
                                      true, Color_Transitions::Loop_Style::LIFO))
      @objects[:ct_scene].activate
    end
  end
  
  def check_input_mouse
  end
  
  def check_input_gamepad
  end
  
  # Testing/Debugging
  def create_test_ui
    add_object(:gosu_fps, FPS_Object.new)
    @ui_manager.new_ui(:ui_default)
    @ui_manager.ui(:ui_default).new_image(:img_scene, $output.active_window, 0, 0, "res/images/scene/default.png")
    @ui_manager.ui(:ui_default).new_label(:label_fps, 0, 0, "", @objects[:gosu_fps], "Arial", 30)
  end
end