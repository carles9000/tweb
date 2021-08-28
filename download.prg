//	Depende de como tengas configrado tu navegador, salvara en la carpeta
//	download o preguntarà donde quieres salvar el fichero

function main()

	local hGet 	:= Ap_getpairs()
	local cFile 	:= ''
	local cSource 	:= ''
	
	if valtype( hGet ) == 'H' .and. HB_HHasKey( hGet, 'prg' )
	
		cFile 		:= HB_GetEnv( 'PRGPATH' ) + '/' + hGet[ 'prg' ]		
		
		if ! file( cFile )
			retu nil 
		endif
		
		cSource 	:= Memoread( cFile )				 	
		
		AP_HeadersOutSet( "Content-Description", 'File Transfer' )
		AP_HeadersOutSet( "Content-Type", 'text/plain' )
		AP_HeadersOutSet( "Content-Disposition", "attachment;filename=" + hGet[ 'prg' ]  )	
			
		??  cSource 
		
	else
	
		retu nil 
		
	endif
	
retu nil 