# 04 / 12 / 2017 Carlos Hernandez Alvarez

##API Wallet para conekta

### Consultar Wallets

  ####GET Orden[/api/v1/wallets] 

  Parametros: Sin parametros.

  Respuesta:  

    {
        "status":"succes",
        "message":"show wallets",
        "data":[
            {
                "id":1,
                "numcuenta":10001,
                "fondo":400.5,
                "created_at":"2017-12-05T00:44:39.000Z",
                "updated_at":"2017-12-05T00:44:45.000Z"
            }
        ]
    }

 ### Crear un Wallet

  ####POST Orden[/api/v1/wallets] 

  Parametros: 
           nombrecliente: (string),

           numerotarjeta: (string),

           tipotarjeta: (integer),

           fondo: (float)

  Respuesta:  

  {
    "status": "Succes.",
    "message": "wallet and customer created",
    "wallet": {
        "fondo": 400.5,
        "id": 1,
        "numcuenta": 10001,
        "created_at": "2017-12-05T00:44:39.000Z",
        "updated_at": "2017-12-05T00:44:45.000Z"
    },
    "cliente": {
        "id": 1,
        "nombre": "carlos hernandez",
        "numcuenta": 10001,
        "created_at": "2017-12-05T00:44:38.000Z",
        "updated_at": "2017-12-05T00:44:38.000Z"
    },
    "gateway": {
        "status": "succes",
        "message": "El monto ha sido retirado de la tarejta ****0009",
        "saldo": 66303.5,
        "monto": "400.50"
    }
  }

 

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

