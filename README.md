# SwiftUIftFirebase
## _Aplicación inicial en SwiftUI con Firebase_

## Configurando Firebase en nuestra aplicación utilizando SPM
- Iniciamos agregando el package de 'Github Firebase SDK' utilizando SPM (Swift Package Manager) y seleccionamos las dependencias a utilizar.
- Agregamos el archivo descargado de Firebase al proyecto de nuestras aplicación, para inicializar Firebase.
- Inicializamos Firebase en el archivo 'main' de la aplicación creando la clase 'AppDelegate' y luego, registrando la clase en la estructura del main.

## PUSH NOTIFICATION
Para que se pueda probar estas notificaciones se debe de tener creada una cuenta de desarrollador en el portal de Apple.

### Configurando XCode para que reciba Notificaciones
- Archivo raíz > Targets > Info: dentro de 'Custom iOS Target Properties' agregamos la Key 'FirebaseAppDelegateProxyEnabled' de tipo Boleano y valor False.
- Archivo raíz > Targets > Signing & Capabilities: agregamos una nueva Capability de tipo 'Push Notifications'.
- En el archivo 'main', agregamos un nuevo protocolo a la clase 'AppDelegate', el protocolo es 'UNUserNotificationCenterDelegate'.
-- Dentro de la clase 'AppDelegate' agregamos métodos que interactúan con las notificaciones.
-- El primer método es para recibir notificaciones cuando la aplicación esta en primer plano: `func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)`. 
-- El segundo es para confirmar que recibió la notificación: `func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void)`. 
-- El tercero es para pedir permiso para recibir notificaciones: `private func requestAuthorizationForPushNotification(application: UIApplication)`. 
-- El cuarto es para recuperar el token de la APNs y asignarlo al token de FCM, para que Firebase sepa a que dispositivo enviar las notificaciones: `func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)`. 
