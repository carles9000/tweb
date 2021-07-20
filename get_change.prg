//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o
	
	DEFINE WEB oWeb TITLE 'Get Change' INIT
	
    DEFINE FORM o 		

    INIT FORM o  		
       
        ROWGROUP o
        
            GET ID 'myid' VALUE '' GRID 6 LABEL 'Id.' ONCHANGE 'MyValid()' OF o
        
        ENDROW o		
		
		HTML o
			<script>
			
				function MyValid() {
				
					var cId = $('#myid').val() 
				
					MsgInfo( cId, 'Value' )
				}
				
			</script>		
		ENDTEXT
		
    END FORM o	

	
retu nil