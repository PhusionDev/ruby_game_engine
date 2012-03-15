class Game_Object
  attr_accessor :active
  
  def initialize
    @active = false
  end
  
  def activate
    @active = true
  end
  
  def deactivate
    @active = false
  end
  
  def update
    puts "override this method"
  end
  
  def to_s
    active_string = @active ? "" : "not "
    return "I am " << active_string << @active.to_s
  end
end