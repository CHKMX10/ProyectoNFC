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

# Usuario.

Página Inicial.

La aplicación cuenta con una pagina inicial solo como un detalle estetico y un poco de introducción a la aplicación, la cual no cuenta con una funcion relacionada con la funcionalidad NFC. 

Al dar touch o click en el botón “Entrar”, se dirigira a la pagina de bienvenida de la aplicación.

<img width="265" height="553" alt="imagen" src="https://github.com/user-attachments/assets/2b849a7d-b9e4-425e-a843-e225c2e49310" />

Ilustración 9. Página inicial.


# Página de bienvenida.

La página de bienvenida cuenta con dos opciones principales y visibles: el botón “Buscar Tarjeta” dirige a la página de escaneo para escanear la tarjeta NFC y un menú oculto, al cual se accede tocando o haciendo clic en el botón ubicado en la esquina superior izquierda de la página.

<img width="304" height="640" alt="imagen" src="https://github.com/user-attachments/assets/a024f99a-f305-493c-87f9-f5d5b33b2b8a" />

Ilustración 10. Página de bienvenida.	

<img width="304" height="640" alt="imagen" src="https://github.com/user-attachments/assets/5847571f-bc38-46d1-8c9e-4e0a7be61216" />

Ilustración 11. Menú oculto de la página de bienvenida.	 

<img width="304" height="640" alt="imagen" src="https://github.com/user-attachments/assets/188c3a94-8f0e-46ba-a6f8-cd08f361b36e" />

Ilustración 12. Cambio de tema de la aplicación.

Dentro del menú se encuentran dos opciones:

•	“Soy administrador”: Esta opción permite ingresar a la aplicación en modo administrador. Al seleccionarla, el usuario será dirigido a la página de inicio de sesión.

•	“Modo Claro/Oscuro”: Esta opción cambia el tema de la aplicación, siendo un detalle meramente estético que modifica el color de la interfaz sin depender del tema configurado en el dispositivo móvil.

# Página de escaneo.

La página de escaneo cuenta con una imagen de referencia para apoyar al usuario con la funcionalidad. Incluye un botón para escanear la tarjeta NFC, y dependiendo del caso, se informará al usuario con un mensaje si el teléfono tiene la tecnología NFC. En caso de que el teléfono cuente con dicha tecnología y se reconozca la tarjeta, se redirigirá al usuario a la página del menú para las acciones NFC.

<img width="304" height="640" alt="imagen" src="https://github.com/user-attachments/assets/614577a8-0961-4337-80d2-0fa32304a073" />

Ilustración 13. Página de escaneo previa a la acción	

<img width="304" height="640" alt="imagen" src="https://github.com/user-attachments/assets/606a7dc6-0736-4019-8a76-b76305ad862b" />

Ilustración 14. Página de escaneo durante la acción

# Página de menú de opciones.

La página de menú cuenta con cuatro botones, que son:

1.	Añadir información: Permite escribir información en la tarjeta. Se ha agregado una ventanilla flotante para formatear la tarjeta antes de grabar los datos para evitar problemas con la tarjeta NFC.
   
2.	Modificar tarjeta: Permite modificar los datos introducidos en una tarjeta ya grabada con la aplicación.
   
3.	Visualizar información: Botón que lleva a la página para visualizar la información de la tarjeta.
   
4.	Formatear: Permite formatear una tarjeta NFC que previamente haya sido grabada con la aplicación.
   
Adicionalmente, se incluye una ventanilla de apoyo en cada botón para auxiliar al usuario con el uso de la aplicación.

<img width="304" height="640" alt="imagen" src="https://github.com/user-attachments/assets/98128de7-68c3-45fc-8a84-e44725ac3949" />

Ilustración 15. Página de Menú de opciones	 

<img width="304" height="640" alt="imagen" src="https://github.com/user-attachments/assets/a320808c-d167-4ab0-ab9c-34303bc14f7d" />

Ilustración 16. Ventanilla de apoyo para el uso de los botones para el usuario


# Página de registro para la tarjeta NFC.

Antes de acceder a la página de registro, aparecerá una ventana emergente que solicitará al usuario formatear su tarjeta NFC, en caso de que haya omitido este paso previamente.

<img width="304" height="640" alt="imagen" src="https://github.com/user-attachments/assets/0fc7e6fe-8168-484c-8e28-db88009c5041" />

Ilustración 17. Ventanilla de formateo previa a la grabación de la tarjeta

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

<img width="304" height="640" alt="imagen" src="https://github.com/user-attachments/assets/6ba569e7-c142-4c9e-a9e4-2dc9156ab671" />

Ilustración 18. Página de registro de datos del usuario	 

<img width="304" height="640" alt="imagen" src="https://github.com/user-attachments/assets/3ec98a6e-b77c-4612-86b3-5df2932cbbcf" />

Ilustración 19. Página de registro durante la acción

# Página de modificación de la tarjeta NFC.

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

<img width="304" height="640" alt="imagen" src="https://github.com/user-attachments/assets/d87ffeb5-3265-4601-9b31-5d04e5c4d684" />

Ilustración 20. Página de Menú durante la acción previa a la página de modificación.	 

<img width="304" height="640" alt="imagen" src="https://github.com/user-attachments/assets/a7d361b9-0a41-4e07-9fd1-667a3b3da27f" />

Ilustración 21. Página de modificación.

<img width="304" height="640" alt="imagen" src="https://github.com/user-attachments/assets/40834464-11b6-4198-998b-e5aa5d68b230" />

Ilustración 22. Página de modificación durante la acción de grabar.


# Página de visualización de datos de la tarjeta NFC.

La página de Visualización está diseñada para permitir al usuario verificar los datos almacenados en la tarjeta NFC de forma clara y priorizando la información médicamente relevante.

La página incluye un botón ubicado en la parte superior derecha de la pantalla para realizar la búsqueda de datos desde la tarjeta NFC.

Una vez que el usuario presiona el botón, el usuario tiene 15 segundos para realizar la lectura de la tarjeta.
Casos de uso:

•	Tarjeta detectada correctamente: Los datos almacenados se cargan y se muestran en pantalla para revisión.
•	Tarjeta no detectada o error en la lectura: Se notifica al usuario con un mensaje en la parte inferior de la pantalla, permitiendo intentar nuevamente la lectura.

<img width="304" height="640" alt="imagen" src="https://github.com/user-attachments/assets/e9296ec9-7871-45fa-85fc-01b33484ca97" />

Ilustración 23. Página de visualización durante la búsqueda.	 

<img width="304" height="640" alt="imagen" src="https://github.com/user-attachments/assets/3e4b4f3b-8fa4-45bd-b4ea-f2c9d6f798be" />

Ilustración 24. Página de visualización con los datos recuperados de la tarjeta.

Importante:
•	Al momento de realizar la búsqueda o presionar el botón, el usuario tendrá 15 segundos para acercar la tarjeta NFC a la parte posterior del dispositivo, intente no mover o quitar la tarjeta para asegurar el éxito de la operación.
Opción de formateo de tarjeta NFC.
Al pulsar el botón de Formateo, se abrirá una ventanilla de confirmación para iniciar el formateo  de la tarjeta.
Confirmación de Formateo:
•	Eliminar: Se inicia el formateo, una vez completada la acción, se notifica al usuario con un mensaje en la parte inferior
•	Cancelar: Se cierra la ventana sin realizar cambios.

<img width="304" height="640" alt="imagen" src="https://github.com/user-attachments/assets/e86dda11-31c2-45f3-bb4c-3bc700912b17" />
 
Ilustración 25. Ventanilla de confirmación de formateo.	 

<img width="304" height="640" alt="imagen" src="https://github.com/user-attachments/assets/f3fff127-a638-4c8c-ba13-60fd53da5a96" />

Ilustración 26. Caso de éxito del formateo.

Importante:

•	Al momento de realizar la acción de “Eliminar”, el usuario tendrá 15 segundos para acercar la tarjeta NFC a la parte posterior del dispositivo, intente no mover o quitar la tarjeta para asegurar el éxito de la operación.
Administrador.

# Página Inicial.
La aplicación cuenta con una página inicial que funciona únicamente como un detalle estético y una breve introducción a la aplicación, sin incluir ninguna función relacionada con la funcionalidad NFC.
Al dar touch o clic en el botón “Entrar”, el usuario será dirigido a la página de bienvenida de la aplicación.

<img width="304" height="640" alt="imagen" src="https://github.com/user-attachments/assets/62153a52-5913-41ed-a46c-1cfc5a714dc3" />

Ilustración 25. Página inicial.

# Página de bienvenida.
La página de bienvenida cuenta con dos opciones principales y visibles: el botón “Buscar Tarjeta” dirige a la página de escaneo para escanear la tarjeta NFC y un menú oculto, al cual se accede tocando o haciendo clic en el botón ubicado en la esquina superior izquierda de la página.

<img width="304" height="640" alt="imagen" src="https://github.com/user-attachments/assets/0799d356-181d-42ef-b454-7ff66e180a8b" />

Ilustración 26. Página de bienvenida.	 

<img width="304" height="640" alt="imagen" src="https://github.com/user-attachments/assets/b48fbe55-42c9-4e80-89b7-e1f4aa5d730b" />

Ilustración 27. Menú oculto de la página de bienvenida.	 

<img width="304" height="640" alt="imagen" src="https://github.com/user-attachments/assets/649efc5a-19cd-400e-a057-c3e0b9c1ad54" />

Ilustración 28. Cambio de tema de la aplicación.

Dentro del menú se encuentran dos opciones:
•	“Soy administrador”: Esta opción permite ingresar a la aplicación en modo administrador. Al seleccionarla, el usuario será dirigido a la página de inicio de sesión.
•	“Modo Claro/Oscuro”: Esta opción cambia el tema de la aplicación, siendo un detalle meramente estético que modifica el color de la interfaz sin depender del tema configurado en el dispositivo móvil.
Página de inicio de sesión.
Existen dos campos para completar:
•	En el campo “Email”, se debe ingresar un correo válido. Nota: la aplicación está diseñada para validar que el correo introducido incluya el carácter “@”, el nombre del dominio (por ejemplo, hotmail, gmail, etc.) y una terminación válida como “.net, .com, .edu”, entre otras.
•	En el campo “Contraseña”, se debe escribir la contraseña proporcionada por el autor. Esta debe tener un mínimo de cuatro caracteres y puede incluir letras, números o una combinación alfanumérica.
Si el inicio de sesión es exitoso, se redirigirá automáticamente a la página de bienvenida del administrador, acompañada de un mensaje en la parte inferior de la pantalla para notificar el acceso correcto. En caso contrario, el usuario permanecerá en la página de inicio de sesión.

<img width="304" height="640" alt="imagen" src="https://github.com/user-attachments/assets/f8cbc996-f480-4c63-a76b-6bd97d7594b7" />

Ilustración 29. Página de inicio de sesión

# Página de bienvenida.
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

 <img width="304" height="640" alt="imagen" src="https://github.com/user-attachments/assets/b1ca9473-6969-448b-ad2f-1199f5228151" />

Ilustración 30. Página de bienvenida administrador	 

<img width="304" height="640" alt="imagen" src="https://github.com/user-attachments/assets/87994e7f-19b8-4958-827b-3dd0df2e27ad" />

Ilustración 31. Opciones como administrador	 

<img width="304" height="640" alt="imagen" src="https://github.com/user-attachments/assets/359f281d-ca2f-46dd-a13f-612eef241421" />

Ilustración 32. Menú oculto de administrador

Página de visualización de datos del paciente.

En esta página se muestran los datos del paciente seleccionado para su inspección.
Esta página tiene un carácter únicamente informativo, por lo que no cuenta con opciones adicionales ni funcionalidades para editar o eliminar datos. Los datos del paciente se presentan de manera clara y organizada para facilitar su consulta, contando con un apartado para el caso de modificación de los datos del paciente por algún administrador.
En la parte superior izquierda de la pantalla se encuentra un botón que permite regresar a la página principal del administrador, donde se listan todos los pacientes.

<img width="304" height="640" alt="imagen" src="https://github.com/user-attachments/assets/ae17df08-d02b-46b2-8a20-7e7bcde72383" />

Ilustración 33. Página de visualización de datos.	 

<img width="304" height="640" alt="imagen" src="https://github.com/user-attachments/assets/29b9fd62-9e88-4cb2-b590-80224234743f" />

Ilustración 34. Página de visualización de datos parte 2.

Nota: los datos mostrados se han censurado debido a que son datos reales de una persona.

# Página de modificación de paciente.

En esta página se muestran los datos del paciente seleccionado para su modificación.
Si solo se desea actualizar un campo, basta con modificar ese campo específico; los demás permanecerán intactos. Esto permite realizar cambios puntuales sin alterar el resto de la información.

<img width="304" height="640" alt="imagen" src="https://github.com/user-attachments/assets/2866a862-486f-4c2c-b190-444be647120b" />

Ilustración 35. Página de modificación de paciente	 

<img width="304" height="640" alt="imagen" src="https://github.com/user-attachments/assets/e5c009ca-0da6-4e61-bbfc-f58c265c2e8e" />

Ilustración 36. Caso de paciente correctamente actualizado

Una vez que se hayan revisado y confirmado los cambios, el administrador deberá hacer clic o tocar el botón “Actualizar”, ubicado en la parte inferior de la página, para guardar las modificaciones realizadas, esto acompañado por un mensaje en la parte inferior y direcciona a la página de bienvenida del administrador.

# Opción de eliminación de paciente.

Esta no es una página como las demás, sino una ventanita que aparece cuando se quiere eliminar un paciente, para evitar errores.

Si alguien se equivocó al tocar el botón de borrar, no pasa nada. Solo tiene que tocar el botón “Cancelar” para volver atrás y no borrar nada.

Pero, si de verdad quiere borrar al paciente, tiene que tocar el botón “Eliminar”. Al hacerlo, el paciente será eliminado completamente de la lista y se cerrará la ventanilla.

<img width="304" height="640" alt="imagen" src="https://github.com/user-attachments/assets/52bd2d00-a30b-4e9f-b651-0af17854858b" />

Ilustración 37. Ventanilla para eliminar paciente.	 

<img width="304" height="640" alt="imagen" src="https://github.com/user-attachments/assets/05bf6b5b-46c2-4fe2-9559-e804aa3d6e58" />

Ilustración 38. Caso de paciente correctamente eliminado.

# Cierre de sesión.

Para cerrar la sesión y volver a la página de bienvenida del usuario, primero debes abrir el menú oculto. Dentro del menú encontrarás la opción “Cerrar sesión”. Al tocar o hacer clic en esta opción, se cerrará la sesión actual y serás redirigido automáticamente a la página de bienvenida como usuario.

<img width="304" height="640" alt="imagen" src="https://github.com/user-attachments/assets/4f0da7c5-707d-418f-8a6c-c6f839fc9f20" />

Ilustración 36. Menú oculto del administrador.	 

<img width="304" height="640" alt="imagen" src="https://github.com/user-attachments/assets/6a9ce514-d285-4859-9e56-dcf1f14be6db" />

Ilustración 36. Cierre de sesión

Problemas comunes con NFC.

Para hacer un correcto y completo uso de la aplicación, se debe corroborar de que el dispositivo móvil sea compatible con la tecnología NFC.
Para cada acción con NFC se debe presionar el botón y esperar a que este cambie de forma, en cualquier caso, de las opciones con botones con funcionalidad NFC, por ejemplo; la mayoría de botones después de la página de escaneo; 

<img width="304" height="640" alt="imagen" src="https://github.com/user-attachments/assets/d515ac7c-51d0-4846-97ac-223ec2d2929c" />

Ilustración 37. Página de escaneo previa a la acción	 

<img width="304" height="640" alt="imagen" src="https://github.com/user-attachments/assets/4b48d6b7-a8ab-4749-a0f0-e9aa71e52b7f" />

Ilustración 38. Página de escaneo durante la acción

Una vez pulsado el botón y que haya cambiado de forma, se debe colocar la tarjeta NFC detrás del dispositivo móvil a no más de 4 centímetros, entre más cerca mejor, el dispositivo hará la acción correspondiente acompañada de una vibración para avisar al usuario sobre la interacción.

En caso de que la aplicación no realice alguna acción con NFC se recomienda que la tarjeta o tag NFC sea escrito y formateado con otra aplicación la cual es gratuita en Play Store; NFC Tools. 
•	Play Store: https://play.google.com/store/apps/details?id=com.wakdev.wdnfc&hl=es_MX&pli=1
Ejemplo de como realizar la preparación: https://www.youtube.com/shorts/yuEpI175C30 
