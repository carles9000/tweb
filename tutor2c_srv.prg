//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

function main()

	local uValues 	:= GetMsgServer()
	local cPhone	:= ''
	local lSuccess 	:= .f.
	
	AP_SetContentType( "application/json" )		
	
	
	if uValues[ 'myid' ] == '123'
		lSuccess 	:= .t.
		cPhone 		:= '(34) 696948920'
	endif
	
	
	if lSuccess
		?? hb_jsonEncode( { 'success' => lSuccess, 'phone' => cPhone } )	
	else
		?? hb_jsonEncode( { 'success' => lSuccess, 'error' => 'ID not found! => ' + uValues[ 'myid' ] } )	
	endif
	

retu nil