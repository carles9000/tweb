//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o
	
	DEFINE WEB oWeb TITLE 'GET - ONCHANGE/VALID' INIT

    DEFINE FORM o ID 'demo'	

    INIT FORM o  		
       
        ROWGROUP o
        
            GET ID 'total' VALUE '' GRID 6 LABEL 'Total' VALID 'Test(this)' PLACEHOLDER "Value < 100" OF o		
            GET ID 'id'    VALUE '' GRID 6 LABEL 'Id.'   OF o		
        
        END o		
		
		HTML o
			<script>
			
				function Test() {
				
					console.log( 'test' )
					var uValue = $('#total').val() 
					
				
					if ( uValue >= 100 ) {		
						MsgInfo( uValue, 'Value', null, function() { $('#total').focus()  }  )						
					}
				}
				
				
				
				
			</script>	


			
		ENDTEXT
		
    END FORM o	
	
retu nil