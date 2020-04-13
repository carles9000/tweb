#include "FileIO.ch"
#include "common.ch"

//	------------------------------------------------------------
//	FUNCTION from Mindaugas code -> esshop
//	------------------------------------------------------------

FUNCTION UHtmlEncode( cString )
/*
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
	*/
	
   local cChar, cResult := "" 

   for each cChar in cString
      do case
		  case cChar == "<"
				cChar = "&lt;"

		  case cChar == '>'
				cChar = "&gt;"     
				
		  case cChar == "&"
				cChar = "&amp;"     

		  case cChar == '"'
				cChar = "&quot;"    
				
		  case cChar == "'"
				cChar = "&apos;"               
      endcase
	  
      cResult += cChar 
	  
   next	
	
	
RETURN cResult


/*
	cString := StrTran( cString, "<", "&lt;")
	cString := StrTran( cString, ">", "&gt;")
	cString := StrTran( cString, "&", "&amp;")
	cString := StrTran( cString, '"', "&quot;")		
	cString := StrTran( cString, "'", "&apos;")	
RETURN cString
*/
	
