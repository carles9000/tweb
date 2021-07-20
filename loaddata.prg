#define PATH_DATA 		HB_GetEnv( "PRGPATH" ) + '/data/'

function LoadData( nLen, lRecno )

    local cAlias, nI
	local aRows := {}
	
	DEFAULT nLen TO 100
	DEFAULT lRecno TO .T.
	
	USE ( PATH_DATA + 'test.dbf' ) SHARED NEW VIA 'DBFCDX'
	
	cAlias := Alias()
	
	for nI := 1 to nLen
		
		aRow := {=>}		
	
		if  lRecno 
			aRow[ 'id' ] := (cAlias)->( Recno())
		endif
		
		aRow[ 'first'] 		:= UHtmlEncode( (cAlias)->first  )	
		aRow[ 'last' ] 		:= UHtmlEncode( (cAlias)->last 	 )	
		aRow[ 'street'] 	:= UHtmlEncode( (cAlias)->street  )	
		aRow[ 'city'] 		:= UHtmlEncode( (cAlias)->city 	 )	
		aRow[ 'state'] 		:= UHtmlEncode( (cAlias)->state 	 )
		aRow[ 'zip'] 		:= UHtmlEncode( (cAlias)->zip 	 )	
		aRow[ 'hiredate'] 	:= DToC( (cAlias)->hiredate )			
		aRow[ 'married'] 	:= (cAlias)->married 	 				
		aRow[ 'age' ] 		:= (cAlias)->age 						
		aRow[ 'salary'] 	:= (cAlias)->salary					
		//aRow[ 'notes'] 		:= UHtmlEncode( (cAlias)->notes )				
		
		//	Permision for html code without escape
		//	Only we will escape quotes -> "" , ''
		
			aRow[ 'notes']	:= UHtmlQuotes( alltrim( (cAlias)->notes ) )
		
		//	-------------------------------------------------------------
			
		Aadd( aRows,  aRow )
		
		(cAlias)->( dbskip() )
	next
	
return aRows