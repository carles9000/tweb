//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    local o, oCol, oBrw

	DEFINE WEB oWeb TITLE 'CRUD Browse - Edit Dbf' TABLES INIT
	
	DEFINE FORM o

		HTML o INLINE '<h3>CRUD Browse</h3><hr>'
		
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
				}				
				
			</style>
		
		ENDTEXT 
		
	INIT FORM o 

		ROWGROUP o
		
			BUTTON LABEL ' Load Data' ICON '<i class="far fa-save"></i>' ACTION 'Load()' CLASS 'btn-secondary mybtnbar' GRID 12 OF o
		
		END o

		DIV o ID 'bar' CLASS 'btn-group'
			BUTTON LABEL ' New' 	ICON '<i class="far fa-plus-square"></i>' 		ACTION 'Add()' 			CLASS 'btn-secondary mybtnbar' GRID 0 OF o
			BUTTON LABEL ' Edit' 	ICON '<i class="far fa-edit"></i>' 				ACTION 'Edit()' 		CLASS 'btn-secondary mybtnbar' GRID 0 OF o
			BUTTON LABEL ' Delete' 	ICON '<i class="far fa-trash-alt"></i>' 		ACTION 'Delete()' 		CLASS 'btn-secondary mybtnbar' GRID 0 OF o
			BUTTON LABEL ' Save' 	ICON '<i class="far fa-save"></i>' 				ACTION 'Save()' 		CLASS 'btn-secondary mybtnbar' GRID 0 OF o
		END o 

		DEFINE BROWSE oBrw ID 'ringo' MULTISELECT CLICKSELECT HEIGHT 400 ;
			EDIT UNIQUEID '_recno' TITLE '<i class="fas fa-recycle"></i> My ABM...' POSTEDIT 'TestPostEdit' ;
			ROWSTYLE 'MyRowStyle' ;
			TOOLBAR "bar" ;
			SEARCH TOOLS EXPORT PRINT  ;
			ONCHANGE 'MyChange' OF o
			
			//oBrw:lDark = .t.
			//oBrw:lStripped := .t.
			oBrw:lVirtualScroll := .t.
			oBrw:cLocale := 'es-ES'

			ADD oCol TO oBrw ID '_recno'	HEADER 'Recno' 		ALIGN 'center' SORT WIDTH 80 FORMATTER 'MyId' CLASS 'MyCssId'   			
			ADD oCol TO oBrw ID 'first'	    HEADER 'First' 		EDIT SORT
			ADD oCol TO oBrw ID 'last'		HEADER 'Last' 		EDIT SORT
			ADD oCol TO oBrw ID 'street'	HEADER 'Street'		EDIT 
			ADD oCol TO oBrw ID 'married'	HEADER 'Married'	EDIT TYPE "L"
			ADD oCol TO oBrw ID 'hiredate'	HEADER 'Hiredate'	EDIT TYPE 'D'
			ADD oCol TO oBrw ID 'age'		HEADER 'Age'		EDIT 
			ADD oCol TO oBrw ID 'notes'		HEADER 'Notes'		EDIT ESCAPE 				

		INIT BROWSE oBrw // DATA aRows	
		
		ROW o 	TOP '50px' CLASS 'mycustombar' 
			BUTTON LABEL 'Changes' 			ACTION 'Changes()'  	GRID 0 CLASS "btn btn-secondary mybtnbar" OF o			
			BUTTON LABEL 'Reset Changes' 	ACTION 'ResetChanges()' GRID 0 CLASS "btn btn-secondary mybtnbar" OF o			
			BUTTON LABEL 'GetRow' 			ACTION 'GetRow()'  		GRID 0 CLASS "btn btn-secondary mybtnbar" OF o			
			BUTTON LABEL 'Insert My Row' 	ACTION 'InsMyRow()'  	GRID 0 CLASS "btn btn-secondary mybtnbar" OF o			
			BUTTON LABEL 'Reset' 			ACTION 'Reset()'  		GRID 0 CLASS "btn btn-secondary mybtnbar" OF o			
		END o			
		
		HTML o 
		
			<script>

				var oBrw = new TWebBrowse( 'ringo' )				
					
				function Load() {						
					
					oBrw.Loading( true )					

					var oParam = new Object()
						oParam[ 'action' ] = 'load'
					
					MsgServer( 'srv_brw_data.prg', oParam, Post_Load )
				}
				
				function Post_Load( dat ){
				
					console.log( dat )
			
					oBrw.Loading( false )				

					oBrw.SetData( dat.rows ) 						
				}

				function Save() 	{ 
				
					var oParam = new Object()
						oParam[ 'action' ] = 'save'
						oParam[ 'data'   ] = oBrw.GetDataChanges()
				
					
					console.log( 'SAVE', oParam )
					MsgServer( 'srv_brw_data.prg', oParam, Post_Save )				
				}				
				
				function Post_Save( dat ) {
				
					console.log( dat )
					
					var cTxt = '<b>Rows updated:</b> ' + dat.updated + '<br>'						
					
					if ( dat.error.length > 0 ) {
				
						cTxt += '<b><u>Error</u></b> ' + '<br>'
						cTxt += dat.errortxt + '<br>'					

					} else {
						console.log( 'UPDATED ROWS', dat.rows_updated )
						oBrw.ResetChanges( dat.rows_updated )						
					}
					
					MsgInfo( cTxt )
					
				}
				

				function MyChange( e, row, element) {
					console.log( 'MyChange', row )
					$('#dummy').val( row.dummy )
				}	

				function Edit() 	{ oBrw.Edit() }	
				function Add()  	{ oBrw.AddRow() }	
				function Delete() 	{ oBrw.DeleteRow() }
				function Reset() 	{ oBrw.Reset() }

				
				function Changes() 	{ 
					MsgNotify( 'Check console...');					
					console.table( oBrw.GetDataChanges() );
				}
				
				function ResetChanges() { 
					oBrw.ResetChanges(); 
					Changes();  
				}

				function GetRow() {
					MsgNotify( 'Check console...');	
					console.log( 'GetRow', oBrw.GetRow() )
				}
				
				function InsMyRow() {				
				
					var oItem = oBrw.GetItemEmpty()
					
					oItem[ 'first' ] 	= 'Baby Jean ' 
					oItem[ 'age' ] 		= Math.floor(Math.random() * 99) + 1  
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

				function MyId( value ) {													
					
					if ( typeof value == 'string' && value.substring(0, 1) == '$' ) {
						return '<i class="far fa-edit"></i>'
						//return '<img src="images/ " />'
					} else
						return value 
				}

				function MyRowStyle(row, index) {
					
					if ( row.age > 80 )
						return { classes: 'myrow' }	
					else
						return {}			
				}

				function TestPostEdit( rows, lUpdate ) {
					
					if ( lUpdate ) {
						console.log( 'Rows Updated', rows )
						MsgNotify( 'Row modified, but not saved !' )
					}									
				}
		
			</script>
		
		ENDTEXT

	
	END FORM o	
	
retu nil