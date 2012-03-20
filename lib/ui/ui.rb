require_relative 'elements/ui_frame'
require_relative 'elements/ui_label'
require_relative 'elements/ui_text_box'
require_relative 'elements/ui_button'
require_relative 'elements/ui_image'

class UI
  attr_accessor :active, :ui_elements, :show_frame_rate
  
  def initialize()
    @active = false
    @ui_elements = {}
    @show_frame_rate = false
  end
  
  def add_element(name, ui_element)
    if not(name.is_a?(Symbol))
      name = name.to_sym
    end
    if @ui_elements[name] == nil
      if ui_element.is_a?(UI_Element)
        @ui_elements.store(name, ui_element)
        activate_element(ui_element)
      end
    end
    return @ui_elements[name]
  end
  
  def remove_element(name)
  end
  
  def new_image(name, output, x=0, y=0,
                image_file=UI_Image::Default_Image, color=UI_Image::Default_Color)
    image = UI_Image.new(output, x, y, image_file, color)
    return add_element(name, image)
  end
  
  def new_label(name, x=0, y=0, text_string="", text_object=nil,
                 font_name=UI_Label::Font_Name,font_height=UI_Label::Font_Height,
                 color=UI_Label::Color)
    label = UI_Label.new(x,y,text_string,text_object,font_name,font_height,color)
    return add_element(name, label)
  end
  
  def element(name)
    if not(name.is_a?(Symbol))
      name = name.to_sym
    end
    if name.is_a?(Symbol)
      return @ui_elements[name]
    end
    return nil
  end
  
  def activate
    @active = true
    activate_elements
  end
  
  def deactivate
    @active = false
    deactivate_elements
  end
  
  def update
    if @active
      @ui_elements.each_pair do |name, ui_element|
        ui_element.update if ui_element.respond_to?(:update)
      end
    end
  end
  
  def display
    @ui_elements.each_pair do |name, ui_element|
      if not(ui_element.hidden == true)
        display_element(ui_element)
      end
    end
  end
  
  # Load/Save XML Data
  def from_xml(xml_file)
  end
  
  def to_xml
  end
  
  private # Private Methods #
  
  def activate_element(ui_element)
    if ui_element.is_a?(UI_Element)
      if ui_element.respond_to?(:activate)
        ui_element.activate
      end
    end
  end
  
  def deactivate_element(ui_element)
    if ui_element.is_a?(UI_Element)
      if ui_element.respond_to?(:deactivate)
        ui_element.deactivate
      end
    end
  end
  
  def activate_elements
    @ui_elements.each_pair do |name, ui_element|
      if ui_element.respond_to?(:activate)
        ui_element.activate
      end
    end
  end
  
  def deactivate_elements
    @ui_elements.each_pair do |name, ui_element|
      if ui_element.respond_to?(:deactivate)
        ui_element.deactivate
      end
    end
  end
  
  def display_element(ui_element)
    case ui_element
      when UI_Frame
      when UI_Label
        display_label(ui_element)
      when UI_Text_Box
      when UI_Image
        display_image(ui_element)
      when UI_Button
      else
    end
  end
  
  def display_label(label)
    $font_cache.fonts[label.font].draw(label.text, label.x, label.y, 1, 1, 1, label.color)
  end
  
  def display_image(image)
    image.image.draw(image.x, image.y, 1, image.scale_x, image.scale_y, image.color)
  end
end