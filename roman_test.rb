require 'test/unit'

class RomanTest < Test::Unit::TestCase


    CONVERSIONS =
        {
            0 => '',
            1 => 'i',
            2 => 'ii',
            4 => 'iv',
            5 => 'v',
            6 => 'vi',
            9 => 'ix',
            10 => 'x',
            11 => 'xi',
            14 => 'xiv',
            15 => 'xv',
            20 => 'xx',
            40 => 'xl',
            50 => 'l',
            51 => 'li',
            90 => 'xc',
            101 => 'ci',
            200 => 'cc',
            400 => 'cd',
            500 => 'd',
            900 => 'cm',
            1000 => 'm'
        }

  def test_only_accepts_positive_integers
    assert_raise ArgumentError do
      -1.romanticise
    end
  end

  def test_conversions
    CONVERSIONS.each_pair do |decimal, roman|
      assert_equal(roman, decimal.romanticise())
    end
  end



end


class Integer
  def romanticise
    raise(ArgumentError, 'can only romanticise an integer') unless self >= 0

    @decimal = self
    @roman = ''

    convert_multiples(1000)
    convert_exponent(2)
    convert_exponent(1)
    convert_exponent(0)

    return @roman
  end

  private
  DECIMAL_TO_ROMAN =
    {
      1 => 'i',
      4 => 'iv',
      5 => 'v',
      9 => 'ix',
      10 => 'x',
      40 => 'xl',
      50 => 'l',
      90 => 'xc',
      100 => 'c',
      400 => 'cd',
      500 => 'd',
      900 => 'cm',
      1000 => 'm'
    }

  def convert_exponent(exponent)
    factor = 10 ** exponent
    convert_single(9 * factor)

    convert_single(5 * factor)

    convert_single(4 * factor)

    convert_multiples(1 * factor)
  end

  def convert_multiples(decimal_index)
    for i in 1..(@decimal / decimal_index)
      @roman += DECIMAL_TO_ROMAN[decimal_index]
    end
    @decimal %= decimal_index
  end

  def convert_single(decimal_index)
    if @decimal >= decimal_index
      @roman += DECIMAL_TO_ROMAN[decimal_index]
      @decimal -= decimal_index
    end
  end

end