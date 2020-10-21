//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}


function Main()

	//	Verifico que exista una session. Si no existe no esta autorizado.
	
		if  !Session()
			?? "<h3>Session doesn't exist. Please autenticate - <a href='test_session.prg'>test_session.prg</a></h3><hr>"
			retu nil
		endif
		
	//	En este punto, el sistema detecta que que existe una Session
	
		?? "<h3>Session existe. Incializamos el sistema de Sessiones</h3><hr>"
	
	//	Inicializo el sistema de Sessiones

		InitSession()

	//	Recupero los valores...
		
		? '<h4>Recuperamos Variables de Session - F5 Refresh Page</h4><hr>'
		
		
		? 'Var. DNI: '		, Session( 'dni' )				
		? 'Var. Time: ' 	, Session( 'time' )	
		? 'Var. Today: ' 	, Session( 'today' ) 		// First time doesn't exist
		
	//	Setter de valores
		
		Session( 'time', time() )				//	Actualizo variable 'time' a la Session
		Session( 'today', date() )				//	Añado variable 'today' a la Session
		
		? '<h4>La primera vez, no existe aun la variable Today y la hemos inicializado. '
		?? 'Actualizamos variable Time - F5 Refresh Page</h4><hr>'
		
		? "<h4>Ir a otro ejemplo que volvemos a leer variables y cerramos la session - <a href='test_session_end.prg'>test_session_end.prg</a></h4><hr>"		
	
retu nil 