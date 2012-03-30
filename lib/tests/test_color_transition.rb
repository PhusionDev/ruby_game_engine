require_relative 'test'

class Test_Color_Transition < Test
  def self.default
    self.simple_transition
  end

  def self.simple_transition(user_interface = :default, element = :default)
    if not($ui_manager.ui(user_interface) == nil)
      if not($ui_manager.ui(user_interface).element(element) == nil)
        $game_objects_manager.add_object(
          :ct_scene,
          Color_Transition.new($ui_manager.ui(user_interface).element(element),
          [0xffffffff, 0xff888844], 3000, true))
        $game_objects_manager.object(:ct_scene).activate
      end
    end
  end
end
