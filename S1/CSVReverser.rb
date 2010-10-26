
module CSVDecoder
  SPLIT_REGEX = /[,;\t]/

  def decodeCSV
    self.split(SPLIT_REGEX)
  end
end

class String
  include CSVDecoder
end

module CSVEncoder
  def encodeCSV
    self.join ","
  end
end

class Array
  include CSVEncoder
end

if __FILE__ == $0
  while str = $stdin.gets
    puts str.decodeCSV.reverse.encodeCSV
  end
end
