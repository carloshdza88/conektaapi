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

                #render json: { data: wallet_origen , fondo: wallet_origen.fondo}

               
                #Verificar si existe el wallet destino
                if wallet_destino.present?

                    #Calcular la comisión para descontarla del monto

                    comisiones = Commission.where("? >= montominimo and ( ? <= montomaximo  or montomaximo=null)",
                                            params[:monto].to_f,params[:monto].to_f)

                    comisiones = comisiones.first

                    #Se calcula el descuento.
                    cantidad = params[:monto].to_f -
                               (params[:monto].to_f * comisiones.porcentaje.to_f / 100) - 
                               comisiones.tasafija.to_f

                    wallet_origen = wallet_origen.first
                    wallet_destino = wallet_destino.first
                    
                    if wallet_origen.fondo >= params[:monto].to_f

                        # Registrar el retiro de la cuenta origen
                        Transaction.create(numcuenta: params[:numcuentaorigen] , 
                                            deposito: 0 , 
                                            retiro: cantidad ,
                                             saldo: wallet_origen.fondo - cantidad , 
                                       descripcion: 'Se retira ' + 
                                       cantidad.to_s + ' para la transacción')

                            # Registrar el deposito en la cuenta destino                   
                        Transaction.create(numcuenta: params[:numcuentadestino] , 
                                            deposito: cantidad , 
                                              retiro: 0 ,
                                               saldo: wallet_destino.fondo + cantidad.to_f , 
                                         descripcion: 'Se recibe ' + cantidad.to_s + ' en la cuenta')


                            render json: { status: 'succes' , 
                                message: 'Se realizo el envío existosamente de ' + 
                                            cantidad.to_s + ' de la cuenta ' + 
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