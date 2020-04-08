//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o, oCol, oBrw

	DEFINE WEB oWeb TITLE 'Test Browse' 
		oWeb:lTables := .T.
	INIT WEB oWeb
	
	DEFINE FORM o ID 'demo'

		HTML o INLINE '<h3>Test Browse</h3><hr>'
		
	INIT FORM o  			
		
		ROWGROUP o
		
			SEPARATOR o LABEL 'Customers - States'
		
			SELECT oSelect  ID 'state' LABEL 'States' PROMPT '', 'NY', 'IL', 'WY', 'NE', 'NK', 'MT'  GRID 6  ONCHANGE 'LoadState()' OF o		
			
		END o 
		
		ROWGROUP o		   			
			
			DEFINE BROWSE oBrw ID 'ringo' HEIGHT 400 OF o
			
				ADD oCol TO oBrw ID 'last' 		HEADER 'Last'   
				ADD oCol TO oBrw ID 'first'		HEADER 'First'  
				ADD oCol TO oBrw ID 'street' 		HEADER 'Street' 
				ADD oCol TO oBrw ID 'age' 	    HEADER 'Age'    
		END o
		
		HTML o
			<script>
			
				var oWnd
				var oBrw = new TWebBrowse( 'ringo' )

				function LoadState() {
					
					oWnd = MsgLoading()                
					
					var cState = $('#state').val()					
					
					MsgServer( 'tutor4-server.prg', cState, Post_LoadState )
				}
				
				function Post_LoadState( dat ){
			
					oWnd.modal('hide');									
					
					oBrw.SetData( dat.rows ) 			
				}

				$(document).ready(function () {				
					oBrw.Init()					
				})				
				
			</script>		
		ENDTEXT
	
	END FORM o
	
retu nil