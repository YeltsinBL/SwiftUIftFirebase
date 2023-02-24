# SwiftUIftFirebase
## _Aplicación inicial en SwiftUI con Firebase_

## Configurando Firebase en nuestra aplicación utilizando SPM
- Iniciamos agregando el package de 'Github Firebase SDK' utilizando SPM (Swift Package Manager) y seleccionamos las dependencias a utilizar, en este caso son FirebaseFirestore y FirebaseFirestoreSwift.
- Agregamos el archivo descargado de Firebase al proyecto de nuestras aplicación, para inicializar Firebase.
- Inicializamos Firebase en el archivo 'main' de la aplicación creando la clase 'AppDelegate' y luego, registrando la clase en la estructura del main.

## Trackear Eventos
### Registrar un EventLog en Firebase
- `Tracker`: creamos métodos static que se conecten al 'LogEvent' de Firebase para registrarlo.
- `LinkViewModel`: utilizamos los métodos static dentro de los métodos existentes de acuerdo a los nombres del trackeo.

### Mostrar el detalle de los EventLog en la consola de XCode
- Editar Schema > Run > Arguments: en 'Arguments Passed On Launch' agregamos lo siguiente '-FIRAnalyticsDebugEnabled'
