//	{% LoadHrb( '../../lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude( '../../lib/tweb/' ) %}


function Main()

	local cHtml := ''
	local x := ''

	//	Verifico que exista una session. Si no existe no esta autorizado.

		if  ! Is_Session()
	
			Redirect( "app_login.prg" )				
			retu nil
		endif
		
	//	Iniciamos Session
		
		InitSession()	

	DEFINE WEB oWeb TITLE 'App' INIT

    DEFINE FORM o

	INIT FORM o  		
		
		HTML o 
		
			<h3>Menu principal</h3><hr>			

			<ul>
			  <li><a href="app_consulta.prg">Consulta</a></li>
			  <li><a href="app_dummy.prg">Dummy...</a></li>
			  <li><a href="app_logout.prg">Logout</a></li>
			</ul>

			<hr>
		
		ENDTEXT		
		
		
	//	Podemos recuperar variables que tenemos almacenadas en la session	
 
		ROW o
			SAY LABEL 'User: ' + Session( 'user' ) GRID 5 OF o
			SAY LABEL 'Entrada a las ' + Session( 'in' ) GRID 7 OF o
		END o 

	END FORM o		
		
retu nil 