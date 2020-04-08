//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o
	
	DEFINE WEB oWeb TITLE 'Tutor1' INIT

    DEFINE FORM o ID 'demo'	

    INIT FORM o  		
       
        ROWGROUP o
        
            GET ID 'myid' VALUE '' GRID 6 LABEL 'Id.' PLACEHOLDER 'User Id.' BUTTON 'GetId' ACTION 'GetId()' OF o
        
        END o		
		
		HTML o
			<script>
			
				function GetId() {
				
					var cId = $('#myid').val() 
				
					MsgInfo( cId )
				}
				
			</script>		
		ENDTEXT
		
    END FORM o	
	
retu nil