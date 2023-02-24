# SwiftUIftFirebase
## _Aplicación inicial en SwiftUI con Firebase_

## Configurando Firebase en nuestra aplicación utilizando SPM
- Iniciamos agregando el package de 'Github Firebase SDK' utilizando SPM (Swift Package Manager) y seleccionamos las dependencias a utilizar, en este caso son FirebaseFirestore y FirebaseFirestoreSwift.
- Agregamos el archivo descargado de Firebase al proyecto de nuestras aplicación, para inicializar Firebase.
- Inicializamos Firebase en el archivo 'main' de la aplicación creando la clase 'AppDelegate' y luego, registrando la clase en la estructura del main.

## Obtener información de la Base de datos: Firestore Database
- `LinkDataSource`: creamos las variables de conexión a la bd y el nombre de la colección de la bd.
-- Hacemos el método para obtener toda la información por documentos pasándole el nombre de la colección.
- `LinkRepository`: instanciamos el DataResource y lo inicializamos.
-- Creamos un método para utilizar el método de obtener la información del DataSource.
- `LinkViewModel`: instanciamos el Repository y lo inicializamos.
-- Creamos las variables públicas para hacer los cambios en la vista.
-- Creamos un método que utiliza el método de obtener información del Repository para actualizar las variables globales.
- `LinkView`: Instanciamos el ViewModel para utilizar el método de obtener información dentro de un 'Task'.
-- Como la información se obtiene en array, lo utilizamos en un ForEach para acceder a sus propiedades y utilizarlo en los elementos de la vista.
- `HomeView`: llamamos al 'LinkView' para visualizarlo dentro de esta vista y le pasamos el ViewModel.

## Modificar información de la Base de datos: Firestore Database
### Obtener información desde una URL
- `MetadataDataSource`: importamos el 'LinkPresentation' para utilizar el 'LPMetadataProvider' e instanciarlo.
-- Creamos el método para obtener la información de la URL, validando la URL e instanciando el 'LPMetadataProvider' para utilizar el 'startFetchingMetadata' que sera la que nos dara la informacion.
- `LinkRepository`: instanciamos el MetadataDataSource y lo inicializamos.
-- Creamos el método para utilizar el método de obtener información de la URL del MetadataDataSource.
- `LinkViewModel`: creamos el método para agregar la nueva información al array en memoria utilizando el método de obtener información de la URL del Repository.
- `LinkView`: utilizamos el método del ViewModel en el botón de crear.
