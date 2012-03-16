require_relative 'ui_element'

class UI_Label < UI_Element
  include Text_Value
  include Colored

  Font_Name = "Arial"
  Font_Height = 14
  Bold = false
  Italic = false
  Underline = false
  Color = 0xffffffff
  
  def initialize(x=0, y=0, text="", text_object=nil,
                 font_name=Font_Name, font_height=Font_Height, bold=Bold, italic=Italic, underline=Underline,
                 color=Color)
    super(x, y)
    @text = text
    link_to_object(text_object)
    @font_name = font_name
    @font_height = font_height
    @bold = bold
    @italic = italic
    @underline = underline
    self.color = color
    @hidden = false
    @had_object = text_object == nil ? false : true
  end
  
  def link_to_object(object)
    @text_object = object
  end
  
  def unlink_object
    @text_object = nil
  end
  
  def clear_text
    @text = ""
  end
  
  def font
    return (@font_name + "_" + @font_height.to_s).to_sym
  end
  
  def format_with_class_defaults
    @font_name = Font
    @font_height = Font_Height
    @bold = Bold
    @italic = Italic
    @underline = Underline
    self.color = Color
  end
  
  def update
    if not(@text_object == nil)
      if @text_object.respond_to?(:expired)
        if @text_object.expired
          unlink_object
          unlinked = true
        end
      end
      if not(unlinked)
        @had_object = true if not(@had_object)
        @text = @text_object.to_s
      end
    else
      if @had_object && not(@text == "")
        clear_text
      end
    end
  end
end