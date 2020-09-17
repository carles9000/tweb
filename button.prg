//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o

	DEFINE WEB oWeb TITLE 'Button' INIT

    DEFINE FORM o
	
		HTML o FILE 'templates/title_test.tpl' PARAMS 'Test Buttons'	

	INIT FORM o  
	
		ROWGROUP o
			BUTTON LABEL 'Test 1' GRID 4 ACTION 'alert(123)' OF o        			
		END o
		
		ROWGROUP o
			BUTTON LABEL 'Test 2' GRID 4 CLASS 'btn-outline-danger' ACTION 'Test()' OF o        			
		END o
		
		HTML o
			<script>
			
				function Test() {
				
					alert( 'Hello world' )						
				}			
				
			</script>		
		ENDTEXT	
			
    END FORM o	
	
	
retu nil