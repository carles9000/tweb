#include "FileIO.ch"
#include "common.ch"

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
		case hParam[ 'type' ] == 'C'; 	uValue := hb_urldecode(hParam[ 'value' ]) 
		case hParam[ 'type' ] == 'H'; 	uValue := hb_jsonDecode( hb_urldecode( hParam[ 'value' ] ) )
		case hParam[ 'type' ] == 'N'; 	uValue := Val( hParam[ 'value' ] )
		case hParam[ 'type' ] == 'L';  uValue := if( hParam[ 'value' ] == 'true', .t., .f.  )
		otherwise
			uValue := hParam[ 'value' ]
	endcase	

retu uValue
	
