//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o

	DEFINE WEB oWeb TITLE 'MsgError()' INIT

    DEFINE FORM o
	
		HTML o FILE 'templates/title_test.tpl' PARAMS 'Test MsgError()'	

	INIT FORM o  
	
		ROWGROUP o
			SAY VALUE "MsgError( cMsg )" GRID 6 ALIGN 'right' OF o
			BUTTON LABEL 'Test' GRID 4 ACTION "MsgError( 'Data not found !' )"  OF o        			
		ENDROW o
		
		ROWGROUP o
			SAY VALUE "MsgError( cMsg, cTitle )" GRID 6 ALIGN 'right' OF o
			BUTTON LABEL 'Test' GRID 4 ACTION "Test2()"  OF o        			
		ENDROW o	

		ROWGROUP o
			SAY VALUE "MsgError( cMsg, cTitle, Icon )" GRID 6 ALIGN 'right' OF o
			BUTTON LABEL 'Test' GRID 4 ACTION "Test3()"  OF o        			
		ENDROW o	

		ROWGROUP o
			SAY VALUE "MsgError( cMsg, cTitle, Icon, cFunc )" GRID 6 ALIGN 'right' OF o
			BUTTON LABEL 'Test' GRID 4 ACTION "Test4()"  OF o        			
		ENDROW o		

		
		HTML o
			<script>
			
				function Test2() {
				
					MsgError( 'Data not found !', 'Error' )					
				}			
			
				function Test3() {
				
					MsgError( 'Data not found !', 'Error', '<i class="fas fa-bomb"></i>' )					
				}		

				function Test4() {
				
					MsgError( 'Data not found !', 'Error', '<i class="fas fa-bomb"></i>', MyFunc )					
				}	

				function MyFunc() {
				
					alert( 'Execute function MyFunc()' )
				}

				
				
			</script>		
		ENDTEXT	
			
    END FORM o	
	
	
retu nil