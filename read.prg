function main()

	local cFile 	:= HB_GetEnv( 'PRGPATH' ) + '/' + AP_Args()
	local cSource 	:= Memoread( cFile )		
	
	??  cSource 
	
retu nil