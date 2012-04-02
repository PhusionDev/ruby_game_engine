require_relative 'control_scheme'

# Test Controls
# Various controls used for testing the current state of the game engine

class Test_Controls < Control_Scheme
  def self.button_down(id)
    if id == Gosu::KbEscape
      $output.window(:default).close
    end

    # Testing purposes only
    if id == Gosu::KbT
      Test_User_Interface.begin
    end

    if id == Gosu::KbSpace && $ui_manager.ui(:default).active
      Test_Color_Transition.simple_transition(:default, :img_scenery)
    end

    if id == Gosu::KbS
      Test_Map_Segmenter.begin
    end
  end
end
