//	------------------------------------------------------------------------------
//	Ejemplos por orden de ejecucion:
//
//	test_session.prg			- Crear session y salvar variables
//	test_session_read.prg		- Si existe session, inicializa y recupera variables almacenadas
//	test_session_end.prg		- Si existe session, inicializa, recupera y elimina session
//	------------------------------------------------------------------------------

//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function Main()

	local cDni 	:= '39690495X'
	local cTime 	:= time()


	//	Inicializo el sistema de Sessiones
	
		?? '<h3>Iniciamos una Session</h3><hr>'
		
		InitSession()		
		
		
	//	Salvo mis variables que recuperare desde otras páginas...
		
		Session( 'dni',  cDni )
		Session( 'time', cTime )
		

		? '<h4>Se ha creado una session y añadido las variables dni y time - F5 Refresh Page</h4><hr>'
		
		? 'Dni: ' , cDni
		? 'Time: ' , cTime	

		? "<h4>Ir a otro ejemplo que inciará Sessiones y leerá estas variables - <a href='test_session_read.prg'>test_session_read.prg</a></h4><hr>"
	
retu nil 
