require_relative 'test'

class Test_User_Interface < Test
  def self.default
    self.basic_ui if @has_run == nil
    @has_run = true
  end

  def self.basic_ui
    $game_manager.ui_manager.new_ui(:default)
    self.fps
    self.information
    self.scenery
  end

  def self.fps(user_interface = :default)
    $game_manager.game_objects_manager.add_object(:gosu_fps, FPS_Object.new).activate
    
    if not($game_manager.ui_manager.ui(user_interface) == nil)
      $game_manager.ui_manager.ui(user_interface).new_label(:label_fps,
                                                            0, 0, "",
                                                            $game_manager.game_objects_manager.object(:gosu_fps),
                                                            "Arial", 24, 0xffffff00)
  
      $game_manager.ui_manager.ui(user_interface).element(:label_fps).depth = 1
    end
  end

  def self.information(user_interface = :default)
    text = "ESC: Quit"
    $game_manager.ui_manager.ui(user_interface).new_label(:label_controls_01,
                                                          0, 32, text, nil,
                                                         "Arial", 24, 0xff000000).depth = 1
  
    text = "SPACE: Test a Color_Transition object"
    $game_manager.ui_manager.ui(user_interface).new_label(:label_controls_02,
                                                          0, 64, text, nil,
                                                         "Arial", 24, 0xff000000).depth = 1
  end

  def self.scenery(user_interface = :default, output = :default)
    if not($game_manager.ui_manager.ui(user_interface) == nil)
      if not($output.window(output) == nil)
        $game_manager.ui_manager.ui(user_interface).new_image(:img_scenery, $output.window(output), 0, 0,
                                                             "res/images/scene/default.png")
      end
    end
  end
end
