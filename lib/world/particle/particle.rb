class Particle
  include Positionable
  include Dimensions
  include Gosu_Image
  include Colored
  include Visibility

  def initialize(x=0, y=0)
    move_to(x, y)
  end
end