//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}


/*	---------------------------------------------------------------------------
	GetMsgUpload() devuelve la informacion de subida de un fichero en un hash:
	blob - Fichero decodificado
	file - hash con info de fichero: name, type, size, ext
	data - hash con variables adicionales que se han enviado junto al fichero
	--------------------------------------------------------------------------- */

function main()

	local cPath 	:= hb_getenv( 'PRGPATH' ) + '/upload/'
	local h 		:= GetMsgUpload()	
	local lSuccess 	:= .f.
	local cFile 	
	
	AP_SetContentType( "application/json" )		
	
	cFile 		:= cPath + h[ 'file' ][ 'name' ]			
	
	lSuccess 	:= hb_MemoWrit( cFile , h[ 'blob' ] )	
	
	?? hb_jsonencode( { 'success' => lSuccess, 'info' => h[ 'file' ], 'data' => h[ 'data' ] } )	

retu nil
