class Control_Scheme
  def self.check_input
    self.check_input_keyboard
    self.check_input_mouse
    self.check_input_gamepad
  end

  def self.button_down(id)
    # This gets manually called by a Gosu::Window object "Game_Window"
    # override this method
  end

  def self.check_input_keyboard
    # override this method
  end

  def self.check_input_mouse
    # override this method
  end

  def self.check_input_gamepad
    # override this method
  end
end
