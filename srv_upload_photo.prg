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
	local cFile 	:= 'photo_' + ltrim(str(hb_milliseconds())) + '.jpg'
	local h 		:= GetMsgUpload()	
	local lSuccess 	:= .f.	
	
	AP_SetContentType( "application/json" )			
	
	lSuccess 		:= hb_MemoWrit( cPath + cFile , h[ 'blob' ] )	
	
	?? hb_jsonencode( { 'success' => lSuccess, 'file' => cFile } )	

retu nil 