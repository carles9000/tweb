//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}
#include {% TWebInclude() %}

#define PATH_DATA 		HB_GetEnv( "PRGPATH" ) + '/data/'

function main()

	local hParam 		:= GetMsgServer()	

	do case
	
		case hParam[ 'action' ] == 'load' 
		
			LoadData()
			
		case hParam[ 'action' ] == 'update'

			Update( hParam[ 'data' ] )			
			
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

function Update( aData ) 

	local cDbf			:= PATH_DATA + 'test.dbf'	
	local cAlias, hResponse 
	local o 
	local lUpdated := .F.
	local aUpdated := 0
	

	USE (cDbf) SHARED NEW VIA 'DBFCDX'
	cAlias := Alias()

	o := MyDataset( cAlias )
	
	aUpdated := o:Save( aData )
	lUpdated := len( aUpdated ) > 0 

	AP_SetContentType( "application/json" )	
	
	hResponse := { 'updated' => aUpdated, 'errortxt' => o:GetErrorString() }
	
	?? hb_jsonEncode( hResponse ) 	

retu nil


function MyDataset( cAlias, cDbf ) 

	local o 
	
	DEFINE BROWSE DATASET o ALIAS cAlias 

		FIELD 'first' 		UPDATE  OF o
		FIELD 'last'  		UPDATE 	OF o
		FIELD 'street'  	UPDATE 	OF o
		FIELD 'city'   				OF o
		FIELD 'state'  				OF o
		FIELD 'hiredate'  	UPDATE 	OF o
		FIELD 'married'  	UPDATE 	OF o
		FIELD 'age'    		UPDATE 	OF o
	
retu o
