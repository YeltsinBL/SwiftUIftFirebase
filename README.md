# SwiftUIftFirebase
## _Aplicación inicial en SwiftUI con Firebase_

## Configurando Firebase en nuestra aplicación utilizando SPM
- Iniciamos agregando el package de 'Github Firebase SDK' utilizando SPM (Swift Package Manager) y seleccionamos las dependencias a utilizar.
- Agregamos el archivo descargado de Firebase al proyecto de nuestras aplicación, para inicializar Firebase.
- Inicializamos Firebase en el archivo 'main' de la aplicación creando la clase 'AppDelegate' y luego, registrando la clase en la estructura del main.

## Autenticación con Firebase
`AuthenticationView`:
- Renombramos el archivo de la vista 'ContentView' por 'AuthenticationView' para tenerlo mas ordenado.
- Creamos un enum que nos ayudara a saber que accion se va a realizar, si se inicia sesion o se registrarara.
- Utilizaremos este enum dentro de la struct de la View como una variable privada de tipo 'State'.
- Para visualizar las vistas de acuerdo a la accion, se mostrara como 'sheet'.
