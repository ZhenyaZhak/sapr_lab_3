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

    # ksd - key storage device
    def key_to_ksd(key)
      key.scan(/.{8}/).reverse
    end

    def sum_mod_32(a, b)
      (a.hex + b.hex).to_s(16).split(//).last(8).join.rjust(8, EMPTY_DIGIT)
    end

    def sum_mod_2(a, b)
      (a.hex ^ b.hex).to_s(16).split(//).last(8).join.rjust(8, EMPTY_DIGIT)
    end

    def data_substitute(data)
      data.split(//).reverse.map.with_index { |val, index| S_BLOCK[index][val.to_i(16)].to_s(16) }.reverse.join
    end

    def shift_left_11(number)
      hex_to_binary(number).split(//).rotate(11).join.scan(/.{4}/).map { |sample| sample.to_i(2).to_s(16) }.join
    end

    private

    def hex_to_binary(hex_string)
      hex_string.hex.to_s(2).rjust(NUMBER_OF_BINARY_DIGITS_IN_HEX*hex_string.size, EMPTY_DIGIT)
    end
  end
end
