require 'test_helper'

class WalletTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "El wallet debe recibir todos los datos para poder ser creado" do
     wallet = Wallet.new
     assert_not wallet.valid?

  end

  
end
