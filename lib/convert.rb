#Convert 2523.04
# => "Two thousand five hundred twenty-three and 04/100 dollars"
require 'pry'
class Convert
  attr_accessor :phrase

  def amount_to_words(a)
    if a.include? "."
      with_decimal(a)
    else
      without_decimal(a)
    end
  end

  def with_decimal(a)
    cents = a.reverse[0..1].reverse
    amount_minus_cents = a.chop.chop.chop
    route_selction(amount_minus_cents, cents)
  end

  def without_decimal(a)
    route_selction(amount_minus_cents, cents)
  end

  def route_selction(amount_minus_cents, cents)
    if amount_minus_cents.to_i < 1000
      generate_words_up_to_thousand(amount_minus_cents, cents)
    else
      generate_words_past_thousand(amount_minus_cents, cents)
    end
  end

  def generate_words_past_thousand(amount_minus_cents, cents)
    thousand_over_phrase = ''
    counter = 1
    amount = amount_minus_cents.to_i
    while amount != 0 do
      current_place = place_value_search(amount_minus_cents)
      current_value = amount_minus_cents.to_i / (1000 ** (amount_minus_cents.length / 3 - counter + 1))
      generate_words_up_to_thousand("#{current_value}", cents)
      counter += 1
      amount = amount / (1000 ** counter)
      thousand_over_phrase << phrase + current_place
    end
    print thousand_over_phrase + "and " + fraction(cents) + " dollars" if !cents.eql?("00")
    print thousand_over_phrase + "dollars" if cents.eql?("00")
  end

  def place_value_search(amount_minus_cents)
    index = amount_minus_cents.length / 3 - 1
    place_values[index]
  end

  def place_values
    ["thousand ", "million ", "billion "]
  end

  def generate_words_up_to_thousand(amount_minus_cents, cents)
    @phrase = ''
    amount_minus_cents.chars.reverse.map do |num|
      phrase << convert_number_to_word(amount_minus_cents, num)
    end
     print_phrase(amount_minus_cents, cents) unless caller_locations.first.label.eql?("generate_words_past_thousand")
  end

  def print_phrase(amount_minus_cents, cents)
    print "#{phrase}dollar" if amount_minus_cents == "1"
    if cents == "00" && amount_minus_cents != "1"
      print "#{phrase}dollars"
    elsif amount_minus_cents != "1"
      print "#{phrase}and #{fraction(cents)} dollars"
    end
  end

  def convert_number_to_word(amount_minus_cents, num)
    solo_ten_check(amount_minus_cents)
    !phrase.eql?("ten ") ? begin_filter(amount_minus_cents, num) : ""
  end

  def solo_ten_check(amount_minus_cents)
    amount_minus_cents.eql?("10") && !phrase.include?("ten") ? phrase << "ten " : ""
  end

  def begin_filter(amount_minus_cents, num)
    if amount_minus_cents.length.eql?(1)
      dictionary_up_to_nine[num]
    else
      amount_over_single_digit(amount_minus_cents, num)
    end
  end

  def amount_over_single_digit(amount_minus_cents, num)
    if amount_minus_cents.length > 2
      num_to_word(amount_minus_cents, num)
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
      hundred_thru_nine_hundred_ninety_nine(amount_minus_cents, num)
    end
  end

  def eleven_thru_nineteen(amount_minus_cents, num)
    if amount_minus_cents[0].eql?("1") && !phrase.include?(dictionary_for_teens[amount_minus_cents[1]])
      dictionary_for_teens[amount_minus_cents[1]]
    else
      ""
    end
  end

  def twenty_thru_ninety_nine(amount_minus_cents, num)
    if !amount_minus_cents[1].eql?("0") && !phrase.include?(dictionary_up_to_ninety[amount_minus_cents[0]] + dictionary_up_to_nine[amount_minus_cents[1]])
      dictionary_up_to_ninety[amount_minus_cents[0]] + dictionary_up_to_nine[amount_minus_cents[1]]
    else
     handle_all_tens(amount_minus_cents, num)
    end
  end

  def handle_all_tens(amount_minus_cents, num)
    if !phrase.include?(dictionary_up_to_ninety[amount_minus_cents[0]])
      dictionary_up_to_ninety[amount_minus_cents[0]]
    else
      ""
    end
  end

  def hundred_thru_nine_hundred_ninety_nine(amount_minus_cents, num)
    if ("2".."9").include?(amount_minus_cents[1]) && !amount_minus_cents[2].eql?("0") && !phrase.include?(dictionary_up_to_nine[amount_minus_cents[0]] + "hundred " + dictionary_up_to_ninety[amount_minus_cents[1]] + dictionary_up_to_nine[amount_minus_cents[2]])
      dictionary_up_to_nine[amount_minus_cents[0]] + "hundred " + dictionary_up_to_ninety[amount_minus_cents[1]] + dictionary_up_to_nine[amount_minus_cents[2]]
    elsif amount_minus_cents[1].eql?("1") && !amount_minus_cents[2].eql?("0") && !phrase.include?(dictionary_up_to_nine[amount_minus_cents[0]] + "hundred " + dictionary_for_teens[amount_minus_cents[2]])
      dictionary_up_to_nine[amount_minus_cents[0]] + "hundred " + dictionary_for_teens[amount_minus_cents[2]]
    elsif amount_minus_cents[1].eql?("1") && amount_minus_cents[2].eql?("0") && !phrase.include?(dictionary_up_to_nine[amount_minus_cents[0]] + "hundred " + "ten ")
      dictionary_up_to_nine[amount_minus_cents[0]] + "hundred " + "ten "
    elsif amount_minus_cents[1].eql?("0") && !amount_minus_cents[2].eql?("0") && !phrase.include?(dictionary_up_to_nine[amount_minus_cents[0]] + "hundred " + dictionary_up_to_nine[amount_minus_cents[2]])
      dictionary_up_to_nine[amount_minus_cents[0]] + "hundred " + dictionary_up_to_nine[amount_minus_cents[2]]
    elsif amount_minus_cents[1].eql?("0") && amount_minus_cents[2].eql?("0") && !phrase.include?(dictionary_up_to_nine[amount_minus_cents[0]] + "hundred ")
      dictionary_up_to_nine[amount_minus_cents[0]] + "hundred "
    elsif ("2".."9").include?(amount_minus_cents[1]) && amount_minus_cents[2].eql?("0") && !phrase.include?(dictionary_up_to_nine[amount_minus_cents[0]] + "hundred " + dictionary_up_to_ninety[amount_minus_cents[1]])
      dictionary_up_to_nine[amount_minus_cents[0]] + "hundred " + dictionary_up_to_ninety[amount_minus_cents[1]]
    else
      ""
    end
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
    {"1" => "eleven ", "2" => "twelve ", "3" => "thirteen ",
     "4" => "fourteen ", "5" => "fifteen ", "6" => "sixteen ", "7" => "seventeen ",
     "8" => "eighteen ", "9" => "nineteen "}
  end
end
Convert.new.amount_to_words("%.2f" % 149.90)
