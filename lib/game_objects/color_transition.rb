require_relative 'time_object'

class Color_Transition < Time_Object
  include Colored
  
  #attr_accessor :target, :color
  
  Color_Positions = [:alpha, :red, :blue, :green]
  
  def initialize(target, color, time, expiration_time=nil)
    super(time, expiration_time)
    @target = target
    @color = color
    @initial_colors = {}
    Color_Positions.each do |position|
      @initial_colors.store(position, @target.send(position))
    end
    reset
  end
  
  def activate
    super
  end
  
  def deactivate
    super
  end
  
  def update
    super
    transition_colors
  end
  
  def reset
    init_values
    calculate_argb_updates
  end
  
  def init_values
    @update_rates = {}
    @color_deltas = {}
  end
  
  def to_s
    return "update frame: " << @update_tick.to_s
  end
  
  private
  
  def transition_colors   
    Color_Positions.each do |position|
      if not(@update_rates[position] == nil)
        if not((@target.send(position) - @initial_colors[position]).abs > @update_rates[position].abs * @update_tick)
          transition_color(position)
        end
      end
    end
  end
  
  def transition_color(position)
    value = @color_deltas[position]
    case position
      when :alpha
        @target.alpha += value
      when :red
        @target.red += value
      when :green
        @target.green += value
      when :blue
        @target.blue += value
    end
  end
  
  def calculate_argb_updates
    diffs = {}
    Color_Positions.each do |position|
      diffs.store(position, @color.send(position) - @target.send(position))
      if not diffs[position] == 0
        @update_rates.store(position, 1.0 * diffs[position] / @update_calls)
        if diffs[position].abs < @update_calls
          delta = diffs[position] / diffs[position].abs
        else
          delta = @update_rates[position].floor
        end
        @color_deltas.store(position, delta)
      end
    end
  end
end