require 'rubygems'

require_relative 'lib/mixins'
require_relative 'lib/game_window'

$version = "0.1.1 (Incomplete Intial Build)"
$application_path = Dir.pwd

$game_window = Game_Window.new
$game_window.show