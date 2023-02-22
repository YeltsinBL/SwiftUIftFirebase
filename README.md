# SwiftUIftFirebase
## _Aplicación inicial en SwiftUI con Firebase_

## Configurando Firebase en nuestra aplicación utilizando SPM
- Iniciamos agregando el package de 'Github Firebase SDK' utilizando SPM (Swift Package Manager) y seleccionamos las dependencias a utilizar.
- Agregamos el archivo descargado de Firebase al proyecto de nuestras aplicación, para inicializar Firebase.
- Inicializamos Firebase en el archivo 'main' de la aplicación creando la clase 'AppDelegate' y luego, registrando la clase en la estructura del main.

## Autenticación con Firebase
`AuthenticationView`:
- Renombramos el archivo de la vista 'ContentView' por 'AuthenticationView' para tenerlo mas ordenado.
- Creamos un enum que nos ayudara a saber que acción se va a realizar, si se inicia sesión o se registrará.
- Utilizaremos este enum dentro de la struct de la View como una variable privada de tipo 'State'.
- Para visualizar las vistas de acuerdo a la acción, se mostrará como 'sheet'.
- Creamos la propiedad del ViewModel del tipo 'ObservedObject' porque es del tipo 'ObservableObject'.
- Pasamos esta propiedad a la vista 'RegisterEmailView'.

### Crear usuario
`AuthenticationFireBaseDataSource`:
- Importamos 'FirebaseAuth' qué se utilizará para crear la nueva cuenta del Usuario e iniciar sesión.
- Creamos una struct 'User' para que reciba el email que se ha creado.
- Hacemos el `método para crear un nuevo usuario`, recibe como parámetro el correo, contraseña y completionBlock, este ultimo notificara a las capas superior (repositorio, viewmodel y vista) si ha habido un error o no al crear el nuevo usuario.
- Utilizamos el 'Auth.auth().createUser' que recibe como parámetro el usuario y contraseña, el completionBlock será el resultado que entregara el 'Auth', si se creó correctamente o no.
-- Si se creó correctamente, para obtener el email ingresado usamos la variable de confirmación, en este caso 'authDataResult' de la siguiente manera: 'authDataResult?.user.email'
-- Si hubo un error al crear el nuevo usuario, utilizamos la variable de error de la siguiente manera: 'error.localizedDescription' para obtener información del motivo del fallo.
-- Finalmente pasamos el resultado al 'completionBlock' pero; cuando se creó correctamente se tiene que inicializar la Struct User para pasar el email creado 'completionBlock(.success(.init(email: email)))', cuando hubo un error se pone directo el parámetro del error 'completionBlock(.failure(error))'.

`AuthenticationRepository`:
- Creamos una propiedad e instanciamos el DataSource.
- Creamos un método que utilizar el método de crear usuario del DataSource.

`AuthenticationViewModel`:
- Agregamos a la clase el 'ObservableObject' porque tendremos variables públicas.
- Creamos dos variables públicas opcionales, el del Usuario para saber si se ha registrado o autenticado correctamente y la de error para obtener alguna información si hubo algún inconveniente.
- Creamos una propiedad e instanciamos el Repository, en la instancia igualamos directamente el Repository para no hacerlo cuando utilicemos el ViewModel.
- Creamos un método que utilizar el método de crear usuario del Repository.
- En esta parte es donde se obtendrá si el 'completionBlock' a sido correcto o no y lo pasamos a las variables públicas.

`RegisterEmailView`:
- Creamos la propiedad del ViewModel del tipo 'ObservedObject' porque es del tipo 'ObservableObject'.
- En el botón de 'Aceptar' utilizaremos el método de crear usuario hecho en el 'ViewModel'.
- Sí hubo un error utilizamos la variable pública opcional del ViewModel para mostrarlo como texto en la vista.

### Sesión activa
- `AuthenticationFireBaseDataSource`: Creamos un método que devuelve el correo de la sesión activa del usuario de manera opcional utilizando el 'Auth.auth().currentUser?.email' y al retornar hacemos la inicialización de la struct User pasando el email activo.
- `AuthenticationRepository`: creamos el método que utilizará el método del DataSource que devuelve el correo de la sesión activa del usuario.
- `AuthenticationViewModel`: creamos el método que utilizará el método del Repository que devuelve el correo de la sesión activa del usuario y lo pasamos a la variable pública del usuario.
-- Lo llamamos dentro del init, para que muestre la vista correcta si hay sesión activa.
