//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o

	DEFINE WEB oWeb TITLE 'Get Button' INIT

    DEFINE FORM o		

	INIT FORM o  	

		ROWGROUP o
		
			GET VALUE '123' GRID 12 OF o
		
		ENDROW o	
	   
		ROWGROUP o
		
			GET ID 'myid' 		VALUE '123' GRID 12 LABEL 'Id.' ;				
				BUTTON 'GetId' ACTION 'GetId()' OF o
		
		ENDROW o	

		ROWGROUP o
		
			GET ID 'myid' 		VALUE '123' GRID 12 LABEL 'Id.' ;				
				BUTTON 'GetId', 'Test' ACTION 'GetId()', 'TestBtn()' OF o
		
		ENDROW o	

		ROWGROUP o
		
			GET ID 'myid' 		VALUE '123' GRID 12 LABEL 'Id.' ;				
				BUTTON 'GetId', 'Test', '<i class="fas fa-search"></i>' ;
				ACTION 'GetId()', 'TestBtn()', "MsgInfo(' Search...')" OF o
		
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