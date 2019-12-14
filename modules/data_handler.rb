module Modules
  module DataHandler
    NUMBER_OF_BINARY_DIGITS_IN_HEX = 4
    EMPTY_DIGIT = '0'.freeze

    # substitution block
    S_BLOCK = [[4, 10, 9, 2, 13, 8, 0, 14, 6, 11, 1, 12, 7, 15, 5, 3],
               [14, 11, 4, 12, 6, 13, 15, 10, 2, 3, 8, 1, 0, 7, 5, 9],
               [5, 8, 1, 13, 10, 3, 4, 2, 14, 15, 12, 7, 6, 0, 9, 11],
               [7, 13, 10, 1, 0, 8, 9, 15, 14, 4, 6, 12, 11, 2, 5, 3],
               [6, 12, 7, 1, 5, 15, 13, 8, 4, 10, 9, 14, 0, 3, 11, 2],
               [4, 11, 10, 0, 7, 2, 1, 13, 3, 6, 8, 5, 9, 12, 15, 14],
               [13, 11, 4, 1, 3, 15, 5, 9, 0, 10, 14, 7, 6, 8, 2, 12],
               [1, 15, 13, 0, 5, 7, 10, 4, 9, 2, 3, 14, 6, 11, 8, 12]]

    def hex_to_binary(hex_string)
      hex_string.hex.to_s(2).rjust(NUMBER_OF_BINARY_DIGITS_IN_HEX*hex_string.size, EMPTY_DIGIT)
    end

    # ksd - key storage device
    def key_to_ksd(key)
      key.scan(/.{8}/).map { |storage| hex_to_binary(storage) }
    end

    def sum_mod_32(a, b)
      result = ''
      a.size.times { |index| result[index] = (a[index].to_i ^ b[index].to_i).to_s }
      result
    end

    def data_substitute(data, row_index)
      result = []
      data.scan(/.{4}/).each do |data_sample|
        s_block_value = S_BLOCK[row_index][bin_to_dec(data_sample)]
        result << dec_to_bin(s_block_value)
      end
      result.join
    end

    def shift_left_11(number)
      number.split('').rotate(11).join
    end

    def bin_to_hex(number)
      number.scan(/.{4}/).map { |data_sample| data_sample.to_i(2).to_s(16) }.join
    end

    private

    def bin_to_dec(number)
      number.to_i(2)
    end

    def dec_to_bin(number)
      number.to_s(2).rjust(NUMBER_OF_BINARY_DIGITS_IN_HEX, EMPTY_DIGIT)
    end
  end
end
