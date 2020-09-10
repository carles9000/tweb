//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o

	DEFINE WEB oWeb TITLE 'Tutor2c' INIT

    DEFINE FORM o 

		INIT FORM o  		
		   
			ROWGROUP o ALIGN 'bottom'
			
				GET ID 'myid' 		VALUE '123' GRID 4 LABEL 'Id.' PLACEHOLDER '123 for test...' BUTTON 'Search' ACTION 'GetId()' OF o
				GET ID 'myphone'	VALUE '' 	GRID 4 READONLY OF o
			
			END o		
			
			HTML o
				<script>
				
					function GetId() {
					
						var cId = $('#myid').val() 
						
						$( '#myphone' ).val( '' )
						
						var oParam = new Object()
							oParam[ 'myid'    ] = $('#myid').val()
							
							MsgServer( 'tutor2c_srv.prg', oParam, PostGetId )																			
					}
					
					function PostGetId( dat ) {
					
						console.log( dat )

						if ( dat.success ) 
							$( '#myphone' ).val( dat.phone )
						else
							MsgError( dat.error, 'Response from Server' )
					}				
					
				</script>		
			ENDTEXT
		
    END FORM o	
	
retu nil