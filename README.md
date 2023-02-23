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
- En el archivo 'main', agregamos la propiedad del ViewModel y hacemos una verificación para saber que vista mostrar.
-- Si encuentra una sesión activa mostrará la vista de HomeView.

### Cerrar Sesión
- `AuthenticationFireBaseDataSource`: Creamos un método cierra la sesión activa utilizando 'Auth.auth().signOut()' o devuelve un error si no lo realizó.
- `AuthenticationRepository`: creamos el método que utilizará el método del DataSource para cerrar la sesión.
- `AuthenticationViewModel`: creamos el método que utilizará el método del Repository para cerrar la sesión.
-- Hacemos la llamada dentro de un 'do-catch' por si el método del Repository obtuvo un error.
- `HomeView`: llamamos al método al momento de hacer clic en un botón.
- En el archivo 'main', indicamos en la verificación que si no encuentra un usuario logueado, muestre la vista inicial AuthenticationView.

### Iniciar Sesión
- `AuthenticationFireBaseDataSource`: creamos un método para iniciar sesión y tiene la misma estructura del crear usuario, solo cambia en el Auth, ahora se utiliza el signIn en vez del createUser: 'Auth.auth().signIn'.
- El `AuthenticationRepository` y `AuthenticationViewModel` su método de iniciar sesión es el mismo que el crear usuario.
- `LoginEmailView`: llamamos al método del ViewModel para iniciar sesión al hacer clic en el botón.
- `AuthenticationView`: pasamos la propiedad del ViewModel al LoginEmailView para que lo utilice.

## Autenticación utilizando proveedor de Facebook-Meta

### Configurando Facebook-Meta
- Seleccionamos el archivo raiz del proyecto, luego clic en el nombre del proyecto del Targets y por último en info.
- Agregamos en 'Custom iOS Target Properties' una nueva key llamada 'NSAppTransportSecurity' y enter para mostrar el archivo 'Info.plist'
- Seleccionamos el Info.plist y agregamos una key dentro de 'App Transport Security Settings' con el nombre de 'Allow Arbitrary Loads' con valor 'Yes' para dar permisos a realizar peticiones HTTP y HTTPs.
- Abrimos el Info.plist en formato código y pegamos el código dado por Facebook-Meta, actualizamos algunos datos de acuerdo a lo indicado en su portal y comprobamos si funciona.
- En el archivo `main` del proyecto, configuramos Facebook en el AppDelegate, como lo hicimos con Firebase, como ya se hizo el AppDelegate solo agregamos la linea de Facebook.

### Iniciar Sesión con Facebook
- `FacebookAuthentication`: se creó esta clase para que tenga su método independiente de iniciar sesión con Facebook y obtener su token.
- `AuthenticationFireBaseDataSource`: utilizamos el método de iniciar sesión con facebook para obtener el token.
-- Si devuelve el token, entonces lo utilizamos para obtener las credenciales de Facebook y lo pasamos a Firebase para que lo registre.
- `AuthenticationRepository`: creamos un método para utilizar el método de iniciar sesión con Facebook del DataSource.
- `AuthenticationViewModel`: este método es igual al iniciar sesión con Firebase.
- `AuthenticationView`: agregamos un nuevo botón para iniciar sesión con Facebook utilizando el método creado en el ViewModel.

## Vincular Cuenta con distintos proveedores

### Verificaar las cuentas vinculadas
- `AuthenticationFireBaseDataSource`: creamos un método para obtener los proveedores vinculados al email utilizando el 'currentUser' de Firebase y transformamos los IDs a un método del dominio.
- `AuthenticationRepository`: creamos un método para utilizar el método de obtener los proveedores.
- `AuthenticationViewModel`: aqui creamos 3 métodos:
-- El primero para utilizar el método de obtener los proveedores vinculados y lo almacenamos en una variable global.
-- El segundo y tercero hacen lo mismo, verifica que cuenta o cuentas están vinculadas para inhabilitar los botones.
- `ProfileView`: utilizamos los 3 nuevos método creado en el ViewModel:
-- El método para obtener las cuentas vinculadas lo llamamos dentro de un 'Task' en el bloque de la vista principal, en este caso es un Form.
-- Los otros 2 método casa uno se utiliza en los botones que corresponde dentro de un 'Disable' para saber si serán inhabilitados o no.

### Vincular Cuenta del Proveedor Facebook
- `AuthenticationFireBaseDataSource`: creamos un método para obtener el link del currentUser, la lógica es parecido al de iniciar sesión solo que en vez de usar 'signIn' utilizamos el 'currentUser?.link', por lo demás es igual.
- `AuthenticationRepository`: creamos un método para utilizar el método de vincular cuenta de Facebook.
- `AuthenticationViewModel`: creamos un método para utilizar el método de vincular cuenta de Facebook del Repository y actualizar los valores de las variables globales para visualizar los cambios en la vista.
- `ProfileView`: utilizamos el método de vincular Facebook en el botón y las variables globales para mostrar una alerta.