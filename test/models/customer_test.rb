require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "El cliente debe recibir todos los datos para poder ser creado" do
    cliente = Customer.new
    assert_not cliente.valid?

 end
end
