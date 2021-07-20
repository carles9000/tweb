//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o, oWeb

	DEFINE WEB oWeb TITLE 'Test Autocomplete' INIT

    DEFINE FORM o ID 'demo'

    INIT FORM o  		
       
		HTML o INLINE '<h3>Test Get Autocomplete - Server</h3></hr>'
		
        ROWGROUP o        
            
            GET ID 'birds' VALUE '' GRID 6 LABEL 'Source: Server' ;
				AUTOCOMPLETE 'srv_get_auto.prg' SELECT 'MySelect' ;
				PLACEHOLDER 'ex: Charles, Chris, Irene,... ' OF o
        
        ENDROW o	
		
		
		HTML o
			<script>				
				
				function MySelect( event, ui ) {
					
					var cInfo = '<b>Selected: </b>'+ ui.item.value + '<br>'
					
					cInfo += '<b>Street: </b> '		+ ui.item.street + '<br>'
					cInfo += '<b>City: </b>' 		+ ui.item.city + '<br>'
					cInfo += '<b>Zip: </b>' 		+ ui.item.zip + '<br>'					
					
					MsgInfo( cInfo, 'Customer' )
				}
				
			</script>		
		ENDTEXT
		
    END FORM o	
	
retu nil