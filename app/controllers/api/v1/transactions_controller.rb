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
        
             wallet_origen = Wallet.where("numcuenta = ? " , params[:numcuentaorigen])

             wallet_destino = Wallet.where("numcuenta = ? " , params[:numcuentadestino])

             #Verificar si existe el wallet de origen
             if wallet_origen.present?

              #  render json: { data: wallet_origen , fondo: wallet_origen.fondo}

               
                #Verificar si existe el wallet destino
                if wallet_destino.present?

                    wallet_origen = wallet_origen.first
                    wallet_destino = wallet_destino.first
                    
                    if wallet_origen.fondo >= params[:monto].to_f

                        # Registrar el retiro de la cuenta origen
                        Transaction.create(numcuenta: params[:numcuentaorigen] , 
                                            deposito: 0 , 
                                            retiro: params[:monto] ,
                                             saldo: wallet_origen.fondo - params[:monto].to_f , 
                                       descripcion: 'Se retira ' + 
                                      params[:monto].to_s + ' para la transacción')

                            # Registrar el deposito en la cuenta destino                   
                        Transaction.create(numcuenta: params[:numcuentadestino] , 
                                            deposito: params[:monto] , 
                                              retiro: 0 ,
                                               saldo: wallet_destino.fondo + params[:monto].to_f , 
                                         descripcion: 'Se recibe ' + params[:monto].to_s + ' en la cuenta')


                            render json: { status: 'succes' , 
                                message: 'Se realizo el envío existosamente de ' + 
                                            params[:monto] + ' de la cuenta ' + 
                                            params[:numcuentaorigen].to_s + ' a la cuenta ' + 
                                            params[:numcuentadestino].to_s }, status: :ok  
                                        
                    else
                        render json: { status: 'denied' , message: 'El wallet con número de cuenta: ' + params[:numcuentaorigen]  + ' no tiene suficiente saldo.  Saldo actual:' + wallet_origen.fondo.to_s }                                       
                    end
                    

                else
                    render json: { status: 'denied' , message: 'El wallet destino con el número de cuenta:' + 
                    params[:numcuentadestino] + 
                   ' No existe.' }

                end

            else

                    render json: { status: 'denied' , message: 'El wallet de origen con el número de cuenta:' + 
                                                                params[:numcuentaorigen].to_s + 
                                                               ' No existe. ' }
                    
            end
             
                         

                         
                              


        end
        
       end
    end
end