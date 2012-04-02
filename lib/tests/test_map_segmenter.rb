require_relative 'test'

class Test_Map_Segmenter < Test
  @ui_name = :map_segmenter

  def self.default
    self.init if @has_run == nil
    @has_run = true

    self.show
  end
  
  def self.init
    self.init_segmenter
    self.init_segmenter_ui
    self.init_labels
  end

  def self.show
    self.show_segmenter_ui
  end

  # Init Methods
  
  def self.init_segmenter
    #@map_segmenter = Map_Segmenter.new
  end

  def self.init_segmenter_ui
    $ui_manager.new_ui(@ui_name)
  end


  def self.init_labels
    text = "HI IM THE MAP SEGMENTER"
    $ui_manager.ui(@ui_name).new_label(:label_info_01,
                                       0, 0,
                                       text, nil,
                                       "Arial", 24, 0xffffffff)
  end

  # Show Methods
  
  def self.show_segmenter_ui
    $ui_manager.show_only(@ui_name)
  end
end
