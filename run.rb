require 'pry'
require_relative 'crypto_alg'

key = 'FEDCBA9876543210FEDCBA9876543210FEDCBA9876543210FEDCBA9876543210'

input_data = '0123456789ABCDEF'
out_data = '81C23AD5A64EAFE9'

CryptoAlg.new(key, input_data).perform
