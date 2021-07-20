//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o
	
	DEFINE WEB oWeb TITLE 'Test Switch' INIT	
	
    DEFINE FORM o 
			
		
	INIT FORM o

		ROW o TOP '40%'
			SWITCH ID 'myswitch' VALUE .F. LABEL 'Accept' ONCHANGE 'Test()'OF o
		ENDROW o 
		
	
	HTML o 
	
		<script>
		
			function Test() {

				console.log( $('#myswitch').prop( "checked" ) )
				console.log( $('#myswitch').is( ":checked" ) )
				
				var lChecked = $('#myswitch').is( ":checked" ) ? 'Accepted' : 'NO Accepted';
				
				MsgInfo( lChecked )			
			}		
		
		</script>	
	
	ENDTEXT
	
    END FORM o	
retu nil