//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    local o, oCol, oBrw
	local aRows 	:= {}
	local hCars 	:= {=>}
	local cLoren 	:= "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
	
	Aadd( aRows, { 'id' => 'A1', 'name' => 'Charly Aubia' , 'dummy' => 'Dum-1' , 'married' => .T., 'car' => 'V', 'qty' => 12, 'date' => '01-01-2020', 'memory' => 'Hola' } )
	Aadd( aRows, { 'id' => 'A2', 'name' => 'Maria de la O', 'dummy' => 'Dum-2' , 'married' => .F., 'car' => 'R', 'qty' =>  7, 'date' => '2020-01-02', 'memory' => cLoren } )
	Aadd( aRows, { 'id' => 'A3', 'name' => 'John Kocinsky', 'dummy' => 'Dum-3' , 'married' => .F., 'car' => 'F', 'qty' => 23, 'date' => '03/01/2020', 'memory' => '' } )	
	Aadd( aRows, { 'id' => 'A4', 'name' => 'Anne Clark'   , 'dummy' => 'Dum-4' , 'married' => .T., 'car' => '' , 'qty' =>100, 'date' => '04/01/2020', 'memory' => 'Test memory' } )	
	Aadd( aRows, { 'id' => 'A5', 'name' => 'Daniel Clark' , 'dummy' => 'Dum-5' , 'married' => .T., 'car' => 'V', 'qty' =>  0, 'date' => '05/01/2020', 'memory' => 'Ep!' } )	
	Aadd( aRows, { 'id' => 'A6', 'name' => 'Rod Steward'  , 'dummy' => 'Dum-6' , 'married' => .F., 'car' => 'F', 'qty' => 98, 'date' => '07/01/2020', 'memory' => 'Baby Jean' } )	
	Aadd( aRows, { 'id' => 'A7', 'name' => 'Ally McPerson', 'dummy' => 'Dum-7' , 'married' => .F., 'car' => 'F', 'qty' => 72, 'date' => '12/01/2020', 'memory' => '' } )	
	Aadd( aRows, { 'id' => 'A8', 'name' => 'Bruce Polest' , 'dummy' => 'Dum-8' , 'married' => .F., 'car' => 'R', 'qty' => 13, 'date' => '23/01/2020', 'memory' => 'Memory...' } )	

	hCars[ ''  ] := '' 
	hCars[ 'V' ] := 'Volvo' 
	hCars[ 'R' ] := 'Renault'	
	hCars[ 'F' ] := 'Ferrari'	
	hCars[ 'S' ] := 'Seat'	
	hCars[ 'T' ] := 'Toyota' 	
	hCars[ 'C' ] := 'Citroen'		

	DEFINE WEB oWeb TITLE 'Browse - Edit' TABLES INIT
	
	DEFINE FORM o

		HTML o INLINE '<h3>Basic Browse</h3><hr>'
		
		HTML o
		
			<style>
			
				.mybtnbar {
					border-radius:0px;
				}			
				
				.myid {
					background-color: lightgray;
					font-weight: bold;
					text-align: center;
					border-left: 2px solid gray !important;
					border-right: 2px solid gray !important;	
					border-top: 0px solid !important;
					border-bottom: 0px solid !important;					
				}
				
				.myrow {
					background-color: #ff000040;
					color: black;
					border: 2px solid #e91e1e;
					font-weight: bold;
				}

				.mycustombar {			
					background-color: lightgray;
					padding: 5px;
					border-bottom: 1px solid black;
					border-right: 1px solid black;
					border-radius:0px;						
				}
				
			</style>
		
		ENDTEXT 
		
	INIT FORM o 

		ROWGROUP o
		
			GET ID 'dummy' LABEL 'Dummy Field' VALUE '' GRID 6 OF o 
		
		ENDROW o

		DIV o ID 'bar' CLASS 'btn-group'
			BUTTON LABEL ' New' 	ICON '<i class="far fa-plus-square"></i>' 	ACTION 'Add()' 		CLASS 'btn-secondary mybtnbar' GRID 0 OF o
			BUTTON LABEL ' Edit' 	ICON '<i class="far fa-edit"></i>' 			ACTION 'Edit()' 	CLASS 'btn-secondary mybtnbar' GRID 0 OF o
			BUTTON LABEL ' Delete' ICON '<i class="far fa-trash-alt"></i>' 	ACTION 'Delete()' 	CLASS 'btn-secondary mybtnbar' GRID 0 OF o
			BUTTON LABEL ' Save' 	ICON '<i class="far fa-save"></i>' 			ACTION 'Save()' 	CLASS 'btn-secondary mybtnbar' GRID 0 OF o
		ENDDIV o 

		DEFINE BROWSE oBrw ID 'ringo' MULTISELECT CLICKSELECT HEIGHT 400 ;
			EDIT UNIQUEID 'id' TITLE '<i class="fas fa-recycle"></i> My ABM...' POSTEDIT 'TestPostEdit' ;
			ROWSTYLE 'MyRowStyle' ;
			DBLCLICK 'MyDblClick' ;
			TOOLBAR "bar" ;
			SEARCH TOOLS EXPORT PRINT  ;
			ONCHANGE 'MyChange' OF o
			
			//oBrw:lDark = .t.
			//oBrw:lStripped := .t.
			oBrw:cLocale := 'es-ES'

			ADD oCol TO oBrw ID 'id' 		HEADER 'Id.' 		ALIGN 'center' FORMATTER 'MyId' CLASS 'MyCssId'   
			ADD oCol TO oBrw ID 'name'		HEADER 'Name' 		EDIT 
			ADD oCol TO oBrw ID 'married'	HEADER 'Married' 	EDIT TYPE 'L' 
			ADD oCol TO oBrw ID 'car'		HEADER 'Car' 		EDIT TYPE 'COMBOBOX' WITH hCars
			ADD oCol TO oBrw ID 'memory'	HEADER 'Memo' 		EDIT TYPE 'M' 
			ADD oCol TO oBrw ID 'qty'		HEADER 'Total' 		EDIT TYPE 'N' ALIGN 'right' FORMATTER 'MyQty' WIDTH 100
			ADD oCol TO oBrw ID 'date'		HEADER 'Date' 		EDIT TYPE 'D' ALIGN 'center' 
			

		INIT BROWSE oBrw DATA aRows	
		
		ROW o	TOP '50px' CLASS 'mycustombar' 
			BUTTON LABEL 'Changes' 			ACTION 'Changes()'  	CLASS 'btn-secondary mybtnbar' GRID 0 OF o			
			BUTTON LABEL 'Reset Changes' 	ACTION 'ResetChanges()' CLASS 'btn-secondary mybtnbar' GRID 0 OF o			
			BUTTON LABEL 'GetRow' 			ACTION 'GetRow()'  		CLASS 'btn-secondary mybtnbar' GRID 0 OF o			
			BUTTON LABEL 'GetAll'			ACTION 'GetAll()'  		CLASS 'btn-secondary mybtnbar' GRID 0 OF o			
			BUTTON LABEL 'Insert My Row'	ACTION 'InsMyRow()'  	CLASS 'btn-secondary mybtnbar' GRID 0 OF o			
		ENDROW o			
		
		HTML o 
		
			<script>

				var oBrw = new TWebBrowse( 'ringo' )				

				function MyChange( e, row, element) {
					console.log( 'MyChange', row )
					$('#dummy').val( row.dummy )
				}	

				function Edit() 	{ oBrw.Edit() }	
				function Add()  	{ oBrw.AddRow() }	
				function Delete() { oBrw.DeleteRow() }
				function Save() 	{ 
					MsgInfo( 'Not yet' )
				}
				
				function Changes() 	{ 
					MsgNotify( 'Check console...');					
					console.log( 'Changes', oBrw.GetDataChanges() );					
				}
				
				function ResetChanges() { 
					oBrw.ResetChanges(); 
					Changes();  
				}

				function GetRow() {
					MsgNotify( 'Check console...');	
					console.log( 'GetRow', oBrw.GetRow() )
				}
				
				function GetAll() {
					MsgNotify( 'Check console...');	
					console.log( 'GetAll', oBrw.GetData() )
				}				
				
				function InsMyRow() {				
				
					var oItem = oBrw.GetItemEmpty()
					
					oItem[ 'name' ] 	= 'Baby Jean'
					oItem[ 'married' ] 	= true
					
					oBrw.AddRow( oItem )
				}

				function MyCssId( value, row, index ) {			
							
					return { classes: 'myid' }
				
					/*
					return {
						  css: {
							'background-color': 'lightgray',
							'font-weight': 'bold'
						  }
						}					
					*/
				}

				function MyDblClick(e,row) {				
				
					console.log("MyDblClik",row)								
				}
				
				function MyId( value ) {									

					if ( typeof value == 'string' && value.substring(0, 1) == '$' ) {						
						return '<i class="far fa-edit"></i>'						
					} else
						return value 
				}
				
				function MyQty( value ) {									

					if ( value > 50 ) 
						return value + ' <img src="images/ball_green.png"</img>' 
					else
						return value + ' <img src="images/ball_red.png"</img>'
			
				}				

				function MyRowStyle(row, index) {
					
					if ( row.car == 'V' )
						return { classes: 'myrow' }	
					else
						return {}			
				}

				function TestPostEdit( rows, lUpdate ) {
					
					if ( lUpdate ) {
						console.log( 'Rows Updated', rows )
						MsgInfo( 'Updated !' )
					}									
				}				
		
			</script>
		
		ENDTEXT

	
	END FORM o	
	
retu nil