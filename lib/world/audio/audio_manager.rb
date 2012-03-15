require_relative 'track'
require_relative 'effect'
require_relative 'ambient_sound'

class Audio_Manager
  attr_accessor :tracks, :active_track
  attr_accessor :effects, :active_effects
  attr_accessor :ambient_sounds, :active_ambient_sounds
  
  def initialize
    @tracks = []
    @effects = []
    @active_effects = []
    @ambient_sounds = []
    @active_ambient_sounds = []
  end
  
  def update
  end
end