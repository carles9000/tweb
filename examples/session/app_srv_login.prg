//	{% LoadHrb( '../../lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude( '../../lib/tweb/' ) %}

function main()

	local hParam := AP_PostPairs()
	
	if hParam[ 'user' ] == 'demo' .and. hParam[ 'psw' ] == '1234'
	
	
	//	Inicio sistema de Sesiones y salvo mis variables...
	
		InitSession()						
		Session( 'user',  hParam[ 'user' ] )
		Session( 'in',  time() )
		
	//	Redirijo
	
		Redirect( 'app_menu' )			
		
	else
	
		Redirect( "app_login.prg" )		
		
	endif
	


retu nil