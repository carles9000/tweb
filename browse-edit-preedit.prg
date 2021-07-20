//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    local o, oCol, oBrw
	local aRows 	:= {}
	
	Aadd( aRows, { 'id' => 'A1', 'name' => 'Charly Aubia' , 'qty' => 12 } )
	Aadd( aRows, { 'id' => 'A2', 'name' => 'Maria de la O', 'qty' =>  7 } )
	Aadd( aRows, { 'id' => 'A3', 'name' => 'John Kocinsky', 'qty' => 23 } )
	Aadd( aRows, { 'id' => 'A4', 'name' => 'Anne Clark'   , 'qty' =>100 } )	
	Aadd( aRows, { 'id' => 'A5', 'name' => 'Daniel Clark' , 'qty' =>  0 } )
	Aadd( aRows, { 'id' => 'A6', 'name' => 'Rod Steward'  , 'qty' => 98 } )
	Aadd( aRows, { 'id' => 'A7', 'name' => 'Ally McPerson', 'qty' => 72 } )
	Aadd( aRows, { 'id' => 'A8', 'name' => 'Bruce Polest' , 'qty' => 13 } )

	DEFINE WEB oWeb TITLE 'Browse - Edit' TABLES INIT
	
	DEFINE FORM o

		HTML o INLINE '<h3>Basic Browse - PreEdit</h3><hr>'

	INIT FORM o 

		DIV o ID 'bar' CLASS 'btn-group'
			BUTTON LABEL ' Edit' 	ICON '<i class="far fa-edit"></i>' 			ACTION 'Edit()' 	CLASS 'btn-secondary mybtnbar' GRID 0 OF o
		ENDDIV o 

		DEFINE BROWSE oBrw ID 'ringo' MULTISELECT CLICKSELECT HEIGHT 400 ;
			EDIT UNIQUEID 'id' TITLE '<i class="fas fa-recycle"></i> My ABM...' PREEDIT 'TestPreEdit' ;
			TOOLBAR "bar" ;
			SEARCH  ;
			OF o

			oBrw:cLocale := 'es-ES'

			ADD oCol TO oBrw ID 'id' 		HEADER 'Id.' 		ALIGN 'center'   
			ADD oCol TO oBrw ID 'name'		HEADER 'Name' 		EDIT TYPE 'V'
			ADD oCol TO oBrw ID 'qty'		HEADER 'Total' 		EDIT TYPE 'N' ALIGN 'right'  WIDTH 100			

		INIT BROWSE oBrw DATA aRows	

		HTML o 
		
			<script>

				var oBrw = new TWebBrowse( 'ringo' )				

				function Edit() 	{ oBrw.Edit() }	

				function TestPreEdit( oItemEdit, oItemBrw ) {
				
					console.log( 'PreEdit oItemEdit', oItemEdit )
					console.log( 'PreEdit oItemBrw', oItemBrw )
					
					var nQty = parseInt( oItemEdit.qty )										
					
					if ( nQty > 100 ) {
					
						MsgInfo( 'Max. 100', 'Check Console'  )
						return false 
						
					} 
					
					return true					
				}				
		
			</script>
		
		ENDTEXT
	
	END FORM o	
	
retu nil