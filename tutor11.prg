//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o

	DEFINE WEB oWeb TITLE 'Get' INIT

    DEFINE FORM o		

	INIT FORM o  		
	   
		ROWGROUP o
		
			GET ID 'myid' 		VALUE '123' GRID 4 LABEL 'Id.' ;
				PLACEHOLDER 'User Id.' ;
				BUTTON 'GetId' ACTION 'GetId()' OF o
		
		ENDROW o		
		
		ROWGROUP o
			BUTTON ID 'mybtn'	LABEL 'Test' GRID 4 ACTION 'TestBtn()' OF o        
		ENDROW o		
		
		HTML o
			<script>
			
				function GetId() {
				
					var cId = $('#myid').val() 
				
					MsgInfo( cId )
				}
				
				function TestBtn() {
				
					alert( 'Button...' )
				}				
				
			</script>		
		ENDTEXT
		
    END FORM o	
	
retu nil