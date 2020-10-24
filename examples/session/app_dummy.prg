//	{% LoadHrb( '../../lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude( '../../lib/tweb/' ) %}


function Main()

	local cHtml := ''

	//	Verifico que exista una session. Si no existe no esta autorizado.

		if  ! Is_Session()
		
			Redirect( "app_login.prg" )				
			retu nil
		endif
		
	//	Iniciamos Session
		
		InitSession()			
		
	DEFINE WEB oWeb TITLE 'App' INIT

    DEFINE FORM o ACTION 'app_srv_login'

	INIT FORM o  

		HTML o INLINE '<h3>Dummy Screen</h3><hr>'		
		
		
	//	Podemos recuperar variables que tenemos almacenadas en la session	
 
		ROW o
			SAY LABEL 'User: ' + Session( 'user' ) GRID 5 OF o
			SAY LABEL 'Entrada a las ' + Session( 'in' ) GRID 7 OF o
		END o 
		
    END FORM o			
	
retu nil 