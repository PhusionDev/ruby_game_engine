﻿require 'rubygems'

require_relative 'lib/mixins'
require_relative 'lib/game_window'

$version = "Press T for a test user interface"

game_window = Game_Window.new
game_window.show
