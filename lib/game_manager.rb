require 'nokogiri'

require_relative 'rectangle'
require_relative 'world/world'
require_relative 'ui/ui_manager'
require_relative 'game_objects/game_objects_manager'

class Game_Manager
  attr_accessor :world, :ui_manager, :game_objects_manager

  def initialize
    @world = World.new
    @ui_manager = UI_Manager.new
    @game_objects_manager = Game_Objects_Manager.new
    
    #testing purposes
    create_test_ui
  end
  
  def update
    check_input
    @game_objects_manager.update
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
      # Test/Debug code
    end
  end
  
  def check_input_mouse
  end
  
  def check_input_gamepad
  end
  
  # Testing/Debugging
  def create_test_ui
    @game_objects_manager.add_object(:gosu_fps, FPS_Object.new)
    @game_objects_manager.object(:gosu_fps).activate
    @ui_manager.new_ui(:ui_default)
    @ui_manager.ui(:ui_default).new_image(:img_scene, $output.active_window, 0, 0, "res/images/scene/default.png")
    @ui_manager.ui(:ui_default).new_label(:label_fps, 0, 0, "", @game_objects_manager.object(:gosu_fps), "Arial", 30)
  end
end
