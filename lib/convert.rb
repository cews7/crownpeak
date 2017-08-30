#Convert 2523.04
# => "Two thousand five hundred twenty-three and 04/100 dollars"
require 'pry'
class Convert
  attr_accessor :m

  def money_to_words(a)
    words = ""
    decimal_chopper(a)
    m.reverse.chars.each_with_index do |char, index|
      unless char == "0" && m.to_s.reverse.chars[index + 1] != "1"
        words = include_places(words, index, char)
      end
      if index % 3 == 1
        if char == "1"
          ten_check(char, a, words, index)
        else
          words = dic_up_to_ninety[char] + words
        end
      else
        words = dic_up_to_nine[char] + words
      end
    end
    print "#{words}#{fraction_check(a)} dollar(s)"
  end

  private

  def dic_up_to_nine
    {"0" => "", "1" => "one ", "2" => "two ", "3" => "three ", "4" => "four ", "5" => "five ",
     "6" => "six ", "7" => "seven ", "8" => "eight ", "9" => "nine "}
  end

  def dic_up_to_ninety
    {"0" => "", "1" => "teen", "2" => "twenty ", "3" => "thirty ", "4" => "forty ",
     "5" => "fifty ", "6" => "sixty ", "7" => "seventy ", "8" => "eigthy ", "9" => "ninety "}
  end

  def teens
    {"one" => "eleven", "two" => "twelve", "three" => "thirteen",
     "four" => "fourteen", "five" => "fifteen", "six" => "sixteen", "seven" => "seventeen",
     "eight" => "eighteen", "nine" => "nineteen"}
  end

  def places
    ["hundred ", "thousand ", "million "]
  end

  def fraction_check(a)
    cents = ""
    collector = []
    a.to_s.chars do |char|
      collector << char
      cents << char if collector.include? "."
    end
    !cents.empty? ? " and " + cents[1..-1] + "/100" : cents = ""
  end

  def teen_check(words, char)
    words_arr = words.split
    words_arr[0] = teens[words_arr[0]]
    return words_arr.join(' ')
  end

  def decimal_chopper(a)
    if a.to_s.chars.include? "."
      @m = a.to_s.chop.chop.chop
    else
      @m = a.to_s
    end
  end

  def ten_check(char, a, words, index)
    if a.to_s.reverse.chars[index - 1] == "0"
      words = "ten " + words
    else
      words = teen_check(words, char)
    end
  end

  def include_places(words, index,char)
    if index % 3 == 2 && char != "0"
     words = places[0] + words
    elsif index == 3
     words = places[1] + words
    elsif index == 6
     words = places[2] + words
    end
   return words
  end
end
Convert.new.money_to_words(22245.78)
