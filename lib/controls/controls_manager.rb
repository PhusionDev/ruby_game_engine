require_relative 'control_scheme'

class Controls_Manager
  attr_accessor :active_control_scheme
                      
  def initialize
    load_control_schemes
    set_active_control_scheme(Default_Controls)
  end
  
  def set_active_control_scheme(scheme)
    @active_control_scheme = scheme if scheme.respond_to?(:check_input) 
  end

  def button_down(id)
    @active_control_scheme.send(:button_down, id) if not(@active_control_scheme == nil)
  end

  def update
    @active_control_scheme.send(:check_input) if not(@active_control_scheme == nil)
  end

  private

  # This method will load all control_schemes within the lib/controls folder
  # of the engine with a naming convention of:
  # name_controls.rb
  # where name is whatever name you choose to give them.
  # Make sure to read control_scheme.rb before making your own control scheme.
  def load_control_schemes
    Dir.foreach("lib/controls") do |control_scheme|
      if not(/\w+_+controls/.match(control_scheme) == nil)
        str_require = control_scheme.slice(0, control_scheme.index('.'))
        require_relative str_require
      end
    end
  end
end
