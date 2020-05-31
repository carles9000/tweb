//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o
	
	DEFINE WEB oWeb TITLE 'Tutor1b - VALID' INIT

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
					$('#total').stop()
				
					if ( uValue >= 100 ) {		
						MsgInfo( 'ep')
						$('#total').focus()
					}
				}
				
				
				
				
			</script>	


			
		ENDTEXT
		
    END FORM o	
	
retu nil