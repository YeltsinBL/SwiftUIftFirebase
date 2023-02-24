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
- `LinkViewModel`: instanciamos el Repository y lo instanciamos.
-- Creamos las variables públicas para hacer los cambios en la vista.
-- Creamos un método que utiliza el método de obtener información del Repository para actualizar las variables globales.
- `LinkView`: Instanciamos el ViewModel para utilizar el método de obtener información dentro de un 'Task'.
-- Como la información se obtiene en array, lo utilizamos en un ForEach para acceder a sus propiedades y utilizarlo en los elementos de la vista.
- `HomeView`: llamamos al 'LinkView' para visualizarlo dentro de esta vista y le pasamos el ViewModel.