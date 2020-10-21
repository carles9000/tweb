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
		
		? '<h4>Recuperamos Variables de Session</h4><hr>'		
		
		? 'Var. DNI: '		, Session( 'dni' )				
		? 'Var. Time: ' 	, Session( 'time' )	
		? 'Var. Today: ' 	, Session( 'today' ) 	
		

	//	Cerramos Session. A partir de ahora las variables ya NO son accesibles...	
	
		EndSession()				

		? '<h4>Cierre de Session. Si refrescamos el sistema detecta que no existe session - F5 Refresh Page</h4><hr>'
		
return nil 