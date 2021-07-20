//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o

	DEFINE WEB oWeb TITLE 'MsgInfo()' INIT

    DEFINE FORM o
	
		HTML o FILE 'templates/title_test.tpl' PARAMS 'Test MsgInfo()'	

	INIT FORM o  
	
		ROWGROUP o
			SAY VALUE "MsgGet( cVar ) -> Error" GRID 6 ALIGN 'right' OF o
			BUTTON LABEL 'Test' GRID 4 ACTION "Test0()"  OF o        			
		ENDROW o	
	
		ROWGROUP o
			SAY VALUE "MsgGet( cVar, fCallback )" GRID 6 ALIGN 'right' OF o
			BUTTON LABEL 'Test' GRID 4 ACTION "Test1()"  OF o        			
		ENDROW o
		
		ROWGROUP o
			SAY VALUE "MsgGet( cMsg, fCallback, cTitle )" GRID 6 ALIGN 'right' OF o
			BUTTON LABEL 'Test' GRID 4 ACTION "Test2()"  OF o        			
		ENDROW o	

		ROWGROUP o
			SAY VALUE "MsgInfo( cMsg, fCallback, cTitle, Icon )" GRID 6 ALIGN 'right' OF o
			BUTTON LABEL 'Test' GRID 4 ACTION "Test3()"  OF o        			
		ENDROW o	
		
		HTML o
			<script>
			
				function Test0() {
				
					//	Error. No callback defined
					
					MsgGet( 'James Bond' )	

				}			
			
				function Test1() {
				
					MsgGet( 'James Bond', MyFunc )	

				}
			
				function Test2() {
				
					MsgGet( 'James Bond', MyFunc, 'My Card' )					
				}			
			
				function Test3() {
				
					MsgGet( 'James Bond', MyFunc, 'My Card', '<i class="far fa-address-card"></i>' )					
				}		


				function MyFunc( u ) {
				
					MsgInfo( u )
				}

				
				
			</script>		
		ENDTEXT	
			
    END FORM o	
	
	
retu nil