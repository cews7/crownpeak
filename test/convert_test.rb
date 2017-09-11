require 'minitest/autorun'
require './lib/convert'

class ConvertTest < Minitest::Test
  def setup
    @c = Convert.new
  end

  def test_convert_one_dollar
     assert_output("one  dollar(s)") { @c.amount_to_words(1) }
  end

  def test_convert_twenty_dollars
    assert_output("twenty  dollar(s)") { @c.amount_to_words(20) }
  end

  def test_convert_twenty_four_dollars
    assert_output("twenty four  dollar(s)") { @c.amount_to_words(24) }
  end

  def test_convert_hundred_seventy_two_dollars
    assert_output("one hundred seventy two  dollar(s)") { @c.amount_to_words(172) }
  end

  def test_convert_four_hundred_eleven_dollars
    assert_output("four hundred eleven dollar(s)") { @c.amount_to_words(411) }
  end

  def test_convert_thousand_thirty_six_dollars
    assert_output("one thousand thirty six  dollar(s)") { @c.amount_to_words(1036) }
  end

  def test_convert_three_million_dollars
    assert_output("three million  dollar(s)") { @c.amount_to_words(3000000) }
  end

  #CENTS INCLUDED
  def test_convert_two_hundred_dollars_twenty_five_cents
    assert_output("two hundred  and 25/100 dollar(s)") { @c.amount_to_words(200.25) }
  end

  def test_convert_twelve_dollars_eleven_cents
    assert_output("twelve and 11/100 dollar(s)") { @c.amount_to_words(12.11) }
  end

  def test_convert_six_hundred_forty_eight_dollars_ninety_three_cents
    assert_output("six hundred forty eight  and 93/100 dollar(s)") { @c.amount_to_words(648.93) }
  end

  def test_convert_two_thousand_five_hundred_twenty_three_dollar_four_cents
    assert_output("two thousand five hundred twenty three  and 04/100 dollar(s)") { @c.amount_to_words(2523.04) }
  end
  #EDGE CASES
  def test_convert_ten_dollars
    assert_output("ten  dollar(s)") { @c.amount_to_words(10) }
  end

  def test_twelve_dollars
    assert_output("twelve dollar(s)") { @c.amount_to_words(12) }
  end

  def test_convert_thousand_fifty_four_dollars
    assert_output("one thousand fifty four  dollar(s)") { @c.amount_to_words(1054) }
  end

  def test_convert_teens
    assert_output("thirteen dollar(s)") { @c.amount_to_words(13) }
    assert_output("fourteen dollar(s)") { @c.amount_to_words(14) }
    assert_output("fifteen dollar(s)") { @c.amount_to_words(15) }
    assert_output("sixteen dollar(s)") { @c.amount_to_words(16) }
    assert_output("seventeen dollar(s)") { @c.amount_to_words(17) }
    assert_output("eighteen dollar(s)") { @c.amount_to_words(18) }
    assert_output("nineteen dollar(s)") { @c.amount_to_words(19) }
  end
end
