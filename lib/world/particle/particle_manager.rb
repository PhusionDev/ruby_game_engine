require_relative 'particle'

class Particle_Manager
  attr_accessor :particles
  
  def initialize
    @particles = []
  end
  
  def update
    @particles.each do |particle|
    end
  end
end