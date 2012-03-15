require_relative 'ui'
require_relative 'font_cache'

class UI_Manager
  attr_accessor :user_interfaces, :active_ui, :font_cache
  
  def initialize
    @user_interfaces = {}
    @active_ui = nil
    $font_cache = Font_Cache.new
  end
  
  def add_ui(name, user_interface)
    if not(name.is_a?(Symbol))
      name = name.to_sym!
    end
    if name.is_a?(Symbol)
      if @user_interfaces[name] == nil
        if user_interface.is_a?(UI)
          @user_interfaces.store(name, user_interface)
          select_ui(user_interface) if @active_ui == nil
        end
      end
    end
    return @user_interfaces[name]
  end
  
  def remove_ui(user_interface)
    # Remove UI
  end
  
  def new_ui(name)
    return add_ui(name, UI.new)
  end
  
  def ui(name)
    if not(name.is_a?(Symbol))
      name = name.to_sym
    end
    if name.is_a?(Symbol)
      return @user_interfaces[name]
    end
    return nil
  end
  
  def update
    @active_ui.update if not(@active_ui == nil)
  end
  
  def display(user_interface = @active_ui)
    if user_interface.is_a?(UI)
      if user_interface.active
        user_interface.display
      end
    end
  end
  
  # Load/Save XML Data
  def from_xml(xml_file)
  end
  
  def to_xml
  end
  
  private
  
  def select_ui(user_interface)
    if user_interface.is_a?(UI)
      if not(@active_ui == nil)
        deactivate_ui(@active_ui)
        @active_ui = nil       
      end
      activate_ui(user_interface)
      @active_ui = user_interface
    end
  end
  
  def activate_ui(user_interface)
    if user_interface.is_a?(UI)
      user_interface.activate
    end
  end
  
  def deactivate_ui(user_interface)
    if user_interface.is_a?(UI)
      user_interface.deactivate
    end
  end
end