require_relative 'time_object'

class Color_Transition < Time_Object
  class Loop_Style
    FIFO = 0  # First In First Out (Transitions will run through list and start over)
    LIFO = 1  # Last In First Out (Transitions will run through list and play back in reverse)
  end
  
  include Colored
  
  Color_Positions = [:alpha, :red, :blue, :green]
  Min_Duration = 25
  
  def initialize(target, colors, durations=Min_Duration, looping=false, loop_style=Loop_Style::FIFO, expiration_time=nil)
    @active_transition = 0
    @target = target
    #@colors = colors
    #@durations = durations
    validate_colors(colors)
    validate_durations(durations)
    @looping = looping
    @loop_style = loop_style
    @expiration_time = expiration_time
    reset
  end
  
  def durations
    return @durations
  end
  
  def activate
    super
  end
  
  def deactivate
    super
  end
  
  def loop
    @looping = true
  end
  
  def run_once
    @looping = false
  end
  
  def update
    # "Updating transition # " << @active_transition.to_s
    update_status = super
    transition_colors
    #puts "Target = Transition" if @target.color == @colors[@active_transition]
    next_transition if update_status == :end || @target.color == @colors[@active_transition]
  end
  
  def reset
    #puts "Transition: " << @active_transition.to_s << "/" << (@colors.length - 1).to_s
    init(@durations[@active_transition], @expiration_time)
    init_values
    calculate_argb_updates
    #puts "Reactivating: " << @reactivate.to_s
    activate if @reactivate
  end
  
  def init_values
    set_initial_colors
    @update_rates = {}
    @color_deltas = {}
  end
  
  def to_s
    return "update frame: " << @update_tick.to_s
  end
  
  private
  
  def validate_colors(colors)
    @colors = colors.respond_to?(:each) ? colors : [colors]

    index = 0
    @colors.each do |color|
      @colors[index] = color.is_a?(Gosu::Color) ? color : Gosu::Color.argb(color)
      index += 1
    end
  end
  
  def validate_durations(durations)
    # Initialize duration(s) array
    @durations = durations.respond_to?(:each) ? durations : [durations]
    
    # Check for nil and too-short durations
    index = 0
    @durations.each do |duration|
      if duration == nil
        @durations[index] = Min_Duration
      else
        if duration < Min_Duration
          @durations[index] = Min_Duration
        end
      end
      index += 1
    end

    # Check for equal length transition and duration arrays
    if not(@durations.length == @colors.length)
      diff = @colors.length - @durations.length
      #puts "Adjusting " <<  @durations.length.to_s << " durations for " << @colors.length.to_s << " color transitions"
      if not(diff < 0)
        diff.times do
          #puts "Adding a duration of " << @durations[0].to_s
          @durations.push(@durations[0])
        end
      else
        #puts "Removing " << diff.abs.to_s << " durations"
        diff.abs.times do
          @durations.slice!(@colors.length)
          #puts "New durations count: " << @durations.length.to_s
        end
      end
    end
  end
  
  def next_transition
    if not(@colors.length == 1)
      if not(@active_transition == @colors.length - 1)
        #puts "Not at the end of transitions yet"
        if not(@loop_style == Loop_Style::LIFO)
          #puts "Loop Style: FIFO, incrementing transition by 1"
          @active_transition += 1
        else
          #puts "Loop Style: LIFO, incrementing transition by direction"
          @loop_direction = :forward if @loop_direction == nil
          @loop_direction = :forward if @active_transition == 0 && @loop_direction == :backward
          #puts "Loop Direction: " << @loop_direction.to_s
          @active_transition += @loop_direction == :forward ? 1 : -1
        end
      else
        #puts "End of transitions array"
        if @looping
          if not(@loop_style == Loop_Style::LIFO)
            #puts "Loop Style: FIFO, going to beginning of list"
            @active_transition = 0
          else
            #puts "Loop Style: LIFO, going backwards in list"
            @loop_direction = :backward
            @active_transition -= 1
          end
          #puts "Reached the end, but looping"
          stop_transitions = false
        else
          #puts "Reached the end and not looping"
          stop_transitions = true
        end
      end
    else
      #puts "Only 1 transition"
    end
    if not(stop_transitions)
      #puts "Reset variables for new transition"
      @reactivate = true
      reset
    else
      #puts "Transitions stopped, not resetting"
      @reactivate = false
    end
  end
  
  def set_initial_colors
    @initial_colors = {}
    Color_Positions.each do |position|
      @initial_colors.store(position, @target.send(position))
    end
  end
  
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
      diffs.store(position, @colors[@active_transition].send(position) - @target.send(position))
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
