require_relative 'test'

class Test_User_Interface < Test
  @ui_name = :default

  def self.default
    self.init if @has_run == nil
    @has_run = true

    self.show
  end

  def self.init
    self.init_ui
    self.init_fps
    self.init_info
    self.init_scenery
  end

  def self.show
    self.show_ui
  end

  # Init Methods
  
  def self.init_ui
    $ui_manager.new_ui(@ui_name)
  end

  def self.init_fps
    $game_objects_manager.add_object(:gosu_fps, FPS_Object.new).active = true
    $ui_manager.ui(@ui_name).new_label(:label_fps,
                                       0, 0,
                                       "", $game_objects_manager.object(:gosu_fps),
                                       "Arial", 24, 0xffffff00)
    $ui_manager.ui(@ui_name).element(:label_fps).depth = Dimensions::Depth_Layer::User_Interface
  end

  def self.init_info
    text = "ESC: Quit"
    $ui_manager.ui(@ui_name).new_label(:label_controls_01,
                                       0, 32,
                                       text, nil,
                                       "Arial", 24, 0xff000000)
    $ui_manager.ui(@ui_name).element(:label_controls_01).depth = Dimensions::Depth_Layer::User_Interface 
  
    text = "SPACE: Test a Color_Transition object"
    $ui_manager.ui(@ui_name).new_label(:label_controls_02,
                                       0, 64,
                                       text, nil,
                                       "Arial", 24, 0xff000000)
    $ui_manager.ui(@ui_name).element(:label_controls_02).depth = Dimensions::Depth_Layer::User_Interface
    
    text = "S: Switch to Map Segmenter User Interface"
    $ui_manager.ui(@ui_name).new_label(:label_controls_03,
                                       0, 96,
                                       text, nil,
                                       "Arial", 14, 0xffff0000)
    $ui_manager.ui(@ui_name).element(:label_controls_03).depth = Dimensions::Depth_Layer::User_Interface
  end

  def self.init_scenery
    $ui_manager.ui(@ui_name).new_image(:img_scenery,
                                       $output.window(:default),
                                       0, 0,
                                       "res/images/scene/default.png")
    $ui_manager.ui(@ui_name).element(:img_scenery).depth = Dimensions::Depth_Layer::Background
  end

  # Show Methods

  def self.show_ui
    $ui_manager.show_only(@ui_name)
  end
end
