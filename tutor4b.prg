//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o, oCol, oBrw
	LOCAL cHtml := ''
	LOcAL oWeb
	
	
	DEFINE WEB oWeb TITLE 'Test Browse' TABLES INIT
	
	DEFINE FORM o ID 'demo'

		HTML o INLINE cHtml
		HTML o INLINE '<h3>Test Browse II</h3><hr>'
		
	INIT FORM o  			
		
		ROWGROUP o
		
			SEPARATOR o LABEL 'Customers - States'
		
			SELECT oSelect  ID 'state' LABEL 'States' PROMPT '', 'NY', 'IL', 'WY', 'NE', 'NK', 'MT'  GRID 6  ONCHANGE 'LoadState()' OF o		
			
		END o 
		
		ROWGROUP o		   			
			
			DEFINE BROWSE oBrw ID 'ringo' HEIGHT 400 OF o
			
                    ADD oCol TO oBrw ID 'last' 		HEADER 'Last'   ALIGN 'right'
            		ADD oCol TO oBrw ID 'first'		HEADER 'First'  SORT
            		ADD oCol TO oBrw ID 'street' 		HEADER 'Street' SORT
            		ADD oCol TO oBrw ID 'age' 	    HEADER 'Age'    WIDTH 70 ALIGN 'center' FORMATTER 'ageFormatter'	   
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
				
				function ageFormatter(value, row) {
						
					if ( row.age > 50 )
						return '<i class="fa fa-star"></i> ' + value
					else
						return '<img src="images/ball_green.png"> ' + value									
				}				

				$(document).ready(function () {				
					oBrw.Init()					
				})				
				
			</script>		
		ENDTEXT
	
	END FORM o
	
retu nil