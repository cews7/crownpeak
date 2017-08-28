#Convert 2523.04
# => "Two thousand five hundred twenty-three and 04/100 dollars"
class Convert
  def nums_left_of_decimal(dollar_amount)
    collector = Array.new
    dollar_amount.to_s.chars do |char|
      char == '.' ? break : collector << char
    end
    collector
  end

  def ints_to_words
    {"0" => "zero ", "1" => ["one ", "ten "], "2" => ["two ", "twenty "], "3" => ["three ", "thirty "], "4" => "four ", "5" => "five ", "." => "and "}
  end

  def four_money_to_words(dollar_amount)
    clause = String.new
    if nums_left_of_decimal(dollar_amount).count.eql? 4
      nums_left_of_decimal(dollar_amount).each_with_index do |num, index|
        clause << ints_to_words[num][0] unless index.eql? 2
        clause << ints_to_words[num][1] if index.eql? 2
      end
      print clause.split[0] + " thousand " + clause.split[1] + " hundred " + clause.split[2] + clause.split[3] + cents(dollar_amount) + " dollars"
    end
  end

  def cents(dollar_amount)
    cents = ""
    collector = []
    dollar_amount.to_s.chars do |char|
      collector << char
      cents << char if collector.include? "."
    end
    !cents.empty? ? " and " + cents[1..-1] + " / 100" : cents = ""
  end
end

Convert.new.four_money_to_words(1120)
