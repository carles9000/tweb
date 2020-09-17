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
	
	/*	Checking properties */
	

	if h[ 'file' ][ 'size' ] > 4000000
		?? hb_jsonencode( { 'success' => lSuccess, 'msg' => 'Max size exceded: ' +   ltrim(str(h[ 'file' ][ 'size' ])) } )
		retu nil
	endif
	
	if ( h[ 'file' ][ 'ext' ] $ 'mp4;' )
		?? hb_jsonencode( { 'success' => lSuccess, 'msg' => 'File extension not allowed: ' + h[ 'file' ][ 'ext' ] } )
		retu nil
	endif	
	
	
	cFile 		:= cPath + h[ 'file' ][ 'name' ]			
	
	lSuccess 	:= hb_MemoWrit( cFile , h[ 'blob' ] )	
	
	?? hb_jsonencode( { 'success' => lSuccess, 'info' => h[ 'file' ], 'data' => h[ 'data' ] } )	

retu nil
