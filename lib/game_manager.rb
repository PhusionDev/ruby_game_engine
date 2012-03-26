require 'nokogiri'

require_relative 'rectangle'
require_relative 'world/world'
require_relative 'ui/ui_manager'
require_relative 'game_objects/game_objects_manager'
require_relative 'controls/controls_manager'

# tests
require_relative 'tests/all_tests'

class Game_Manager
  attr_accessor :world, :ui_manager, :game_objects_manager, :controls_manager
  
  def initialize
    @world = World.new
    @ui_manager = UI_Manager.new
    @game_objects_manager = Game_Objects_Manager.new
    @controls_manager = Controls_Manager.new
    @controls_manager.set_active_control_scheme(Test_Controls)
  end
 
  # Core Methods (Update/Display)
  
  def update
    @controls_manager.update
    @game_objects_manager.update
    @world.update
    @ui_manager.update
  end
  
  def display
    @world.display
    @ui_manager.display
  end
  
  # Helper method for calling button_down
  
  def button_down(id)
    @controls_manager.button_down(id)
  end
end
