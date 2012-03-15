require_relative 'ui_element'

class UI_Frame < UI_Element
  attr_accessor :ui_elements
  
  def initialize
    @ui_elements = {}
  end
  
  def add_element(name, ui_element)
    if name.is_a?(String)
      name.to_sym!
    end
    if name.is_a?(Symbol)
      if @ui_elements[name] == nil
        if ui_element.is_a?(UI_Element)
          @ui_elements.store(name, ui_element)
        end
      end
    end
  end
  
  def remove_element(ui_element)
  end
  
  def element(name)
    if name.is_a?(String)
      name.to_sym!
    end
    if name.is_a?(Symbol)
      return @ui_elements[name]
    end
    return nil
  end
  
  def update
  end
end