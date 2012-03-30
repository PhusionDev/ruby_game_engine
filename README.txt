2012-03-29 Notes
Currently Implemented:
  Game engine components skeleton with individual managers
  Basic user interface framework
    UI_Label, UI_Image
  Basic game-objects
    Time_Object, Color_Transition and FPS_Object
  External test framework for running test code without
    modifying the core engine code
  Control schemes, and control scheme switching via a call to:
    $controls_manager.set_active_control_scheme(Foo_Controls)
