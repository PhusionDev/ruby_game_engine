require_relative 'ui_element'

class UI_Label < UI_Element
  include Text_Value
  include Colored

  Font_Name = "Arial"
  Font_Height = 14
  Color = 0xffffffff
  
  def initialize(x=0, y=0, text="", text_object=nil,
                 font_name=Font_Name, font_height=Font_Height,
                 color=Color)
    super(x, y)
    init_text_value(text, text_object, font_name, font_height)
    init_colored(color)
    @hidden = false
  end
     
  def format_with_class_defaults
    @font_name = Font
    @font_height = Font_Height
    init_colored(Color)
  end
end