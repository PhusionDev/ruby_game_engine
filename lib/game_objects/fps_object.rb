require_relative 'game_object'

class FPS_Object < Game_Object 
  def update
    @fps = Gosu::fps() if @active
  end
  
  def to_s
    return @active ? @fps.to_s << " FPS" : "Inactive"
  end
end
