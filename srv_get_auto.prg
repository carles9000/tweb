#define PATH_DATA 		HB_GetEnv( "PRGPATH" ) + '/data/'

function main()

	local aRows := {}
	local cSearch  := HB_HGetDef( AP_PostPairs(), 'query', '' )

	if empty( cSearch )
		AP_SetContentType( "application/json" )
		?? hb_jsonEncode( {=>} )		
	endif
	
	USE ( PATH_DATA + 'test.dbf' ) SHARED NEW VIA 'DBFCDX'
	SET INDEX TO ( PATH_DATA + 'test.cdx' )
	
	cAlias := Alias()
	
	(cAlias)->( OrdSetFocus( 'FIRST' ) )
	
	(cAlias)->( DbSeek( cSearch, .T. ) )
	
	WHILE (cAlias)->first = cSearch .and. (cAlias)->( !Eof() )
	
		Aadd( aRows, {  'id' => ltrim(str((cAlias)->( Recno() ))),;
						'value' => Alltrim((cAlias)->first)  + ' ' + Alltrim((cAlias)->last),;
						'street' => Alltrim((cAlias)->street),;
						'city' => Alltrim((cAlias)->city ),;
						'zip' => Alltrim((cAlias)->zip ) ;
						} )
	
		(cAlias)->( DbSkip() )
	END

	AP_SetContentType( "application/json" )
	?? hb_jsonEncode( aRows )
		
retu nil