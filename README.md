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

## Detectar CRASH o BUGS
### Fichero dSYM
- Los 'dSYM' nos proporcionan información muy fácil de leer y entender, sin este fichero no podríamos saber en dónde esta ocurriendo el Crash o Bugs.
- Este fichero se debe de proporcionar a CrashLytics cada vez que compilamos o realizamos una nueva versión de la aplicación.

### Configurando XCode para que genere el dSYM
- Archivo raíz > Targets > Build Settings > All: dentro de 'Debug Information Format' debemos de actualizar el 'Debug' para que también haga el 'dSYM'.
- Archivo raíz > Targets > Build Phases: agregamos un nuevo 'New Run Script Phase'.
-- Renombramos el Script a 'Crashlytics', expandimos y debajo del Shell agregamos el siguiente código:  ```
${BUILD_DIR%Build/*}SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/run -gsp ${PROJECT_DIR}/[ruta_de_la_direccion]/GoogleService-Info.plist; ``` ; esto es significa que al comando de Crashlytics le pasamos la ruta del '.plist'.
-- En los Input Files agregamos lo siguiente: ```
${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}/Contents/Resources/DWARF/${TARGET_NAME} ``` y ``` $(SRCROOT)/${BUILD_PRODUCTS_DIR}/$(INFOPLIST_PATH) ```

