function main()

	local cFile 	:= HB_GetEnv( 'PRGPATH' ) + '/' + AP_Args()
	local cSource 	:= Memoread( cFile )		

	cSource := UHtmlEncode( cSource )
	cSource := StrTran( cSource, CRLF, '<br>' ) 
	
	??  cSource 
	
retu nil

FUNCTION UHtmlEncode(cString)

	LOCAL nI, cI, cRet := ""

	FOR nI := 1 TO LEN(cString)
		cI := SUBSTR(cString, nI, 1)

		IF cI == "<"
		  cRet += "&lt;"
		ELSEIF cI == ">"
		  cRet += "&gt;"
		ELSEIF cI == "&"
		  cRet += "&amp;"
		ELSEIF cI == '"'
		  cRet += "&quot;"
		ELSE
		  cRet += cI
		ENDIF	
		
	NEXT
	
RETURN cRet