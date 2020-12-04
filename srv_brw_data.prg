//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}
#include {% TWebInclude() %}

#define PATH_DATA 		HB_GetEnv( "PRGPATH" ) + '/data/'

function main()

	local hParam 		:= GetMsgServer()	

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
	local o

	USE (cDbf) SHARED NEW VIA 'DBFCDX'
	cAlias := Alias()
	
	o := MyDataset( cAlias )
	
	SET DATE FORMAT TO 'YYYY-MM-DD'
	SET DELETED ON
	
	WHILE (cAlias)->( !Eof() )
	
		Aadd( aRows, o:Row() )
	
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
	local o, nUpdated := 0
	local aUpdated := 0
	

	USE (cDbf) SHARED NEW VIA 'DBFCDX'
	cAlias := Alias()
	
	SET DATE FORMAT TO 'YYYY-MM-DD'
	SET DELETED ON	

	o := MyDataset( cAlias )
	
	aUpdated := o:Save( aData )
	nUpdated := len( aUpdated )
	
	//(cAlias)->( DbCommit() )
	//(cAlias)->( DbCloseArea() )

	AP_SetContentType( "application/json" )	
	
	hResponse := { 'success' => .T., 'updated' => nUpdated, 'rows_updated' => aUpdated, 'error' => o:GetError(), 'errortxt' => o:GetErrorString() }
	
	?? hb_jsonEncode( hResponse ) 	

retu nil


function MyDataset( cAlias, cDbf ) 

	local o 
	
	DEFINE BROWSE DATASET o ALIAS cAlias 

		FIELD 'first' 		UPDATE  OF o
		FIELD 'last'  		UPDATE 	VALID {|o, uValue, hRow| NoPPP( o, uValue, hRow ) } OF o
		FIELD 'street'  	UPDATE 	OF o
		FIELD 'city'   				OF o
		FIELD 'state'  				OF o
		FIELD 'zip'  				OF o
		FIELD 'hiredate'  	UPDATE 	OF o
		FIELD 'married'  	UPDATE 	OF o
		FIELD 'age'    		UPDATE 	VALID {|o, uValue, hRow| MaxAge( o, uValue, hRow ) } OF o
		//FIELD 'salary'  		OF o
		FIELD 'notes'  		UPDATE	NOESCAPE OF o	
	
	
//	o:bBeforeSave := {|cAlias, uValue, hRow| MaxAge( cAlias, uValue, hRow ) }
	
	//o:Field( 'virtual', nil, {|cAlias, row| Virtual(cAlias, row) } )
	
retu o

function MaxAge( o, uValue, hRow ) 

	local nAge 	:= if( valtype(uValue) == 'N', uValue, val( uValue )) 	
	local lValid 	:= ( nAge > 0 .and. nAge < 100 )
	
	if !lValid
		o:SetError( '[' + valtochar(hRow['_recno']) + '] <b>Age</b> Value out of range: ' + valtochar( uValue ) )
		//o:SetError( { 'recno' => hRow['_recno'], 'msg' => '<b>Age</b> Value out of range: ' + valtochar( uValue ) }  )
	endif	

return lValid

function NoPPP( o, uValue, hRow) 

	local lValid := .t.
	
	if uValue == 'PPP'
		o:SetError( '[' + valtochar(hRow['_recno']) + '] <b>Street</b> PPP no permitido' )
		//o:SetError( { 'recno' => hRow['_recno'], 'msg' => '<b>Street</b> PPP no permitido'}  )
		lValid := .f.
	endif	
	
return lValid