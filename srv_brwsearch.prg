//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#define PATH_DATA 		HB_GetEnv( "PRGPATH" ) + '/data/'

function main()

	local hParam		:= GetMsgServer()
	local cState 		:= hParam[ 'search' ] 
	local aRows     	:= {}
	local cDbf			:= PATH_DATA + 'test.dbf'
	
	IF ! empty( cState )

	    USE (cDbf) SHARED NEW VIA 'DBFCDX'
	    cAlias := Alias()

	    (cAlias)->( OrdSetFocus( 'STATE') )
	    (cAlias)->( DbSeek( cState, .T. ) )
	    
	    WHILE (cAlias)->state == cState .AND. (cAlias)->( !Eof() )
	    
	        Aadd( aRows, {  'first'     => (cAlias)->first,;
	                        'last'      => (cAlias)->last,;
	                        'age'       => (cAlias)->age ;
	                        } )
	    
	        (cAlias)->( DbSkip() )
	    END
	    
	    (cAlias)->( DbCloseArea() )

    ENDIF
	
	AP_SetContentType( "application/json" )
	
	hResponse := { 'rows' => aRows }
	
	?? hb_jsonEncode( hResponse ) 

retu nil 