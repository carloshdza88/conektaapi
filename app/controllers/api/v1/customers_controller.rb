module Api
    module V1
      class CustomersController < ApplicationController

        def index
            clientes = Customer.all
            
            render json: {status: 'succes' , message: 'show costumers' , data: clientes}
        end

      end
    end
end