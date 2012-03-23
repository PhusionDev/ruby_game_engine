require 'rubygems'

require_relative 'lib/mixins'
require_relative 'lib/game_window'

$version = "Untitled Game Engine (Ruby w/Gosu) by PhusionDev"
$application_path = Dir.pwd

$game_window = Game_Window.new
$game_window.show
