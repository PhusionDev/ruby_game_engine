require 'forwardable'

module Dimensions
  attr_accessor :height, :width, :depth
end

module Positionable
  attr_accessor :x, :y
  
  def move_to(x = 0, y = 0)
    @x = x
    @y = y
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
        when :uniform
          if not(args[0] == nil)
            @scale_x, @scale_y = args[0] > 0 ? [args[0]] * 2 : [1] * 2
          end
        when :independant
          if not(args[0] == nil) && not(args[1] == nil)
            @scale_x = args[0] > 0 ? args[0] : 1
            @scale_y = args[1] > 0 ? args[1] : 1
          end
        when :x
          if not(args[0] == nil)
            @scale_x = args[0] > 0 ? args[0] : 1
          end
        when :y
          if not(args[0] == nil)
            @scale_x = args[0] > 0 ? args[0] : 1
          end
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
  attr_accessor :text, :text_object, :font_name, :font_height, :bold, :italic, :underline
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