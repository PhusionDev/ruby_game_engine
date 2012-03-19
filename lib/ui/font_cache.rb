class Font_Cache
  # Default font cache values and population behavior
  # Edit to fit your project's needs.
  # Font heights are measured in pixels.
  Min_Font_Height = 12
  Max_Font_Height = 48
  Interval = 2
  # Default fall-back font to return when an invalid font
  # is passed to the font cache
  Font = "Arial"
  Height = 14
  
  attr_accessor :fonts
  
  def initialize
    @font_heights = []
    populate_font_heights
    @font_names = ["Arial", "Times New Roman", "Verdana"]
    @fonts = Hash.new(Gosu::Font.new($output.active_window, Font, Height))
    load_fonts
  end
  
  private
  def populate_font_heights
    min_height = Min_Font_Height
    max_height = Max_Font_Height
    by_sequence_of = Interval
    ((max_height-min_height)/by_sequence_of).times do
      @font_heights.push(min_height)
      min_height += by_sequence_of
    end
  end
  
  def load_fonts
    @font_names.each do |font_name|
      @font_heights.each do |font_height|
        if @fonts['default'].name == font_name && @fonts['default'].height == font_height
          @fonts.store((font_name + "_" + font_height.to_s).to_sym, @fonts['default'])
        else
          @fonts.store((font_name + "_" + font_height.to_s).to_sym,
                        Gosu::Font.new($output.active_window, font_name, font_height))
        end
      end
    end
  end
  
  # Load/Save XML Data
  def from_xml(xml_file)
  end
  
  def to_xml
  end
end