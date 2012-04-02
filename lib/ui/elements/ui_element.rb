class UI_Element
  include Positionable
  include Dimensions
  include Visibility

  def initialize(x = 0, y = 0)
    move_to(x, y)
  end

  def active=(value)
    if value == true || value == false
      @active = value
    end
  end

  def active
    return @active
  end
end
