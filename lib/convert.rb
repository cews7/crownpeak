#Convert 2523.04
# => "Two thousand five hundred twenty-three and 04/100 dollars"
require 'pry'
class Convert
  def amount_to_words(a)
    if a.to_s.include? "."
      with_decimal(a)
    else
      without_decimal(a)
    end
  end

  def with_decimal(a)
    cents = a.to_s.reverse[0..1].reverse
    amount_minus_cents = a.to_s.chop.chop.chop
    generate_words(amount_minus_cents, cents)
  end

  def without_decimal(a)
  end

  def generate_words(amount_minus_cents, cents = nil)
    phrase = ''
    amount_minus_cents.chars.reverse.map do |num|
      phrase << convert_number_to_word(phrase, amount_minus_cents, num)
    end
    print "#{phrase}and #{fraction(cents)} dollars"
  end

  def convert_number_to_word(phrase, amount_minus_cents, num)
    solo_ten_check(phrase, amount_minus_cents)
    !phrase.eql?("ten ") ? begin_filter(phrase, amount_minus_cents, num) : ""
  end

  def solo_ten_check(phrase, amount_minus_cents)
    amount_minus_cents.eql?("10") && !phrase.include?("ten") ? phrase << "ten " : ""
  end

  def begin_filter(phrase, amount_minus_cents, num)
    if amount_minus_cents.length.eql?(1)
      dictionary_up_to_nine[num]
    else
      amount_over_single_digit(phrase, amount_minus_cents, num)
    end
  end

  def amount_over_single_digit(phrase, amount_minus_cents, num)
    if amount_minus_cents.length > 2
      num_to_word(amount_minus_cents, num) + ' ' + place_value_search(amount_minus_cents, num)
    else
      num_to_word(amount_minus_cents, num)
    end
  end

  def num_to_word(amount_minus_cents, num)
    if amount_minus_cents.to_i > 10 && amount_minus_cents.to_i < 20
      eleven_thru_nineteen(amount_minus_cents, num)
    elsif amount_minus_cents.to_i > 19 && amount_minus_cents.to_i < 100
      twenty_thru_ninety_nine(amount_minus_cents, num)
    else
      hundred_and_over(amount_minus_cents, num)
    end
  end

  def eleven_thru_nineteen(amount_minus_cents, num)
  end

  def twenty_thru_ninety_nine(amount_minus_cents, num)
    #solve for 20, 30, 40, etc...
    if amount_minus_cents[1].eql?("0") && !phrase.include?(dictionary_up_to_ninety[amount_minus_cents[0]])
      dictionary_up_to_ninety[amount_minus_cents[0]]
    end
  end

  def hundred_and_over(amount_minus_cents, num)
  end

  def place_value_search(amount_minus_cents, num)
  end

  def fraction(cents)
    "#{cents}/100"
  end

  def dictionary_up_to_nine
    {"0" => "zero ", "1" => "one ", "2" => "two ", "3" => "three ", "4" => "four ", "5" => "five ",
     "6" => "six ", "7" => "seven ", "8" => "eight ", "9" => "nine "}
  end

  def dictionary_up_to_ninety
    {"0" => "", "1" => "teen", "2" => "twenty ", "3" => "thirty ", "4" => "forty ",
     "5" => "fifty ", "6" => "sixty ", "7" => "seventy ", "8" => "eigthy ", "9" => "ninety "}
  end

  def dictionary_for_teens
    {"one" => "eleven", "two" => "twelve", "three" => "thirteen",
     "four" => "fourteen", "five" => "fifteen", "six" => "sixteen", "seven" => "seventeen",
     "eight" => "eighteen", "nine" => "nineteen"}
  end

  def place_values
    ["hundred ", "thousand ", "million ", "billion "]
  end
end
Convert.new.amount_to_words("%.2f" % 20.09)
