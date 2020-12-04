//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#define PATH_DATA 		HB_GetEnv( "PRGPATH" ) + '/data/'

function main()

	local hParam 		:= GetMsgServer()
	//local cState 		:= hParam[ 'value' ] 


	do case
	
		case hParam[ 'action' ] == 'load' 
		
			LoadData()
			
		case hParam[ 'action' ] == 'save'

			SaveData( hParam[ 'data' ] )
			
	endcase
	
retu NIL


function LoadData() 

	local aRows     	:= {}
	local cDbf			:= PATH_DATA + 'test.dbf'
	local cAlias, hResponse 		

	USE (cDbf) SHARED NEW VIA 'DBFCDX'
	cAlias := Alias()
	
	SET DATE FORMAT TO 'YYYY-MM-DD'
	SET DELETED ON
	
	WHILE (cAlias)->( !Eof() )
	
		Aadd( aRows, { '_recno'     => (cAlias)->( Recno() ),;							
						'first'     => (cAlias)->first,;
						'last'      => (cAlias)->last,;
						'street'    => (cAlias)->street,;
						'city'      => (cAlias)->city,;
						'state'     => (cAlias)->state,;
						'zip'       => (cAlias)->zip,;
						'hiredate'  => DToC( (cAlias)->hiredate ),;
						'married'   => (cAlias)->married,;
						'age'       => (cAlias)->age,;
						'salary'    => (cAlias)->salary,;
						'notes'     => (cAlias)->notes;
						} )
	
		(cAlias)->( DbSkip() )
	END
	
	(cAlias)->( DbCloseArea() )
	
	AP_SetContentType( "application/json" )
	
	hResponse := { 'rows' => aRows, 'len' => len( aRows) }
	
	?? hb_jsonEncode( hResponse ) 

retu nil 

function SaveData( aData ) 

	local cDbf			:= PATH_DATA + 'test.dbf'	
	local nRows 		:= len( aData )
	local nI, cAction, hRow 
	local cAlias, hResponse 
	

	USE (cDbf) SHARED NEW VIA 'DBFCDX'
	cAlias := Alias()
	
	SET DATE FORMAT TO 'YYYY-MM-DD'
	SET DELETED ON	
	
	for nI := 1 to nRows 

		cAction := aData[ nI ][ 'action' ]

		hRow 	:= aData[ nI ][ 'row' ]
		
		do case
		
			case cAction == 'A' 
			
				(cAlias)->( DbAppend() )
				SaveRow( cAlias, hRow )
				
			case cAction == 'U'
			
				(cAlias)->( DbGoTo( hRow[ '_recno' ] ) )
				
				if (cAlias)->( DbRlock() )
					SaveRow( cAlias, hRow )
				endif
				
			case cAction == 'D'
			
				(cAlias)->( DbGoTo( hRow[ '_recno' ] ) )
				
				if (cAlias)->( DbRlock() )				
					(cAlias)->( DbDelete() )				
				endif															
		
		endcase 				
	
	next
	
	AP_SetContentType( "application/json" )
	
	hResponse := { 'success' => .T., 'rows' => nRows }
	
	?? hb_jsonEncode( hResponse ) 	

retu nil


function MySaveRow( cAlias, hRow ) 

	//DATASET
	//DEFINE ROW 'first' T
	//DEFINE ROW 'age' 		TYPE 'N' DEFAULT 0 
	//DEFINE ROW 'hiredate' TYPE 'D' DEFAULT date()



retu 




function SaveRow( cAlias, hRow ) 

	if HB_HHasKey( hRow, 'first' )
		(cAlias)->first     := hRow[ 'first' ]
	endif
	
	if HB_HHasKey( hRow, 'city' )
		(cAlias)->last      := hRow[ 'city' ]
	endif
	
	if HB_HHasKey( hRow, 'city' )
		(cAlias)->street    := hRow[ 'city' ]
	endif
	
	if HB_HHasKey( hRow, 'city' )
		(cAlias)->city      := hRow[ 'city' ]
	endif
	
	if HB_HHasKey( hRow, 'state' )
		(cAlias)->state     := hRow[ 'state' ]
	endif
	
	if HB_HHasKey( hRow, 'zip' )
		(cAlias)->zip       := hRow[ 'zip' ]
	endif
	
	if HB_HHasKey( hRow, 'hiredate' )
		if !empty(hRow[ 'hiredate' ])
			(cAlias)->hiredate  := CToD( hRow[ 'hiredate' ] )
		endif
	endif	
	
	if HB_HHasKey( hRow, 'married' )
		(cAlias)->married   := hRow[ 'married' ]
	endif
	
	if HB_HHasKey( hRow, 'age' )
		if valtype( hRow[ 'age' ] ) != 'N' 
			hRow[ 'age' ] := val( hRow[ 'age' ] )
		endif
			
		(cAlias)->age       := hRow[ 'age' ]
	endif
	
	
	if HB_HHasKey( hRow, 'salary' )
		(cAlias)->salary    := hRow[ 'salary' ]
	endif
	
	if HB_HHasKey( hRow, 'notes' )
		(cAlias)->notes  	:= hRow[ 'notes' ]
	endif


retu nil 