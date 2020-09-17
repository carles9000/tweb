#define PATH_DATA 		HB_GetEnv( "PRGPATH" ) + '/data/'

function LoadData( nLen )

    local cAlias, nI
	local aRows := {}
	
	DEFAULT nLen TO 100
	
	USE ( PATH_DATA + 'test.dbf' ) SHARED NEW VIA 'DBFCDX'
	
	cAlias := Alias()
	
	for nI := 1 to nLen
						
		Aadd( aRows,  { 'first' 	=> UHtmlEncode( (cAlias)->first  )	,;
						'last' 		=> UHtmlEncode( (cAlias)->last 	 )	,;						
						'street'	=> UHtmlEncode( (cAlias)->street  )	,;						
						'city'		=> UHtmlEncode( (cAlias)->city 	 )	,;						
						'state'		=> UHtmlEncode( (cAlias)->state 	 )	,;						
						'zip'		=> UHtmlEncode( (cAlias)->zip 	 )	,;						
						'hiredate'	=> DToC( (cAlias)->hiredate )			,;						
						'married'	=> (cAlias)->married 	 				,;						
						'age' 		=> (cAlias)->age 						,;	
						'salary'	=> (cAlias)->salary					,;						
						'notes'		=> UHtmlEncode( (cAlias)->notes 	 )	 ;
					})						
		
		(cAlias)->( dbskip() )
	next
	
return aRows
