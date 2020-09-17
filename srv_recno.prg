#define PATH_DATA 		HB_GetEnv( "PRGPATH" ) + '/data/'

function main()

	local hParam 	:= AP_PostPairs()
	local nRecno 	:= Val( hParam[ 'value' ] )
	local cDbf		:= PATH_DATA + 'test.dbf'
	
	USE (cDbf) SHARED NEW VIA 'DBFCDX'		
	
	GOTO nRecno

	?? FIELD->first + ' ' + FIELD->last  + CRLF
	?? FIELD->street + ' ' + FIELD->city + ' ' + FIELD->state + CRLF
	?? FIELD->notes
	
retu nil