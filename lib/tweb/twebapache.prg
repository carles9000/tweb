#define TAG_DISPOSITION  	'Content-Disposition: form-data;'
#define TAG_END  			'------'

function ZAP_BodyPairs()
	local oError
	local bLastHandler := Errorblock( {|oError| MyError( oError ), Break(oError) } )
	local o 			
	
	o := BodyPairs():New()	
	
	ErrorBlock(bLastHandler) // Restore handler   
	
retu o:hData

function MyError( oError )
	//? 'Error'
	//? '====='
	//? oError 
retu nil


CLASS BodyPairs

	DATA hData 		INIT {=>}

    METHOD New()
	
	METHOD Extract()
	METHOD ProcData()

ENDCLASS

//----------------------------------------------------------------------------//

METHOD New( cData ) CLASS BodyPairs

	local cPart := ''

	DEFAULT cData TO AP_Body() 		//AP_PostPairs()	
	//DEFAULT cData := GetData()

	while ::Extract( @cData, @cPart )
		
		::ProcData( cPart )

	end

RETU Self



METHOD Extract( cData, cPart ) CLASS BodyPairs

	local nIni 		:= hb_At( TAG_DISPOSITION , cData )
	local nEnd 		
	local lFound 	
	local cStrIni, cStrFi
	
	DEFAULT cData TO ''
	DEFAULT cPart TO ''
	
	if nIni == 0
		retu .f.
	endif
	
	nEnd 	:= hb_At( TAG_END, cData, nIni )
	lFound 	:= ( nIni > 0 .and. nEnd > 0 )
	
	if lFound
	
		cPart 	:= alltrim(Substr( cData, ( nIni + len( TAG_DISPOSITION ) ), ( nEnd - nIni - len( TAG_DISPOSITION ) - 2 ) ))
	
		cStrIni := Substr( cData, 1, nIni-1 ) 
		cStrFi  := Substr( cData, nEnd ) 
		cData 	:= cStrIni + cStrFi 
		
	endif
	
retu lFound

METHOD ProcData( cPart ) CLASS BodyPairs

	local nStart, nEnd, cVarName
	
	DEFAULT cPart TO ''

	//	check name var
	
		if ( nStart := hb_At( 'name="', cPart ) ) == 0
			retu nil
		endif
		
		if ( nEnd 	:= hb_At( '"', cPart, nStart + 7 ) ) == 0
			retu nil
		endif

		
		cVarName := Alltrim(Substr( cPart, nStart + 6 , nEnd - (nStart+6) ))


	//	check si file upload
	
		if ( nStart := hb_At( "base64,", cPart ) ) > 0			
			::hData[ cVarName ] := Substr( cPart, nStart + 7 )						
		else		
			::hData[ cVarName ] := Alltrim( Substr( cPart, nEnd + 1 ))			
		endif

retu nil



//----------------------------------------------------------------------------//
/*	Example de quan enviem formdata amb molt de contingut....

"------WebKitFormBoundaryf5o7two9i5wUlZtv\r\n
Content-Disposition: form-data; name": "clip.png"; filename="blob"
Content-Type: application/octet-stream

data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQBAMAAAGa2tLEAAAAAXNSR0IArs4c6QAAADBQTFRFgAAAAAAAAIAAgIAAAACAgACAAICAgICAwMDA/wAAAP8A//8AAAD//wD/AP//////tw+rZwAAAAF0Uk5TAEDm2GYAAAAJcEhZcwAACxMAAAsTAQCanBgAAAAHdElNRQfeCw4KOyB5pNv7AAAAL0lEQVQI12NgQAICDPgAuziMxcgIJAQFMQkBkAQj1BhBAZhqRhhNkMEuwCCOZCUAYNoBPf68fOsAAAAASUVORK5CYII=
------WebKitFormBoundaryf5o7two9i5wUlZtv
Content-Disposition: form-data; name="database.png"; filename="blob"
Content-Type: application/octet-stream

data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQBAMAAAGa2tLEAAAAAXNSR0IArs4c6QAAADBQTFRFgAAAAAAAAIAAgIAAAACAgACAAICAgICAwMDA/wAAAP8A//8AAAD//wD/AP//////tw+rZwAAAAF0Uk5TAEDm2GYAAAAJcEhZcwAACxMAAAsTAQCanBgAAAAHdElNRQfeCw4KOyB5pNv7AAAAL0lEQVQI12NgQAICDPgAuziMxcgIJAQFMQkBkAQj1BhBAZhqRhhNkMEuwCCOZCUAYNoBPf68fOsAAAAASUVORK5CYII=
------WebKitFormBoundaryf5o7two9i5wUlZtv
Content-Disposition: form-data; name="test11"

hola guapu
------WebKitFormBoundaryf5o7two9i5wUlZtv
Content-Disposition: form-data; name="test22"

Adios Baby
------WebKitFormBoundaryf5o7two9i5wUlZtv--
"
*/
