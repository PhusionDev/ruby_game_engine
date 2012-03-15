class Font_Cache
  attr_accessor :fonts
  
  def initialize
    @font_heights = []
    populate_font_heights
    @font_names = ["Arial", "Times New Roman", "Verdana"]
    @fonts = Hash.new(Gosu::Font.new($output.active_window, "Arial", 14))
    load_fonts
  end
  
  private
  def populate_font_heights
    min_height = 12
    max_height = 48
    by_sequence_of = 2
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
          @fonts.store((font_name + "_" + font_height.to_s).to_sym, Gosu::Font.new($output.active_window, font_name, font_height))
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