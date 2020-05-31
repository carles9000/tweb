//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

function main()	
		
	LOCAL cPath 				:= hb_getenv( 'PRGPATH' ) + '/upload'
	local hPairs 				:= AP_PostPairs()
    local aH 					:= {=>}
    local cData, cFileName, nStart, nEnd, cFilePath
    local f, c	
	local hRow 
	
	? cPath
	? len( hPairs )
	
	cData = HB_HValueAt( hPairs, 1 )
	
	//	--------------------------------------
	ferase( cPath + '/x.txt' )
	hb_memowrit( cPath + '/x.txt', cData )
	//	--------------------------------------
	
	? 'Original:', cData
	
	? '***'
	
	cTag := 'Content-Disposition: form-data; name="'
	
	nIni := At( cTag, cData )
	
	nFi  := hb_At( '------', cData, nIni )
	
	c := Substr( cData , nIni, nFi-nIni )
	
	? 'Substring', c 
	
	? '$$$$$'
	
	cData1 := Substr( cData, 1, nIni-1 )
	
	? 'String1: ' , cData1
	
	cData2 := Substr( cData, nFi + 6 )
	
	? '====='
	
	? 'String2: ', cData2
	
	? '&&&&&'
	
	cData := cData1 + cData2
	
	? 'DATA:', cData
	
	
	retu
	
	
	
	/*
	cTag := 'Content-Disposition: form-data; name="'
	
	
	? cTag, nIni
	
	c := substr( cData, nIni + len( cTag ) )
	
	n := At( '"', c )		
	? c
	
	
	cValue := substr( c, 1, n - 1 )
	
	? 'Key', cValue
	
	c := substr( c, n + 1 )
	
	? 'Restante:', c 
	
	nFi :=  At( "------", c )
	
	cValue := alltrim(Substr( c, 1, nFi-1))
	
	? 'Value: ' , cValue
	
	cData := Substr( cData, 1, nIni ) + Substr( cData, nIni + len(cTag) + nFi + 7 )
	
	? 'Pendent', cData
	*/
	

	retu 

	if Len( hPairs ) == 0
		aH[ 'success' ] := .F.
		aH[ 'error' ] := 'Error uploading file'				
	
		return nil
	endif


	
	ferase( cPath + '/x.txt' )
	hb_memowrit( cPath + '/x.txt', cData )
	
	
	retu


		//fErase( cFilePath )


    

	cData = HB_HValueAt( hPairs, 1 )

	cFileName = SubStr( cData, 2, At( ";", cData ) - 3 )
	cFilePath := cPath + cFileName
	
	
	nStart :=  At( "base64,", cData ) + 7 
	nEnd := At( "------", cData )
	
	
	c := SubStr( cData, nStart, ( nEnd - nStart ) )
	
	f := HB_BASE64DECODE( c )	

	//if hb_MemoWrit( cFilePath , f )				
	//endif		

	aH[ 'success' ] 	:=  .T.
	
	AP_SetContentType( "application/json" )
	?? hb_jsonEncode( aRows )	


retu nil