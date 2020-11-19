//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    local o, oCol, oBrw
	local aRows 	:= {}
	local hCars 	:= {=>}
	local cLoren 	:= "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
	
	Aadd( aRows, { 'id' => 'A1', 'name' => 'Charly Aubia' , 'dummy' => 'Dum-1' , 'married' => .T., 'car' => 'V', 'qty' => 12, 'date' => '01-01-2020', 'memory' => 'Hola' } )
	Aadd( aRows, { 'id' => 'A2', 'name' => 'Maria de la O', 'dummy' => 'Dum-2' , 'married' => .F., 'car' => 'R', 'qty' =>  7, 'date' => '2020-01-02',  'memory' => cLoren } )
	Aadd( aRows, { 'id' => 'A3', 'name' => 'John Kocinsky', 'dummy' => 'Dum-3' , 'married' => .F., 'car' => 'F', 'qty' => 23, 'date' => '03/01/2020',  'memory' => '' } )	
	Aadd( aRows, { 'id' => 'A4', 'name' => 'Anne Clark'   , 'dummy' => 'Dum-4' , 'married' => .T., 'car' => '' , 'qty' =>100, 'date' => '04/01/2020',  'memory' => 'Test memory' } )	
	Aadd( aRows, { 'id' => 'A5', 'name' => 'Daniel Clark' , 'dummy' => 'Dum-5' , 'married' => .T., 'car' => 'V', 'qty' =>  0, 'date' => '05/01/2020',  'memory' => 'Epp!' } )	
	Aadd( aRows, { 'id' => 'A6', 'name' => 'Rod Steward'  , 'dummy' => 'Dum-6' , 'married' => .F., 'car' => 'F', 'qty' => 98, 'date' => '07/01/2020',  'memory' => 'Baby Jean' } )	

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
				}
				
/*				
textarea:focus,
input[type="text"]:focus,
input[type="password"]:focus,
input[type="datetime"]:focus,
input[type="datetime-local"]:focus,
input[type="date"]:focus,
input[type="month"]:focus,
input[type="time"]:focus,
input[type="week"]:focus,
input[type="number"]:focus,
input[type="email"]:focus,
input[type="url"]:focus,
input[type="search"]:focus,
input[type="tel"]:focus,
input[type="color"]:focus,
.uneditable-input:focus {   
  border-color: rgba(126, 239, 104, 0.8);
  box-shadow: 0 1px 1px rgba(0, 0, 0, 0.075) inset, 0 0 8px rgba(126, 239, 104, 0.6);
  outline: 0 none;
}
*/	
/*
.form-control:focus {
  border-color: #FF0000;
  box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075), 0 0 8px rgba(255, 0, 0, 0.6);
}	
*/
.form-control:focus {
    border-color: #28a745;
    box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.25);
} 

@media screen and (-webkit-min-device-pixel-ratio: 0)
select:focus, textarea:focus, input:focus {
    font-size: auto;
}				
				
			</style>
		
		ENDTEXT 
		
	INIT FORM o  

		DIV o ID 'bar' CLASS 'btn-group'
			BUTTON LABEL ' New' 	ICON '<i class="far fa-plus-square"></i>' 	ACTION 'Add()' 		CLASS 'btn-secondary mybtnbar' GRID 0 OF o
			BUTTON LABEL ' Edit' 	ICON '<i class="far fa-edit"></i>' 			ACTION 'Edit()' 	CLASS 'btn-secondary mybtnbar' GRID 0 OF o
			BUTTON LABEL ' Delete' 	ICON '<i class="far fa-trash-alt"></i>' 	ACTION 'Delete()' 	CLASS 'btn-secondary mybtnbar' GRID 0 OF o
			BUTTON LABEL ' Save' 	ICON '<i class="far fa-save"></i>' 			ACTION 'Save()' 	CLASS 'btn-secondary mybtnbar' GRID 0 OF o
		END o 

		DEFINE BROWSE oBrw ID 'ringo' MULTISELECT CLICKSELECT HEIGHT 400 ;
			EDIT TITLE '<i class="fas fa-recycle"></i> My ABM...' POSTEDIT 'TestPostEdit' ;
			ROWSTYLE 'MyRowStyle' ;
			TOOLBAR "bar" ;
			SEARCH TOOLS EXPORT PRINT  ;
			ONCHANGE 'MyChange' OF o
			
			//oBrw:lDark = .t.
			//oBrw:lStripped := .t.
			oBrw:cLocale := 'es-ES'

			ADD oCol TO oBrw ID 'id' 		HEADER 'Id.' 		EDIT ALIGN 'center' FORMATTER 'MyId' CLASS 'MyCssId'   
			ADD oCol TO oBrw ID 'name'		HEADER 'Name' 		EDIT 
			ADD oCol TO oBrw ID 'married'	HEADER 'Married' 	EDIT TYPE 'L' 
			ADD oCol TO oBrw ID 'car'		HEADER 'Car' 		EDIT TYPE 'COMBOBOX' WITH hCars
			ADD oCol TO oBrw ID 'memory'	HEADER 'Memo' 		EDIT TYPE 'M' 
			ADD oCol TO oBrw ID 'qty'		HEADER 'Total' 		EDIT TYPE 'N' ALIGN 'right' 
			ADD oCol TO oBrw ID 'date'		HEADER 'Date' 		EDIT TYPE 'D' ALIGN 'center' 

		INIT BROWSE oBrw DATA aRows	
		
		ROW o 	TOP '50px' CLASS 'mycustombar' 
			BUTTON LABEL 'Changes' ACTION 'Changes()'  OF o			
			BUTTON LABEL 'Reset Changes' ACTION 'ResetChanges()'  OF o			
		END o			
		
		HTML o 
		
			<script>

				var oBrw = new TWebBrowse( 'ringo' )
					//oBrw.lEdit 	= true
					//oBrw.bClick = 'MyChange2'
					//oBrw.bPostEdit = 'TestPostEdit'
					

				function MyChange( e, row, element) {
					console.log( 'MyChange', row )
				}	

				function Edit() 	{ oBrw.Edit() }	
				function Add()  	{ oBrw.AddRow() }	
				function Delete() 	{ oBrw.DeleteRow() }
				
				function Changes() 	{ 
					MsgNotify( 'Check console...');					
					console.log( 'Changes', oBrw.GetDataChanges() );
				}
				
				function ResetChanges() { 
					oBrw.ResetChanges(); 
					Changes();  
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

				function MyId( value ) {									
				
					if ( value.substring(0, 1) == '$' )
						return '<i class="far fa-plus-square"></i>'
					else
						return value 
				}

				function MyRowStyle(row, index) {
					
					if ( row.qty > 90 )
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