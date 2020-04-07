//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o, oCol, oBrw

	LOAD TWEB TABLES
	
	DEFINE FORM o ID 'demo'
		o:lDessign  := .F.		

	INIT FORM o  
	
		ROWGROUP o
		   
			SEPARATOR o LABEL 'Datos de Salida'
			
			DEFINE BROWSE oBrw ID 'ringo' HEIGHT 400 OF o
				//oBrw:cClass = 'table-condensed'
			
				ADD oCol TO oBrw ID 'last' 		HEADER 'Last'   SORT	ALIGN 'right'
				ADD oCol TO oBrw ID 'first'		HEADER 'First'  SORT
				ADD oCol TO oBrw ID 'street' 		HEADER 'Street' 
				ADD oCol TO oBrw ID 'age' 	    HEADER 'Age'    WIDTH 70 ALIGN 'center' FORMATTER 'ageFormatter'	
		END o
		
		HTML o
			<script>
			
				var oWnd
				var oBrw = new TWebBrowse( 'ringo' )

				function LoadState() {
					
					var cState = 'NY'

					oWnd = MsgLoading()                
					
					MsgTask( 'dbfstate', cState, Post_LoadState )
				}
				
				function Post_LoadState( dat ){
					
					oWnd.modal('hide');

					var hValue = dat[ 'value' ]
					var rows   = hValue[ 'rows']
				
					$( '#total' ).val(  hValue[ 'len' ] )
					   
					oBrw.SetData( rows )            
				}
			
				function ageFormatter(value, row) {
						
					if ( row.age > 50 )
						return '<i class="fa fa-star"></i> ' + value
					else
						return '<img src="images/ball_green.png"> ' + value									
				}   
			
				$(document).ready(function () {				
					oBrw.Init()
					LoadState()
				})				
				
			</script>		
		ENDTEXT
	
	END FORM o
	
retu nil