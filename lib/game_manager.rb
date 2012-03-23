﻿require 'nokogiri'

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
 
  # Core Methods (Update/Display)
  
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
  
  # Helper method for calling button_down from Game_Window
  
  def button_down(id)
    check_button_down(id)
  end
  
  private
  
  # Input related methods
  
  def check_input
    check_input_keyboard
    check_input_mouse
    check_input_gamepad
  end
  
  def check_input_keyboard
  end
  
  def check_input_mouse
  end
  
  def check_input_gamepad
  end
  
  # Gets called from Game_Window#button_down?(id)
  def check_button_down(id)
    if id == Gosu::KbEscape
      $output.window(:game_window).close
    end

    if id == Gosu::KbSpace
      # test/debug code
      # the following code is merely for testing purposes, and to highlight
      # some of the game engine's current features.
      @game_objects_manager.add_object(:ct_scene,
                                       Color_Transition.new(@ui_manager.ui(:ui_default).element(:img_scene),
                                                            [0xffffffff, 0xff888844], 3000, true))
      @game_objects_manager.object(:ct_scene).activate
    end
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
