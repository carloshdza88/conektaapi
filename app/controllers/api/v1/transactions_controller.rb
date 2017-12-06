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
                                 deposito: 0 , 
                                   retiro: params[:monto] ,
                                    saldo: 2000 , 
                              descripcion: 'Se retira ' + params[:monto].to_s + ' para la transacción')


             # Registrar el deposito en la cuenta destino                   
             Transaction.create(numcuenta: params[:numcuentadestino] , 
                                 deposito: params[:monto] , 
                                   retiro: 0 ,
                                    saldo: 4000 , 
                              descripcion: 'Se recibe ' + params[:monto].to_s + ' en la cuenta')


             render json: { status: 'succes' , 
                           message: 'Se realizo el envío existosamente de ' + 
                                     params[:monto] + ' de la cuenta ' + 
                                     params[:numcuentaorigen].to_s + ' a la cuenta ' + 
                                     params[:numcuentadestino].to_s}, status: :ok                
                              


        end
        
       end
    end
end