require 'rubygems'

require_relative 'lib/mixins'
require_relative 'lib/game_window'

$version = "press spacebar to test a Color_Transition game object"
$application_path = Dir.pwd

$game_window = Game_Window.new
$game_window.show
