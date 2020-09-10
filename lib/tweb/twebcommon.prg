//	-------------------------------------------------------------

#include "FileIO.ch"


//	------------------------------------------------------------
//	FUNCTION from Mindaugas code -> esshop
//	------------------------------------------------------------

FUNCTION UHtmlEncode(cString)

   local cChar, cRet := "" 

   for each cChar in cString
		do case
			case cChar == "<"	; cChar := "&lt;"
			case cChar == '>'	; cChar := "&gt;"     				
			case cChar == "&"	; cChar := "&amp;"     
			case cChar == '"'	; cChar := "&quot;" 
			case cChar == "'"	; cChar := "&apos;"   			          
		endcase
		
		cRet += cChar 
   next
	
RETURN cRet

//	----------------------------------------------------------------
//	Recupera la variable enviada con MsgServer() en su tipo original
//	----------------------------------------------------------------

function GetMsgServer()

	local hParam 	:= AP_PostPairs()
	local uValue 
	
	do case
		case hParam[ 'type' ] == 'C'; 	uValue := hParam[ 'value' ]
		case hParam[ 'type' ] == 'H'; 	uValue := hb_jsonDecode( hParam[ 'value' ] ) 
		case hParam[ 'type' ] == 'N'; 	uValue := Val( hParam[ 'value' ] )
		case hParam[ 'type' ] == 'L';   uValue := if( hParam[ 'value' ] == 'true', .t., .f.  )
		otherwise
			uValue := hParam[ 'value' ]
	endcase	

retu uValue


//	-----------------------------------------------------------
//	Transforma una variable harbour al mismo tipo en Javascript
//	-----------------------------------------------------------

function SetDataJS( u )

	local uValue 	:= ''
	local cType 	:= valtype( u )

	do case
		case cType == 'C'  ; uValue := "'" + u + "'"
		case cType == 'N'  ; uValue := u 
		case cType == 'L'  ; uValue := if( u, 'true', 'false' )
		case cType == 'D'  ; uValue := "'" + DToC( u ) + "'"
		case cType == 'H'  ; uValue := "JSON.parse( '" +  hb_jsonencode( u )	+ "'); " 
		case cType == 'A'  ; uValue := "JSON.parse( '" +  hb_jsonencode( u )	+ "'); "
		otherwise
			uValue := "'" + valtochar(u) + "'"
	endcase

retu uValue


//	-----------------------------------------------------------
//	Include de una file
//	-----------------------------------------------------------

FUNCTION LoadFile( cFile ) 

	local cPath 		:= AP_GetEnv( "DOCUMENT_ROOT" ) 	
	local oError, cPathFile
   
	hb_default( @cFile, '' )
	
	if empty( AP_GetEnv( "PATH_APP" )  )
		cPath := HB_GetEnv( "PRGPATH" ) 
	else
		cPath := AP_GetEnv( "DOCUMENT_ROOT" ) +  AP_GetEnv( "PATH_APP" )
	endif
	
	if right( cPath ) != '\' .or. right( cPath ) != '/'
		cPath += '/'
	endif	

	cPathFile = cPath + cFile   
   
	if "Linux" $ OS()
		cPathFile = StrTran( cPathFile, '\', '/' )     
	endif   
    
	if File( cPathFile )
		return MemoRead( cPathFile )
	else

		oError := ErrorNew()
		oError:Subsystem   := "System"
		oError:Severity    := 2	//	ES_ERROR
		oError:Description := "LoadFile() File not found: " + cPathFile
		Eval( ErrorBlock(), oError)
   endif

RETU ''