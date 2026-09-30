# ProyectoNFC
Desarrollé una app móvil en Flutter/Dart que lee y escribe datos clínicos esenciales en tarjetas NFC, para acelerar la atención en emergencias.
Instalación
Requisitos del sistema.
•	Sistema Operativo.
•	Mínimo: Android 8.0 (API 26) o superior con tecnología NFC.
•	Óptimo: Android 14 (API 34) o superior con tecnología NFC.
•	Procesador.
•	Mínimo: Procesador de cuatro núcleos (Quad-core) a 1.5 GHz o superior.
•	Óptimo: Procesador de ocho núcleos (Octa-core) a 2.0 GHz o superior.
•	Almacenamiento.
•	La aplicación necesita un mínimo de 400 MB para poder ser instalada.
•	Permisos y Configuraciones.
•	En algunos dispositivos, se tendrá que aceptar el uso de NFC.
Instrucciones de instalación
Previo a la descarga del apk, es recomendable primero dar la autorización para la instalación del apk en el dispositivo, en mi caso, en Configuración – Protección de privacidad – Permisos especiales – Instalar aplicaciones desconocidas, como se esta descargando desde Drive, se le debe dar el permiso para que se pueda ejecutar el apk.
 
Ilustración 1. Configuracion para APK 1	 
Ilustración 2. Configuracion para APK 1
 
Ilustración 3. Configuracion para APK 3	 
Ilustración 4. Configuracion para APK 4
Una vez permitida la instalación de APK, se debe ingresar al siguiente enlace: https://drive.google.com/file/d/1HAWl0t5rgWZMIjY_9SaB_5sI-o_MZfgz/view?usp=sharing y descargar el APK. Una vez completada la descarga, se debe ejecutar el APK para continuar con la instalación y se abrirá automáticamente la aplicación.
 
Ilustración 5. Instalación APK 1	
 
Ilustración 6. Instalación APK 2
 
Ilustración 7. Instalación APK 3	 
Ilustración 8. Instalación APK 4
	
Usuario.
Página Inicial.
La aplicación cuenta con una pagina inicial solo como un detalle estetico y un poco de introducción a la aplicación, la cual no cuenta con una funcion relacionada con la funcionalidad NFC. 
Al dar touch o click en el botón “Entrar”, se dirigira a la pagina de bienvenida de la aplicación.
 
Ilustración 9. Página inicial.
Página de bienvenida.
La página de bienvenida cuenta con dos opciones principales y visibles: el botón “Buscar Tarjeta” dirige a la página de escaneo para escanear la tarjeta NFC y un menú oculto, al cual se accede tocando o haciendo clic en el botón ubicado en la esquina superior izquierda de la página.
 
Ilustración 10. Página de bienvenida.	 
Ilustración 11. Menú oculto de la página de bienvenida.	 
Ilustración 12. Cambio de tema de la aplicación.

Dentro del menú se encuentran dos opciones:
•	“Soy administrador”: Esta opción permite ingresar a la aplicación en modo administrador. Al seleccionarla, el usuario será dirigido a la página de inicio de sesión.
•	“Modo Claro/Oscuro”: Esta opción cambia el tema de la aplicación, siendo un detalle meramente estético que modifica el color de la interfaz sin depender del tema configurado en el dispositivo móvil.
Página de escaneo.
La página de escaneo cuenta con una imagen de referencia para apoyar al usuario con la funcionalidad. Incluye un botón para escanear la tarjeta NFC, y dependiendo del caso, se informará al usuario con un mensaje si el teléfono tiene la tecnología NFC. En caso de que el teléfono cuente con dicha tecnología y se reconozca la tarjeta, se redirigirá al usuario a la página del menú para las acciones NFC.
 
Ilustración 13. Página de escaneo previa a la acción	 
Ilustración 14. Página de escaneo durante la acción
Página de menú de opciones.
La página de menú cuenta con cuatro botones, que son:
1.	Añadir información: Permite escribir información en la tarjeta. Se ha agregado una ventanilla flotante para formatear la tarjeta antes de grabar los datos para evitar problemas con la tarjeta NFC.
2.	Modificar tarjeta: Permite modificar los datos introducidos en una tarjeta ya grabada con la aplicación.
3.	Visualizar información: Botón que lleva a la página para visualizar la información de la tarjeta.
4.	Formatear: Permite formatear una tarjeta NFC que previamente haya sido grabada con la aplicación.
Adicionalmente, se incluye una ventanilla de apoyo en cada botón para auxiliar al usuario con el uso de la aplicación.
 
Ilustración 15. Página de Menú de opciones	 
Ilustración 16. Ventanilla de apoyo para el uso de los botones para el usuario
Página de registro para la tarjeta NFC.
Antes de acceder a la página de registro, aparecerá una ventana emergente que solicitará al usuario formatear su tarjeta NFC, en caso de que haya omitido este paso previamente.
 
Ilustración 15. Ventanilla de formateo previa a la grabación de la tarjeta
La página de registro consiste en un formulario en el cual el usuario debe completar su información personal en los campos correspondientes. Esto asegura que los datos sean registrados de forma correcta y completa.
Formulario de Datos
•	El usuario llena las casillas del formulario con su información personal.
•	La información será cifrada y grabada en la tarjeta NFC al finalizar el proceso.
Selección de Opción al Finalizar
Al final del formulario, el usuario debe seleccionar una de las dos opciones:
"Ya lo he hecho":
•	Graba la información en la tarjeta NFC, evitando duplicados en la base de datos.
•	Es ideal para usuarios que ya han registrado su información previamente y solo desean obtener una nueva tarjeta NFC (por extravío o necesidad de duplicado).
"No, es mi primera vez":
•	Registra la información del usuario en la base de datos y graba la tarjeta NFC.
•	Es utilizada para nuevos registros, asegurando que los datos queden almacenados tanto en la tarjeta NFC como en la base de datos para futuros controles.
Importante:
•	En ambos casos, el proceso de grabación asegura que la tarjeta NFC quede grabada y cifrada correctamente.
•	Si el usuario pierde su tarjeta, podrá volver a registrar otra tarjeta.
•	Una vez terminado el proceso de rellenar las casillas de la información del usuario, al momento de realizar la grabación en la tarjeta, tendrá 15 segundos para acercar la tarjeta NFC a la parte posterior del dispositivo, intente no mover o quitar la tarjeta para asegurar el éxito de la operación.
 
Ilustración 17. Página de registro de datos del usuario	 
Ilustración 18. Página de registro durante la acción
Página de modificación de la tarjeta NFC.
La Página de Modificación permite editar la información almacenada en la tarjeta NFC.
Funcionamiento:
•	Verificación de la Tarjeta NFC: Al acceder, el sistema verifica si la tarjeta NFC contiene información registrada.
•	Escenarios posibles:
•	Tarjeta con información: El usuario será redirigido a la página donde podrá realizar las modificaciones necesarias.
•	Tarjeta sin información: El usuario permanecerá en la pantalla actual.
Una vez que el usuario accede a la página de modificación (con una tarjeta válida), se muestran los campos actuales con la información dentro de la tarjeta NFC.
El usuario edita los campos necesarios y graba nuevamente la tarjeta NFC con la nueva información.
Nota Importante:
•	La información almacenada en la base de datos únicamente puede ser modificada por un administrador.
•	Una vez terminado el proceso de modificación, al momento de realizar la grabación en la tarjeta, tendrá 15 segundos para acercar la tarjeta NFC a la parte posterior del dispositivo, intente no mover o quitar la tarjeta para asegurar el éxito de la operación.
 
Ilustración 19. Página de Menú durante la acción previa a la página de modificación.	 
Ilustración 20. Página de modificación.
 
Ilustración 21. Página de modificación durante la acción de grabar.
Página de visualización de datos de la tarjeta NFC.
La página de Visualización está diseñada para permitir al usuario verificar los datos almacenados en la tarjeta NFC de forma clara y priorizando la información médicamente relevante.
La página incluye un botón ubicado en la parte superior derecha de la pantalla para realizar la búsqueda de datos desde la tarjeta NFC.
Una vez que el usuario presiona el botón, el usuario tiene 15 segundos para realizar la lectura de la tarjeta.
Casos de uso:
•	Tarjeta detectada correctamente: Los datos almacenados se cargan y se muestran en pantalla para revisión.
•	Tarjeta no detectada o error en la lectura: Se notifica al usuario con un mensaje en la parte inferior de la pantalla, permitiendo intentar nuevamente la lectura.
 
Ilustración 22. Página de visualización durante la búsqueda.	 
Ilustración 23. Página de visualización con los datos recuperados de la tarjeta.
Importante:
•	Al momento de realizar la búsqueda o presionar el botón, el usuario tendrá 15 segundos para acercar la tarjeta NFC a la parte posterior del dispositivo, intente no mover o quitar la tarjeta para asegurar el éxito de la operación.
Opción de formateo de tarjeta NFC.
Al pulsar el botón de Formateo, se abrirá una ventanilla de confirmación para iniciar el formateo  de la tarjeta.
Confirmación de Formateo:
•	Eliminar: Se inicia el formateo, una vez completada la acción, se notifica al usuario con un mensaje en la parte inferior
•	Cancelar: Se cierra la ventana sin realizar cambios.

 
Ilustración 24. Ventanilla de confirmación de formateo.	 
Ilustración 25. Caso de éxito del formateo.
Importante:
•	Al momento de realizar la acción de “Eliminar”, el usuario tendrá 15 segundos para acercar la tarjeta NFC a la parte posterior del dispositivo, intente no mover o quitar la tarjeta para asegurar el éxito de la operación.
Administrador.
Página Inicial.
La aplicación cuenta con una página inicial que funciona únicamente como un detalle estético y una breve introducción a la aplicación, sin incluir ninguna función relacionada con la funcionalidad NFC.
Al dar touch o clic en el botón “Entrar”, el usuario será dirigido a la página de bienvenida de la aplicación.
 
Ilustración 9. Página inicial.
Página de bienvenida.
La página de bienvenida cuenta con dos opciones principales y visibles: el botón “Buscar Tarjeta” dirige a la página de escaneo para escanear la tarjeta NFC y un menú oculto, al cual se accede tocando o haciendo clic en el botón ubicado en la esquina superior izquierda de la página.
 
Ilustración 10. Página de bienvenida.	 
Ilustración 11. Menú oculto de la página de bienvenida.	 
Ilustración 12. Cambio de tema de la aplicación.

Dentro del menú se encuentran dos opciones:
•	“Soy administrador”: Esta opción permite ingresar a la aplicación en modo administrador. Al seleccionarla, el usuario será dirigido a la página de inicio de sesión.
•	“Modo Claro/Oscuro”: Esta opción cambia el tema de la aplicación, siendo un detalle meramente estético que modifica el color de la interfaz sin depender del tema configurado en el dispositivo móvil.
Página de inicio de sesión.
Existen dos campos para completar:
•	En el campo “Email”, se debe ingresar un correo válido. Nota: la aplicación está diseñada para validar que el correo introducido incluya el carácter “@”, el nombre del dominio (por ejemplo, hotmail, gmail, etc.) y una terminación válida como “.net, .com, .edu”, entre otras.
•	En el campo “Contraseña”, se debe escribir la contraseña proporcionada por el autor. Esta debe tener un mínimo de cuatro caracteres y puede incluir letras, números o una combinación alfanumérica.
Si el inicio de sesión es exitoso, se redirigirá automáticamente a la página de bienvenida del administrador, acompañada de un mensaje en la parte inferior de la pantalla para notificar el acceso correcto. En caso contrario, el usuario permanecerá en la página de inicio de sesión.
 
Ilustración 26. Página de inicio de sesión
Página de bienvenida.
En esta página, se mostrará una lista con todos los pacientes registrados en la aplicación. Esta lista incluye información esencial para la identificación de cada paciente, como:
•	Nombre del paciente.
•	Fecha de nacimiento.
•	Número de identificación o seguro.
Estos datos facilitan la identificación en caso de que existan pacientes con nombres o fechas de nacimiento coincidentes. Además, la página incluye un campo de búsqueda que permite localizar pacientes de manera eficiente ingresando su nombre.
Cada paciente contará con tres opciones visibles en la lista:
•	Visualizar datos del paciente:
Al tocar o hacer clic sobre el nombre del paciente, el administrador será dirigido a la página de visualización de datos, donde podrá consultar toda la información registrada del paciente.
•	Modificar datos del paciente:
Al tocar el ícono del lápiz, el administrador será dirigido a la página de modificación del paciente, donde podrá editar su información.
•	Eliminar paciente:
Al tocar el ícono del cubo de la basura, se abrirá una ventana de confirmación que permitirá al administrador eliminar al paciente seleccionado de la base de datos.
La página también cuenta con un menú oculto similar al de la página de bienvenida, pero con la opción adicional de cerrar sesión, lo que permite volver a la página de bienvenida inicial cerrrando la sesión como administrador.
 
Ilustración 27. Página de bienvenida administrador	 
Ilustración 28. Opciones como administrador	 
Ilustración 29. Menú oculto de administrador
Página de visualización de datos del paciente.
En esta página se muestran los datos del paciente seleccionado para su inspección.
Esta página tiene un carácter únicamente informativo, por lo que no cuenta con opciones adicionales ni funcionalidades para editar o eliminar datos. Los datos del paciente se presentan de manera clara y organizada para facilitar su consulta, contando con un apartado para el caso de modificación de los datos del paciente por algún administrador.
En la parte superior izquierda de la pantalla se encuentra un botón que permite regresar a la página principal del administrador, donde se listan todos los pacientes.
 
Ilustración 30. Página de visualización de datos.	 
Ilustración 31. Página de visualización de datos parte 2.
Nota: los datos mostrados se han censurado debido a que son datos reales de una persona.
Página de modificación de paciente.
En esta página se muestran los datos del paciente seleccionado para su modificación.
Si solo se desea actualizar un campo, basta con modificar ese campo específico; los demás permanecerán intactos. Esto permite realizar cambios puntuales sin alterar el resto de la información.
 
Ilustración 32. Página de modificación de paciente	 
Ilustración 33. Caso de paciente correctamente actualizado
Una vez que se hayan revisado y confirmado los cambios, el administrador deberá hacer clic o tocar el botón “Actualizar”, ubicado en la parte inferior de la página, para guardar las modificaciones realizadas, esto acompañado por un mensaje en la parte inferior y direcciona a la página de bienvenida del administrador.
Opción de eliminación de paciente.
Esta no es una página como las demás, sino una ventanita que aparece cuando se quiere eliminar un paciente, para evitar errores.
Si alguien se equivocó al tocar el botón de borrar, no pasa nada. Solo tiene que tocar el botón “Cancelar” para volver atrás y no borrar nada.
Pero, si de verdad quiere borrar al paciente, tiene que tocar el botón “Eliminar”. Al hacerlo, el paciente será eliminado completamente de la lista y se cerrará la ventanilla.
 
Ilustración 34. Ventanilla para eliminar paciente.	 
Ilustración 35. Caso de paciente correctamente eliminado.
Cierre de sesión.
Para cerrar la sesión y volver a la página de bienvenida del usuario, primero debes abrir el menú oculto. Dentro del menú encontrarás la opción “Cerrar sesión”. Al tocar o hacer clic en esta opción, se cerrará la sesión actual y serás redirigido automáticamente a la página de bienvenida como usuario.
 
Ilustración 36. Menú oculto del administrador.	 
Ilustración 36. Cierre de sesión
Problemas comunes con NFC.
Para hacer un correcto y completo uso de la aplicación, se debe corroborar de que el dispositivo móvil sea compatible con la tecnología NFC.
Para cada acción con NFC se debe presionar el botón y esperar a que este cambie de forma, en cualquier caso, de las opciones con botones con funcionalidad NFC, por ejemplo; la mayoría de botones después de la página de escaneo; 
 
Ilustración 13. Página de escaneo previa a la acción	 
Ilustración 14. Página de escaneo durante la acción
Una vez pulsado el botón y que haya cambiado de forma, se debe colocar la tarjeta NFC detrás del dispositivo móvil a no más de 4 centímetros, entre más cerca mejor, el dispositivo hará la acción correspondiente acompañada de una vibración para avisar al usuario sobre la interacción.
En caso de que la aplicación no realice alguna acción con NFC se recomienda que la tarjeta o tag NFC sea escrito y formateado con otra aplicación la cual es gratuita en Play Store; NFC Tools. 
•	Play Store: https://play.google.com/store/apps/details?id=com.wakdev.wdnfc&hl=es_MX&pli=1
Ejemplo de como realizar la preparación: https://www.youtube.com/shorts/yuEpI175C30 
