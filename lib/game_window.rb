require 'gosu'

require_relative 'game_manager'
require_relative 'output'

class Game_Window < Gosu::Window
  attr_accessor :game_manager, :output

  def initialize
    super 640, 640, false
    self.caption = $version
    init_output
    init_game_manager
  end
  
  def init_output
    $output = Output.new
    $output.add(:game_window, self)
  end
  
  def init_game_manager
    @game_manager = Game_Manager.new
  end
  
  def update
    @game_manager.update
  end
  
  def draw
    @game_manager.display
  end
  
  def button_down(id)
    @game_manager.button_down(id)
  end
  
  protected # Protected Methods #
  
  private # Private Methods #
  
end
