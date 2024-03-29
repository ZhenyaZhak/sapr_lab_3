require_relative 'modules/data_handler'

class CryptoAlg
  include Modules::DataHandler

  def initialize(key, data)
    @storage_1 = data[0..7]
    @storage_2 = data[8..15]
    @ksd = key_to_ksd(key)
  end

  def perform
    0.upto(23).each do |index|
      converted_number = conversion_iteration(index % 8)

      @storage_2 = @storage_1
      @storage_1 = converted_number
    end

    7.downto(0).each do |index|
      converted_number = conversion_iteration(index)

      @storage_2 = @storage_1
      @storage_1 = converted_number
    end

    (@storage_1 + @storage_2).upcase
  end

  private

  def conversion_iteration(index)
    sum_1 = sum_mod_32(@storage_1, @ksd[index])

    handled_sum = data_substitute(sum_1)

    shifted_data = shift_left_11(handled_sum)

    sum_mod_2(shifted_data, @storage_2)
  end
end
