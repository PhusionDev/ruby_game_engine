require 'forwardable'

module Dimensions
  attr_accessor :height, :width

  def depth=(value)
    if not(value == nil)
      if value >= 0
        @depth = value
      end
    end
  end

  def depth
    if not(@depth == nil)
      return @depth
    else
      return 0
    end
  end
end

module Positionable
  attr_accessor :x, :y
  
  def move_to(x = 0, y = 0)
    @x, @y = x, y
  end
  
  def translate(x = 0, y = 0)
    move_to(@x + x, @y + y)
  end
end

module Gosu_Image
  attr_accessor :active, :image, :image_file, :scale_x, :scale_y, :output
  
  def init_gosu_image(output, image_file)
    @output = output
    @image_file = image_file
    @active = false
    scale(:uniform, 1.0)
  end
  
  def scale(type, *args)
    if not args == nil
      case type
        when :uniform, :locked, :both
          if not(args[0] == nil)
            @scale_x, @scale_y = args[0] > 0 ? [args[0]] * 2 : [1] * 2
          end
        when :independent, :individual, :separate, :xy
          if not(args[0] == nil) && not(args[1] == nil)
            @scale_x = args[0] > 0 ? args[0] : 1.0
            @scale_y = args[1] > 0 ? args[1] : 1.0
          end
        when :x, :width
          if not(args[0] == nil)
            @scale_x = args[0] > 0 ? args[0] : 1.0
          end
        when :y, :height
          if not(args[0] == nil)
            @scale_x = args[0] > 0 ? args[0] : 1.0
          end
        else
          # Invalid scale-type passed
      end
    end
  end
  
  def activate
    image_load
    @active = true
  end
  
  def deactivate
    @active = false
    image_unload  
  end
  
  def image_load(window = @output)
    @image = Gosu::Image.new(@output, @image_file, true)
  end
  
  def image_unload
    @image = nil
  end
end

module Text_Value
  attr_accessor :text, :text_object, :font_name, :font_height
  
  def init_text_value(text, text_object, font_name, font_height)
    @text, @text_object = text, text_object
    @font_name, @font_height = font_name, font_height
    @had_object = text_object == nil ? false : true
    link_to_object(text_object)
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

module Visibility
  attr_accessor :hidden
  
  def hide
    @hidden = true
  end
  
  def show
    @hidden = false
  end
end

module Colored
  extend Forwardable

  attr_reader :color

  def_delegators :@color, :alpha, :red, :blue, :green, :hue, :saturation, :value,
                          :alpha=,:red=,:blue=,:green=,:hue=,:saturation=,:value=
  
  def init_colored(color)
    self.color = color
  end
  
  def color=(color)
    @color = color.is_a?(Gosu::Color) ? color.dup : Gosu::Color.argb(color)
  end
end

module Color_Preset

end
