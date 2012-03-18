require 'forwardable'
require_relative 'rectangle'

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
  
  def activate
    image_load
    @active = true
  end
  
  def deactivate
    image_unload
    @active = false
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
  
  def color=(color)
    @color = color.is_a?(Gosu::Color) ? color.dup : Gosu::Color.argb(color)
  end
end

module Color_Preset

end