class FPS_Object
  def initialize
    update
  end
  
  def update
    @fps = Gosu::fps()
  end
  
  def to_s
    return @fps.to_s
  end
end