require_relative 'sprite'

class Sprite_Manager
  attr_accessor :sprites, :active_sprites
  
  def initialize
    @sprites = []
    @active_sprites = []
  end
  
  def add_sprite(sprite)
    if sprite.is_a?(Sprite)
      if not(@sprites.include?(sprite))
        @sprites.push(sprite)
      end
    end
  end
  
  def remove_sprite(sprite)
    if sprite.is_a?(Sprite)
      if @sprites.include?(sprite)
        if @active_sprites.include?(sprite)
          sprite.deactivate
          @active_sprites.delete(sprite)          
        end
        @sprites.delete(sprite)
      end
    end
  end
  
  def new_sprite
  end
  
  def update
    if not(@active_sprites.empty?)
      @active_sprites.each do |sprite|
        # Update logic goes here
      end
    end
  end
  
  private
  
end