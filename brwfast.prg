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

				.mycustombar {			
					background-color: lightgray;
					padding: 5px;
					border-bottom: 1px solid black;
					border-right: 1px solid black;				
				}				
				
			</style>
		
		ENDTEXT 
		
	INIT FORM o 

		DIV o ID 'bar' CLASS 'btn-group'
			BUTTON LABEL ' New' 	ICON '<i class="far fa-plus-square"></i>' 		ACTION 'oBrw.AddRow()' 	CLASS 'btn-secondary mybtnbar' GRID 0 OF o
			BUTTON LABEL ' Edit' 	ICON '<i class="far fa-edit"></i>' 				ACTION 'oBrw.Edit()' 	CLASS 'btn-secondary mybtnbar' GRID 0 OF o
			BUTTON LABEL ' Delete' 	ICON '<i class="far fa-trash-alt"></i>' 		ACTION 'MyDelete()' 	CLASS 'btn-secondary mybtnbar' GRID 0 OF o
		END o 

		DEFINE BROWSE oBrw ID 'ringo' MULTISELECT CLICKSELECT HEIGHT 400 ;
			EDIT UNIQUEID '_recno' TITLE '<i class="fas fa-recycle"></i> My ABM...' POSTEDIT 'MySave' ;
			ROWSTYLE 'MyRowStyle' ;
			TOOLBAR "bar" ;
			SEARCH TOOLS EXPORT PRINT  ;
			ONCHANGE 'MyChange' OF o
			
			oBrw:lDark = .t.
			oBrw:lStripped := .t.			
			oBrw:lVirtualScroll := .t.

			ADD oCol TO oBrw ID '_recno'	HEADER 'Recno' 		ALIGN 'center' SORT WIDTH 80 
			ADD oCol TO oBrw ID 'first'	    HEADER 'First' 		EDIT SORT
			ADD oCol TO oBrw ID 'last'		HEADER 'Last' 		EDIT SORT
			ADD oCol TO oBrw ID 'street'	HEADER 'Street'		EDIT 
			ADD oCol TO oBrw ID 'married'	HEADER 'Married'	EDIT TYPE "L"
			ADD oCol TO oBrw ID 'hiredate'	HEADER 'Hiredate'	EDIT TYPE 'D'
			ADD oCol TO oBrw ID 'age'		HEADER 'Age'		EDIT 							

		INIT BROWSE oBrw // DATA aRows	
		
		ROW o 	TOP '50px' CLASS 'mycustombar' 
			BUTTON LABEL 'Load Data' 	ACTION 'Load()' 	CLASS 'btn btn-secondary mybtnbar' GRID 0 OF o
			BUTTON LABEL 'Reset' 		ACTION 'Reset()'  	CLASS "btn btn-secondary mybtnbar" GRID 0  OF o			
		END o			
		
		HTML o 
		
			<script>

				var oBrw = new TWebBrowse( 'ringo' )

				//	Load Data...	------------------------------------------
					
				function Load() {						
					
					oBrw.Loading( true )					

					var oParam = new Object()
						oParam[ 'action' ] = 'load'
					
					MsgServer( 'srv_brw_data.prg', oParam, Post_Load )
				}
				
				function Post_Load( dat ){

					oBrw.Loading( false )				

					oBrw.SetData( dat.rows ) 						
				}
				
				//	Others...	---------------------------------------------

				function Reset() 	{ oBrw.Reset() }

				function MySave( rows, lUpdate ) {					

					var oParam = new Object()
						oParam[ 'action' ] = 'update'
						oParam[ 'data'   ] = oBrw.GetDataChanges()			
					
					MsgServer( 'srv_brwinline.prg', oParam, Post_Update )		
				}
				
				function MyDelete() {
					
					oBrw.DeleteRow()
					
					var oParam = new Object()
						oParam[ 'action' ] = 'update'
						oParam[ 'data'   ] = oBrw.GetDataChanges()			
					
					MsgServer( 'srv_brwinline.prg', oParam, Post_Update )		
				}				
				
				function Post_Update( dat ) {
				
					console.log( dat )
					
					if ( dat.updated.length > 0 ) {
					
						MsgNotify( 'Server updated !' );
						oBrw.ResetChanges( dat.updated )
					} else if ( dat.errortxt ) {
						MsgError( dat.errortxt, 'Error actualizando' ) 
					}
				}
				
			</script>
		
		ENDTEXT

	
	END FORM o	
	
retu nil