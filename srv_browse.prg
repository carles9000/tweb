#define PATH_DATA 		HB_GetEnv( "PRGPATH" ) + '/data/'

function main()

	local hParam 		:= AP_PostPairs()
	local cState 		:= hParam[ 'value' ] 
	local aRows     	:= {}
	local cDbf			:= PATH_DATA + 'test.dbf'

	IF ! empty( cState )

	    USE (cDbf) SHARED NEW VIA 'DBFCDX'
	    cAlias := Alias()

	    (cAlias)->( OrdSetFocus( 'STATE') )
	    (cAlias)->( DbSeek( cState, .T. ) )
	    
	    WHILE (cAlias)->state == cState .AND. (cAlias)->( !Eof() )
	    
	        Aadd( aRows, { '_recno'     => (cAlias)->( Recno() ),;
	                        'first'     => (cAlias)->first,;
	                        'last'      => (cAlias)->last,;
	                        'street'    => (cAlias)->street,;
	                        'city'      => (cAlias)->city,;
	                        'state'     => (cAlias)->state,;
	                        'zip'       => (cAlias)->zip,;
	                        'hiredate'  => (cAlias)->hiredate,;
	                        'married'   => (cAlias)->married,;
	                        'age'       => (cAlias)->age,;
	                        'salary'    => (cAlias)->salary,;
	                        'notes'     => (cAlias)->notes;
	                        } )
	    
	        (cAlias)->( DbSkip() )
	    END
	    
	    (cAlias)->( DbCloseArea() )

    ENDIF
	
	AP_SetContentType( "application/json" )
	
	hResponse := { 'rows' => aRows, 'state' => cState, 'len' => len( aRows) }
	
	?? hb_jsonEncode( hResponse ) 

retu nil 