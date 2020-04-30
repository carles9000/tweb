//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

//	Recojo parametro enviado y lo devuelvo... :-)

function main()

	local hParam := GetMsgServer()
	
	
	AP_SetContentType( "application/json" )	
	?? hb_jsonEncode( hParam )	

retu nil