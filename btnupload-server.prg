//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

function main()	
		
	LOCAL cPath 				:= hb_getenv( 'PRGPATH' ) + '/upload'
	local hPairs 				:= AP_PostPairs()
    local aH 					:= {=>}
    local cData, cFileName, nStart, cFilePath
    local f, c	
	local hRow 
	
	local cTag, nIni, nEnd, cSubstring, cString
	
	
	? cPath
	? len( hPairs )
	
	cData = HB_HValueAt( hPairs, 1 )
	
	//	--------------------------------------
	ferase( cPath + '/x.txt' )
	hb_memowrit( cPath + '/x.txt', cData )
	//	--------------------------------------
	
	/*	Example upload --------------------------
	
		"clip.png"; filename="blob"
		Content-Type: application/octet-stream

		data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQBAMAAAGa2tLEAAAAAXNSR0IArs4c6QAAADBQTFRFgAAAAAAAAIAAgIAAAACAgACAAICAgICAwMDA/wAAAP8A//8AAAD//wD/AP//////tw+rZwAAAAF0Uk5TAEDm2GYAAAAJcEhZcwAACxMAAAsTAQCanBgAAAAHdElNRQfeCw4KOyB5pNv7AAAAL0lEQVQI12NgQAICDPgAuziMxcgIJAQFMQkBkAQj1BhBAZhqRhhNkMEuwCCOZCUAYNoBPf68fOsAAAAASUVORK5CYII=
		------WebKitFormBoundaryBAGldlBuQUhjJqgn
		Content-Disposition: form-data; name="test"

		HELLO!
		------WebKitFormBoundaryBAGldlBuQUhjJqgn
		Content-Disposition: form-data; name="god"

		MESSI
		------WebKitFormBoundaryBAGldlBuQUhjJqgn--							
	
	--------------------------------------------- */




	
	hPairs := {=>}
	
	cTag := 'Content-Disposition: form-data; name="'
	
	while ( nIni := At( cTag, cData )	) > 0 .and. ( nFi  := hb_At( '------', cData, nIni ) ) > 0
	
		cSubstring	:= Substr( cData , nIni, nFi-nIni )
		cData1		:= Substr( cData, 1, nIni-1 )
		cData2		:= Substr( cData, nFi + 6 )
		cData 		:= cData1 + cData2		
		
		//	Estraer nombre variable
		
			if ( nIni := hb_At( 'name="', cSubstring ) ) > 0  .and. ( nFi := hb_At( '"', cSubstring, nIni + 6 ) ) > 0 
			
				cKey 	:= Substr( cSubstring, nIni + 5, nFi - nIni - 1)					
				cValue 	:= alltrim(Substr( cSubstring, nFi+ 1))
				
				hPairs[ cKey ] := cValue								
			
			endif

	end
	
	? valtochar( hPairs )
	hb_memowrit( cPath + '/x2.txt', cData )
	retu
	
	
	
	/*
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
	*/
	
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