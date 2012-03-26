# Do not directly modify this control scheme.
# Make a new file: name_controls.rb and inherit from this class.
# Override the methods below in your own control scheme to fit
# your needs, however, it's advisable to leave self.check_input
# un-modified.

class Control_Scheme
  def self.check_input
    self.check_input_keyboard
    self.check_input_mouse
    self.check_input_gamepad
  end

  def self.button_down(id)
    # This method is used for one-time button presses 
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
