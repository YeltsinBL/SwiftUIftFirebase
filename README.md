# SwiftUIftFirebase
## _Aplicación inicial en SwiftUI con Firebase_

## Configurando Firebase en nuestra aplicación utilizando SPM
- Iniciamos agregando el package de 'Github Firebase SDK' utilizando SPM (Swift Package Manager) y seleccionamos las dependencias a utilizar.
- Agregamos el archivo descargado de Firebase al proyecto de nuestras aplicación, para inicializar Firebase.
- Inicializamos Firebase en el archivo 'main' de la aplicación creando la clase 'AppDelegate' y luego, registrando la clase en la estructura del main.

Lo que se ha realizado en este proyecto es lo siguiente:

## Autenticación
- Iniciar Sesion con Email y Password
- Iniciar Sesion con el proveedor de Facebook.
- Vincular ambas cuentas, desde Email a Facebook como viceversa.

## Base de Datos
- Utilizar la base de datos: Firestore Database
- Se realizó  un CRUD.
- Se obtuvo información mediante una URL.

## Trackear Eventos
- Se registró los eventos que realizan los metodos al hacer clic en el boton.

## Detectar CRASH o BUGS
### Fichero dSYM
- Se hizo seguimiento a las posibles causar por el cual la aplicacion se pueda Crashear o Buguear.

## REMOTE CONFIG Test A/B
- Se hizo una prueba de Test para saber cual es la probabilidad de mostrar cierto texto a los usuarios.

## Notificaciones PUSH (esta parte esta en su rama, no esta mergeado porque no lo he probado, no tengo cuenta de Developer en Apple)
- Para que funciones esta parte, se tiene que crear una cuenta como Developer en el portal de Apple.
- Se activó los permisos para recibir notificaciones.
- Se visualiza la notificación si la aplicación esta en primer plano como en segundo plano.

Guía de referencia en el canal de [SwiftBeta](https://www.youtube.com/watch?v=r1tGrqmTJ8s&list=PLeTOFRUxkMcoG4CZP7qAbkTgfj4ARDmxm&index=1)
