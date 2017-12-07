module Api
    module V1
       class WalletsController < ApplicationController
        

            def index

                wallets = Wallet.all

                render json: { status: 'succes', message: 'show wallets' , data: wallets , parametro: params[:algo] } ,status: :ok
            end

            def show

                wallets = Wallet.find_by(numcuenta: params[:id])
               # wallets = wallets.first

               if wallets.present?
                
                  render json: { status: 'succes', message: 'Datos del Wallet' , data: wallets  } ,status: :ok
                
               else
                  render json: { status: 'denied', message: 'El wallet no existe' } ,status: :ok
                
               end


                 
            end
            
            def create
                require 'net/http'

                numero_cuenta_inicial = 10000
                ultimo_cliente = Customer.last

                #Generar un nuevo numero de cuenta para el cliente y el wallet
                if ultimo_cliente
                    numero_cuenta = numero_cuenta_inicial + 
                                    ultimo_cliente.id + 1
                else
                    numero_cuenta = numero_cuenta_inicial + 1
                end

                # Crear un nuevo cliente
                cliente = Customer.create( nombre: params[:nombrecliente] , numcuenta: numero_cuenta)

                nuevo_cliente = Customer.last

                # Crear un wallet para el cliente
                wallet = Wallet.new(numcuenta: nuevo_cliente.numcuenta , fondo: 0)
      
                # if wallet.valid? 
                if wallet.save
                  
                    #Fondear el wallet
                     
                    wallet_actual = Wallet.last

                    #Llamada al gateway metodo => retirarSaldo parametros => numerotarjeta , tipotarjeta, fondo
                    url = 'http://159.203.255.248/rest/WebService/servicio.php?metodo=retirarSaldo&numerotarjeta=' + 
                    params[:numtarjeta] + '&tipotarjeta=' + params[:tipotarjeta] + '&monto=' + params[:fondo]

                    uri = URI(url)           
                    Net::HTTP.get(uri) # => String
                    obj_json = JSON.parse(Net::HTTP.get(uri))

                    #Verificar la respuesta del gateway
                    if obj_json['status'] == 'succes'
                        #Si es correcto actualizar el fondo del wallet el cual tiene 0 en fondo.
                        wallet_actual.fondo = params[:fondo]
                        wallet_actual.save       
                        
                        #Si la respuesta del gatway es diferente a succes, se mantiene el fondo del wallet en 0.
                    
                    end

                    #Agregar el movimiento  a el historico de transacciones.

                    

                    Transaction.create(numcuenta: nuevo_cliente.numcuenta , 
                                       deposito: wallet_actual.fondo,
                                       retiro: 0, saldo: wallet_actual.fondo,
                                       descripcion: 'Se creo cuenta con: ' + wallet_actual.fondo.to_s + ' de saldo inicial')
                                                         
                    
                    render json: { status: 'Succes.' , message: 'El cliente y el wallet han sido creados', data: wallet_actual ,  cliente: nuevo_cliente , gateway: obj_json }, status: :ok                
         
                else
                    render json: { status: 'Not succes.' , message: 'Error '  }, status: :ok                   
                end

            end
       end
    end
end