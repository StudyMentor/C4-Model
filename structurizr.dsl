workspace "TUTTORCONECT" "Description" {
    model {
    //personas
    alumno = person "Alumno" "una estudiante con una cuenta creada en el sistema"
    tutor = person "Tutor" "un tutor con una cuenta creada en el sistema"
    //sistemas externos
    bibliotecaupc = softwareSystem "Biblioteca UPC" "sistema de informacion academica de la UPC"
    teams = softwareSystem "Teams" "sistema de videoconferencias"
    outlook = softwareSystem "Outlook" "sistema de correo electronico institucional"
    pago = softwareSystem "Pasarela de pagos" "sistema de pagos"
    //sistema principal
    tuttorconect = softwareSystem "TUTTORCONECT" "aula virtual de tutorias" "Sistema"{
        //contenedores de tuttorconect
        //web
            singlePagAppTutor = container "Single-Page Application Tutor" "provee la funcionalidad a los usuarios tutores atraves de su navegador web" "JavaScript"
            singlePagAppStudent = container "Single-Page Application Student" "provee la funcionalidad a los usuarios estudiantes atraves de su navegador web" "JavaScript"
            spa = container "Web Application" "Entrega el contenido estático y la aplicación de página única reStyle" "Javascript and Node.js"{
                alumno -> this "visita sitio web" "[HTTPS]"
                tutor -> this "visita sitio web" "[HTTPS]"
            }
            apiApp = container "API Application" "Provee funcionalidad via un JSON/HTTPS API" "Javascript and Node.js "Api"
        
            gestionUsuario = container "GESTION DE USUARIO" "Sistema de administracion de datos de los Usuarios"{
               //funcionalidades principales
                iniciarsesion = component "Iniciar Sesion" "permitir a los usuarios registrados iniciar sesión en sus cuentas"
                registronuevos = component "Registro Nuevos Usuarios" "proporcionar un proceso de registro para permitir que los nuevos usuarios creen cuentas"
                cerrarsesion = component "Cerrar Sesion" "poder cerrar sesión de manera segura y efectiva en las cuentas"
                
                obtinfusuario = component "Obtener Información Usuario" "permite ver y acceder al propio perfil de usuario o al perfil de otros usuarios"
                editperfusuario = component "Editar Perfil Usuario" "permite modificar y actualizar la información del perfil"
                
                asignacionroles = component "Asignación de roles" "asignar un rol que determina los permisos y las funciones que pueden acceder"
            
                visuapanelcontrol = component "Visualización de panel de control" "proporciona a los usuarios una interfaz personalizada y específica según su rol en la plataforma"
                visuacalen = component "Visualización de calendario" "muestra un calendario que refleja las clases programadas y otras actividades relacionadas con la tutoría"
            }
            gestionTutoria = container "GESTION DE TUTORIA" "Sistema de administracion de las sesiones de tutorias"{
                //funcionalidades principales
                crearclase = component "Creacion de clase" "Los tutores podrán crear, programar o agendar una clase con los estudiantes que hayan contratado sus servicios"
                modificarclase = component "Modificar clase" "Los tutores podrán modificar las clases con sus estudiantes antes de la fecha establecida."
                regclase = component "Registro de duración de clases" "medir y documentar el tiempo empleado en las sesiones de tutoría"
            
               subclases = component "Suscripción a clases" "Permite a los estudiantes inscribirse en clases específicas ofrecidas por tutores"
            
                publicomen = component "Publicar comentarios" "permite a los estudiantes escribir comentarios y reseñas sobre las clases que han tomado con un tutor"
                editcomen = component "Editar comentario" " opción de editar los comentarios que han publicado anteriormente, permitiendo correcciones o actualizaciones"
                califtutor = component "Calificar tutor" "otorgar una calificación numérica, generalmente en forma de estrellas, que representa su satisfacción con la tutoría recibida"
              
                guardadoautomatico = component "Guardado automático de enlaces" "Cada sesión dada por un tutor se grabará y enviará al correo personal de cada estudiante"
                accesograbaciones = component "Acceso a grabaciones de clases pasadas" "acceder a las grabaciones almacenadas en la aplicación"
                generarenlace = component "Generación de enlace a la reunión" "En base a la fecha registrada de la sesión, se creará y compartirá un enlace a la reunión"
            
                porfecha = component "Búsqueda por fecha" "buscar sesiones de tutoría según las fechas en las que desean recibir las clases"
                portutor = component "Búsqueda por tutor" "buscar tutores específicos por nombre de perfil para encontrar a los profesores que desean contratar"
                portema = component "Búsqueda por tema" "buscar clases basadas en temas específicos, lo que les permite encontrar tutores que se especializan en áreas de estudio particulares"
                porpopularidad = component "Búsqueda por popularidad" "buscar clases de tutoría ordenadas por popularidad"
            
                subirarchivos = component "Subida de documentos y archivos" "cargar documentos y archivos relevantes, como materiales de clase"
                modifarchivos = component "Modificación de documentos y archivos" "editar y actualizar los documentos y archivos creados o cargados previamente"
                descarchivos = component "Descarga de materiales" "descargar los materiales educativos proporcionados por los tutores"
                visuarchivos = component "Visualización de documentos" "ver los documentos y archivos compartidos en la plataforma para acceder a los recursos educativos"
            }
            sistemaComunicaciones = container "SISTEMA DE COMUNICACIONES" "Sistema encargado del trafico de mensajes y notificaciones"{
                mandarmensaje = component "Mandar mensajes" "Los usuarios deben poder redactar y enviar mensajes escritos en formato de texto a otros usuario"
                recibirmensaje = component "Recibir mensajes" " recibir y mostrar mensajes entrantes en tiempo real"
                censurarmensajes = component "Censurar mensajes ofensivos" "mecanismo de censura que detecte y bloquee automáticamente mensajes que contengan lenguaje ofensivo o inapropiado"
            
                recibirnovedades = component "Recibir Novedades de Cursos Inscritos" "recibir notificaciones específicas relacionadas con los cursos en los que están inscritos"
            }
            
            
        
            //BASE DE DATOS
            facade = container "CONECTOR API" "javascript"
            basedatos = container "BASEDATOS" "description" "mysql port 8080" "Oracle"
            sistemarchivos = container "SISTEMA ARCHIVOS" "Linux"
    }
    //RELACIONES
        //relaciones de contexto
        alumno -> tuttorconect "busqueda de tutorias afines e inscribirse"
        tutor -> tuttorconect "publicacion de servicios de tutorias personalizadas"
        tuttorconect -> bibliotecaupc "obtiene informacion academica de la UPC"
        tuttorconect -> teams "acceso a las reuniones virtuales"
        tuttorconect -> outlook "obtiene informacion de usuario"
        tuttorconect -> pago "servicio de procesamiento de pagos"
        
        //relaciones contenedor tuttorconect
        alumno -> singlePagAppStudent "revisa y oculta las secciones de creacion de tutorias"
        tutor -> singlePagAppTutor "permite acceso a la creacion de tutorias"
        singlePagAppStudent -> spa "realiza llamadas API a" "JSON/HTTPS"
        singlePagAppTutor -> spa "realiza llamadas API a" "JSON/HTTPS"
        spa -> apiApp "realiza llamadas API a" "JSON/HTTPS"
        apiApp -> facade "realiza llamadas API a" "[HTTPS]"
        apiApp -> sistemarchivos "realiza llamadas API a" "JSON/HTTPS"
        
        facade -> bibliotecaupc "realiza llamadas API a" "[HTTPS]"
        facade -> teams "realiza llamadas API a" "[HTTPS]"
        facade -> outlook "realiza llamadas API a" "[HTTPS]"
        facade -> pago "realiza llamadas API a" "[HTTPS]"
        
        apiApp -> gestionTutoria "realiza llamadas API a" "[HTTPS]"
        apiApp -> gestionUsuario "realiza llamadas API a" "[HTTPS]"
        apiApp -> sistemaComunicaciones "realiza llamadas API a" "[HTTPS]"
        
        gestionUsuario -> basedatos "lee y escribe" "SQL"
        gestionTutoria -> basedatos "lee y escribe" "SQL"
        sistemaComunicaciones -> basedatos "lee y escribe" "SQL"
        sistemarchivos -> basedatos "lee y escribe" "SQL"
        
        //relaciones componente SesionTutoria
        apiApp -> crearclase "realiza llamadas API a" "[HTTPS]"
        apiApp -> modificarclase "realiza llamadas API a" "[HTTPS]"
        apiApp -> regclase "realiza llamadas API a" "[HTTPS]"

        //relaciones componente autenticacion
        apiApp -> iniciarsesion "realiza llamadas API a" "[HTTPS]"
        apiApp -> registronuevos "realiza llamadas API a" "[HTTPS]"
        apiApp -> cerrarsesion "realiza llamadas API a" "[HTTPS]"
        
        //relaciones componente usuarios
        apiApp -> obtinfusuario "realiza llamadas API a" "[HTTPS]"
        apiApp -> editperfusuario "realiza llamadas API a" "[HTTPS]"
        
        //relaciones componente dashboard
        apiApp -> visuapanelcontrol "realiza llamadas API a" "[HTTPS]"
        apiApp -> visuacalen "realiza llamadas API a" "[HTTPS]"
        
        
        //relaciones componente emparejamiento
        apiApp -> subclases "realiza llamadas API a" "[HTTPS]"
        
        //relaciones componente chat
        apiApp -> mandarmensaje "realiza llamadas API a" "[HTTPS]"
        apiApp -> recibirmensaje "realiza llamadas API a" "[HTTPS]"
        apiApp -> censurarmensajes "realiza llamadas API a" "[HTTPS]"
        
        //relaciones componente notificacion
        apiApp -> recibirnovedades "realiza llamadas API a" "[HTTPS]"
        
        //relaciones componente resena
        apiApp -> publicomen "realiza llamadas API a" "[HTTPS]"
        apiApp -> editcomen "realiza llamadas API a" "[HTTPS]"
        apiApp -> califtutor "realiza llamadas API a" "[HTTPS]"
        
        //relaciones componente archivos
        apiApp -> subirarchivos "realiza llamadas API a" "[HTTPS]"
        apiApp -> modifarchivos "realiza llamadas API a" "[HTTPS]"
        apiApp -> descarchivos "realiza llamadas API a" "[HTTPS]"
        apiApp -> visuarchivos "realiza llamadas API a" "[HTTPS]"
        
        //relaciones componente enlace
        apiApp -> guardadoautomatico "realiza llamadas API a" "[HTTPS]"
        apiApp -> accesograbaciones "realiza llamadas API a" "[HTTPS]"
        apiApp -> generarenlace "realiza llamadas API a" "[HTTPS]"
        
        //relaciones componente roles
        apiApp -> asignacionroles "realiza llamadas API a" "[HTTPS]"
        
        //relaciones componente busqueda
        apiApp -> porfecha "realiza llamadas API a" "[HTTPS]"
        apiApp -> portutor "realiza llamadas API a" "[HTTPS]"
        apiApp -> portema "realiza llamadas API a" "[HTTPS]"
        apiApp -> porpopularidad "realiza llamadas API a" "[HTTPS]"
        
        crearclase -> basedatos "lee y escribe" "SQL"
        modificarclase -> basedatos "lee y escribe" "SQL"
        regclase -> basedatos "lee y escribe" "SQL"
        iniciarsesion -> basedatos "lee y escribe" "SQL"
        registronuevos -> basedatos "lee y escribe" "SQL"
        //cerrarsesion -> basedatos "lee y escribe" "SQL"
        obtinfusuario -> basedatos "lee y escribe" "SQL"
        editperfusuario -> basedatos "lee y escribe" "SQL"
        visuapanelcontrol -> basedatos "lee y escribe" "SQL"
        visuacalen -> basedatos "lee y escribe" "SQL"
        subclases -> basedatos "lee y escribe" "SQL"
        mandarmensaje -> basedatos "lee y escribe" "SQL"
        recibirmensaje -> basedatos "lee y escribe" "SQL"
        //censurarmensajes -> basedatos "lee y escribe" "SQL"
        recibirnovedades -> basedatos "lee y escribe" "SQL"
        publicomen -> basedatos "lee y escribe" "SQL"
        editcomen -> basedatos "lee y escribe" "SQL"
        califtutor -> basedatos "lee y escribe" "SQL"
        subirarchivos -> basedatos "lee y escribe" "SQL"
        modifarchivos -> basedatos "lee y escribe" "SQL"
        descarchivos -> basedatos "lee y escribe" "SQL"
        visuarchivos -> basedatos "lee y escribe" "SQL"
        guardadoautomatico -> basedatos "lee y escribe" "SQL"
        accesograbaciones -> basedatos "lee y escribe" "SQL"
        generarenlace -> basedatos "lee y escribe" "SQL"
        //asignacionroles -> basedatos "lee y escribe" "SQL"
        //porfecha -> basedatos "lee y escribe" "SQL"
        //portutor -> basedatos "lee y escribe" "SQL"
        //portema -> basedatos "lee y escribe" "SQL"
        //porpopularidad -> basedatos "lee y escribe" "SQL"        
        
    }
    views {
        systemContext tuttorconect {
            include *
            autolayout
        }
        container tuttorconect {
            include *
            //autolayout
        }
        component gestionUsuario {
            include *
            include facade
            //autolayout
        }
        component gestionTutoria {
            include *
            include facade
            //autolayout
        }
        component sistemaComunicaciones {
            include *
            include facade
            //autolayout
        }
        
        styles {
            element "Oracle" {
                shape "Cylinder"
                background "#ec0e0e"
                color "#ffffff"
            }
            element "Sistema" {
                shape "RoundedBox"
                background "#3412de"
                color "#ffffff"
            }
            element "Api" {
                shape "Ellipse"
                background "#3412de"
                color "#ffffff"
            }
        }
        theme default
    }
}
