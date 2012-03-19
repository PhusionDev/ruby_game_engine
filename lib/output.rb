class Output
  attr_accessor :windows, :active_window, :buffers, :active_buffer
  
  def initialize
    @windows = {}
    @buffers = {}
  end
  
  def add(name, output)
    name.to_sym if not(name.is_a?(Symbol))
    
    if output.is_a?(Gosu::Window)
      if @windows[name] == nil
        @windows.store(name, output)
        if @active_window == nil
          select_active_window(name)
        end
      end
    elsif output.is_a?(Buffer)
      if @buffers[name] == nil
        @buffers.store(name, output)
      end
    end
  end
  
  def window(name)
    return @windows[name]
  end
  
  def buffer(name)
    return @buffers[name]
  end
  
  def remove(name, output_type)
    name.to_sym if not name.is_a?(Symbol)
    output_type.to_sym if not output_type.is_a?(Symbol)
    
    case output_type
      when :window, :windows
        @windows.delete(name) if not(@windows[name] == nil)
      when :buffer, :buffers
        @buffers.delete(name) if not(@buffers[name] == nil)
      else
    end 
  end
  
  def select_active_window(name)
    if not(@windows[name] == nil)
      @active_window = @windows[name]
    end
  end
  
  private
end