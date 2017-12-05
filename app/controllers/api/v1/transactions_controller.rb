module Api
    module V1
       class TransactionsController < ApplicationController

        def index
            historico = Transaction.all

            render json: { status: 'succes' , message: 'historico' , data: historico } ,status: :ok
        end

        def create
            # Parametros:

            # numcuentaorigen (integer)
            # numcuentadestino (integer)
            # monto (float)

            # Verificar el saldo en la cuenta de origen , 
        

            # Registrar el retiro de la cuenta origen
            Transaction.create(numcuenta: params[:numcuentaorigen] , 
                               deposito: 0 , retiro: params[:monto],saldo: 2000)


            # Registrar el deposito en la cuenta destino                   
            Transaction.create(numcuenta: params[:numcuentadestino] , 
            deposito: params[:monto] , retiro: 0 ,saldo: 4000)




        end
        
       end
    end
end