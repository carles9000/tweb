//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}
#include {% TWebInclude() %}

#define PATH_DATA 		HB_GetEnv( "PRGPATH" ) + '/data/'

//	Recibiremos via GET 3 parámetros	----------------------------------------
//	search	-> query, cadena,... que marca algo a filtrar. Blanco por defecto
//	offset -> posicion relativa al filtro, al indice. Inicial es 0
//	limit 	-> máximo numero de registros 
//	------------------------------------------------------------------------

function main()

	local dat 			:= {=>}
	local aRows 		:= {}
	local cDbf			:= PATH_DATA + 'test.dbf'	
	local cCdx			:= PATH_DATA + 'test.cdx'	
	local hParam		:= AP_GetPairs()
	local cSearch 		:= hParam[ 'search' ] 
	local nOffset 		:= val( hParam[ 'offset' ] )
	local nLimit 		:= val( hParam[ 'limit' ] )
	local n 			:= 0
	local nTotal 
	
	nOffset := IF( nOffset == 0, 1, nOffset )	
	
	USE (cDbf) SHARED NEW VIA 'DBFCDX'
	SET INDEX TO ( cCdx )
	cAlias := Alias()
	
	(cAlias)->( OrdSetFocus( 'FIRST' ) )

	(cAlias)->( OrdScope( 0, cSearch ) )
	(cAlias)->( OrdScope( 1, cSearch  ) )
		
	(cAlias)->( OrdKeyGoto( nOffset ) )

	//	Process data...
	
		WHILE  n < nLimit .and. (cAlias)->( !Eof() ) 
		
			n++	
		
			Aadd( aRows, { 'keyno'=> (cAlias)->(OrdKeyNo()), '_recno' => (cAlias)->( Recno()), 'first' => (cAlias)->first, 'last' => (cAlias)->last, 'street' => (cAlias)->street } )

		
			(cAlias)->( DbSkip() )
			
		END			
	
	
	//	-----------------------------------------------------
	//	Debemos devolver un hash con 3 keys
	//	total				-> Total registros filtrados, no paginados
	//	totalNotFiltered 	-> Total registros tabla
	//	rows				-> Array de hashes de cada registro 
	//	-----------------------------------------------------
	
		COUNT TO nTotal

		dat[ 'total' ] 				:= (cAlias)->( ordKeyCount() )	
		dat[ 'totalNotFiltered' ] 	:= nTotal
		dat[ 'rows' ] 				:= aRows

	
		AP_SetContentType( "application/json" )
	
	?? hb_jsonEncode( dat ) 

retu nil 
