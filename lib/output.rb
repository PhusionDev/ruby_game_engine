class Output
  attr_accessor :windows, :active_window, :buffers, :active_buffer
  
  def initialize
    @windows = []
    @buffers = []
  end
  
  def add_window(window)
    if window.is_a?(Gosu::Window)
      if not(@windows.include?(window))
        @windows.push(window)
        if @active_window == nil
          select_active_window(window)
        end
      end
    end
  end
  
  def remove_window(window)
  end
  
  def select_active_window(window)
    if window.is_a?(Gosu::Window)
      if @windows.include?(window)
        @active_window = window
      end
    end
  end
  
  def add_buffer(buffer)
  end
  
  def remove_buffer(buffer)
  end
end