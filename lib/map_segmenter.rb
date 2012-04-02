class Map_Segmenter
  attr_accessor :buffer, :tile_width, :tile_height, :segment_width, :segment_height, :segments
  attr_accessor :map_file, :map_bitmap, :map_tiles, :tile_uniq_mapping, :map_tiles_renamed, :scheme
  
  def initialize
    @buffer = Gosu::Window.new(640, 640, false)
  end
  
  def even_segments_width?
    if not(@map_bitmap == nil) && not(@tile_width == nil) && not(@segment_width == nil)
      if not(@tile_width == 0) && not(@segment_width == 0)
        if (@map_bitmap.width/@tile_width).modulo(@segment_width) == 0
          return true
        end
      else
        return "Undefined"
      end
    
      return false
    end
  end
  
  def even_segments_height?
    if not(@map_bitmap == nil) && not(@tile_height == nil) && not(@segment_height == nil)
      if not(@tile_height == 0) && not(@segment_height == 0)
        if (@map_bitmap.height/@tile_height).modulo(@segment_height) == 0
          return true
        end
      else
        return "Undefined"
      end
    
      return false
    end
  end
  
  #1  Load Map
  def load_map(map_file)
    load_message = ""
    if File::exists?(map_file)
      @map_file = map_file
      @map_bitmap = Gosu::Image.new(@buffer, @map_file, true)
      debug_message = "Image File Loaded Successfully"
    else
      debug_message = "Image Does Not Exist!"
    end
    
    return debug_message
  end

  #2  Set Tile Dimensions
  def set_tile_dimensions(width, height)
    @tile_width = width
    @tile_height = height
    debug_message = "Width: " << @tile_width.to_s << "px, " << "Height: " << @tile_height.to_s << "px"
    return debug_message
  end
  
  #3  Tilize Map
  def tilize_map(tile_width = @tile_width, tile_height = @tile_height)
    tilize = false
    if valid_width? && valid_height?
      debug_message = "Map Will Be Split Into " << tile_width.to_s << "x" << tile_height.to_s << "px Tiles"
      tilize = true
    elsif valid_width? && not(valid_height?)
      debug_message = "Map Width Cannot Segment Equally Into " << tile_width.to_s << "px Tiles"
    elsif not(valid_width?) && valid_height?
      debug_message = "Map Height Cannot Segment Equally Into " << tile_height.to_s << "px Tiles"
    else
      debug_message = "Map Cannot Segment Equally Into " << tile_width.to_s << "x" << tile_height.to_s << "px Tiles"
    end
    
    if tilize
      @map_tiles = Gosu::Image.load_tiles(@buffer, @map_file, tile_width, tile_height, true)
      @tiles_binary = []
      @map_tiles.each do |tile|
        @tiles_binary.push(tile.to_blob)
      end
      @unique_tiles = @tiles_binary.uniq
      @tile_uniq_mapping = []
      @tiles_binary.each do |tile|
        tile_num = 0
        @unique_tiles.each do |unique_tile|
          if tile == unique_tile
            @tile_uniq_mapping.push(tile_num)
            break
          else
            tile_num += 1
          end
        end
      end
      puts @tile_uniq_mapping.to_s
    end
    
    return debug_message
  end
  
  #4  Set Segment Size/Dimensions
  def set_segment_dimensions(width, height)
    @segment_width = width
    @segment_height = height
    debug_message = "Width: " << @segment_width.to_s << "tiles, " << "Height: " << @segment_height.to_s << "tiles"
    return debug_message
  end
  
  #5  Generate Segments
  def generate_segments
    tiles_per_map_row = @map_bitmap.width/@tile_width
    tiles_per_map_col = @map_bitmap.height/@tile_height
    segments_per_row = tiles_per_map_row/@segment_width
    segments_per_col = tiles_per_map_col/@segment_height
    tiles_per_segment_row = tiles_per_map_row/segments_per_row
    tiles_per_segment_col = tiles_per_map_col/segments_per_col
    tiles_per_segment = tiles_per_segment_row * tiles_per_segment_col
    
    @segments = Array.new(segments_per_row) {Array.new(segments_per_col)}
    
    (0...segments_per_row).each do |seg_row|
      (0...segments_per_col).each do |seg_col|
        segment = []
        (0...@segment_width).each do |tile_row|
          (0...@segment_height).each do |tile_col|
            segment.push(@tile_uniq_mapping[(seg_row * @segment_width + tile_row) * tiles_per_map_row + (seg_col * @segment_height + tile_col)])
          end
        end
        @segments[seg_row][seg_col] = segment
      end
    end
    
    return @segments.to_s
  end
  
  #6  Choose Naming Scheme
  def choose_naming_scheme(scheme)    
    if valid_scheme?(scheme)
      set_scheme(scheme)
      debug_message = "Scheme Successfully Chosen"
    else
      debug_message = "Invalid Naming Scheme"
    end
    
    return debug_message
  end
  
  #7  Name Tiles
  def name_tiles
    if @map_tiles.length > 0
      if @scheme = NamingScheme::NORMAL
      end
      
      if @scheme = NamingScheme::ORIGIN
      end
    end
  end
  
  #8  Save Tiles
  def save_tiles
    already_saved = []
    map_tile_num = 0
    @tile_uniq_mapping.each do |tile_num|
      if not(already_saved.include?(tile_num))
        @map_tiles[map_tile_num].save("tiles/tile_" << tile_num.to_s << ".bmp")
        already_saved.push(tile_num)
      end
      map_tile_num += 1
    end
    
    return "Save Complete"
  end
    
  # Private Class Methods
  private
  
  def valid_scheme?(scheme)
    case scheme
      when NamingScheme::NORMAL
        return true
      when NamingScheme::ORIGIN
        return true
      else
        return false
    end
  end
    
  def valid_width?
    return true if @map_bitmap.width.modulo(@tile_width) == 0
  end
  
  def valid_height?
    return true if @map_bitmap.height.modulo(@tile_height) == 0
  end
  
  def set_scheme(scheme)
    @scheme = scheme
  end
  
  def name_as_normal
    @map_tiles.each do |map_tile|
    
    end
  end
  
  def name_by_origin
    @map_tiles.each do |map_tile|
    end
  end
end

class NamingScheme
  NORMAL=1
  ORIGIN=2
  
  def to_s
    if self == 1
      return "Normal"
    end
    
    if self == 2
      return "Origin"
    end
  end
end
