//	{% LoadHrb( '../../lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude( '../../lib/tweb/' ) %}

function main()

	//	Cierro sesiones
	
		EndSession()	
		
	//	Redirijo
	
		Redirect( 'app.prg' )			


retu nil