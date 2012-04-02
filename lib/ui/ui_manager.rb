﻿require_relative 'ui'
require_relative 'font_cache'

class UI_Manager
  attr_accessor :user_interfaces, :active_user_interfaces
  
  def initialize
    @user_interfaces = {}
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
    @user_interfaces.each_pair do |name, ui|
      ui.update if ui.active
    end
  end

  def display
    @user_interfaces.each_pair do |name, ui|
      ui.display if ui.active
    end
  end
  
  # Load/Save XML Data
  def from_xml(xml_file)
  end
  
  def to_xml
  end
end
