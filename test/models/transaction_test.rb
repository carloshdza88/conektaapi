require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "La transacción debe recibir todos los parametros para poder ser procesada." do
    transaccion = Transaction.new
    assert_not transaccion.valid?

 end
end
