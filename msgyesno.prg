//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o

	DEFINE WEB oWeb TITLE 'MsgYesNo()' INIT

    DEFINE FORM o
	
		HTML o FILE 'templates/title_test.tpl' PARAMS 'Test MsgYesNo()'	

	INIT FORM o  
	
		ROWGROUP o
			SAY VALUE "MsgYesNo( cMsg )" GRID 6 ALIGN 'right' OF o
			BUTTON LABEL 'Test' GRID 4 ACTION "MsgYesNo( 'Confirm ?', null, null, MyFunc )"  OF o        			
		END o
		
		ROWGROUP o
			SAY VALUE "MsgYesNo( cMsg, cTitle )" GRID 6 ALIGN 'right' OF o
			BUTTON LABEL 'Test' GRID 4 ACTION "Test2()"  OF o        			
		END o	

		ROWGROUP o
			SAY VALUE "MsgYesNo( cMsg, cTitle, Icon )" GRID 6 ALIGN 'right' OF o
			BUTTON LABEL 'Test' GRID 4 ACTION "Test3()"  OF o        			
		END o	

		ROWGROUP o
			SAY VALUE "MsgYesNo( cMsg, cTitle, Icon, cFunc )" GRID 6 ALIGN 'right' OF o
			BUTTON LABEL 'Test' GRID 4 ACTION "Test4()"  OF o        			
		END o		

		
		HTML o
			<script>
			
				function Test2() {
				
					MsgYesNo( 'Confirm ?', 'Erase all data', null, MyFunc )					
				}			
			
				function Test3() {
				
					MsgYesNo( 'Confirm ?', 'Erase all data', '<i class="far fa-trash-alt"></i>', MyFunc )					
				}		

				function Test4() {
				
					MsgYesNo( 'Confirm ?', 'Erase all data', '<i class="far fa-trash-alt"></i>', MyFunc )					
				}	

				function MyFunc( lYesNo ) {
				
					alert( lYesNo )
				}				
				
			</script>		
		ENDTEXT	
			
    END FORM o	
	
	
retu nil