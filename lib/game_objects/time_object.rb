require_relative 'game_object'

class Time_Object < Game_Object
  attr_accessor :update_tick, :time, :expired, :expiration_time
  
  def initialize(time, expiration_time = nil)
    init(time, expiration_time)
  end
  
  def init(time, expiration_time)
    @time = time
    @expiration_time = expiration_time
    @expired = false
    @update_calls = (3 * @time) / 50
    reset_timer
  end
  
  def activate
    super
  end
  
  def deactivate
    super
  end
  
  def reset_timer
    @update_tick = 0
  end
  
  def update
    if @update_tick == @update_calls
      deactivate
      return :end
    end
    if @active
      @update_tick += 1
      if not(@expiration_time == nil)
        set_to_expire if @update_tick >= (3 * @expiration_time / 50)
        return nil
      end
      return true
    else
      return false
    end
  end
  
  def set_to_expire
    @expired = true
  end
end