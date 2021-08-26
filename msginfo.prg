//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o

	DEFINE WEB oWeb TITLE 'MsgInfo()' INIT

    DEFINE FORM o
	
		HTML o FILE 'templates/title_test.tpl' PARAMS 'Test MsgInfo()'	

	INIT FORM o  
	
		ROWGROUP o
			SAY VALUE "MsgInfo( cMsg )" GRID 6 ALIGN 'right' OF o
			BUTTON LABEL 'Test' GRID 4 ACTION "MsgInfo( 'Hello World' )"  OF o        			
		ENDROW o
		
		ROWGROUP o
			SAY VALUE "MsgInfo( cMsg, cTitle )" GRID 6 ALIGN 'right' OF o
			BUTTON LABEL 'Test' GRID 4 ACTION "Test2()"  OF o        			
		ENDROW o	

		ROWGROUP o
			SAY VALUE "MsgInfo( cMsg, cTitle, Icon )" GRID 6 ALIGN 'right' OF o
			BUTTON LABEL 'Test' GRID 4 ACTION "Test3()"  OF o        			
		ENDROW o	

		ROWGROUP o
			SAY VALUE "MsgInfo( cMsg, cTitle, Icon, cFunc )" GRID 6 ALIGN 'right' OF o
			BUTTON LABEL 'Test' GRID 4 ACTION "Test4()"  OF o        			
		ENDROW o		

		
		HTML o
			<script>
			
				function Test2() {
				
					MsgInfo( 'Hello World', 'My Card' )					
				}			
			
				function Test3() {
				
					MsgInfo( 'Hello World', 'My Card', '<i class="far fa-address-card"></i>' )					
				}		

				function Test4() {
				
					MsgInfo( 'Hello World', 'My Card', '<i class="far fa-address-card"></i>', MyFunc )					
				}	

				function MyFunc() {
				
					alert( 'Execute function MyFunc()' )
				}

				/*
	 //$('#myModal').modal({
	 $('.modal-content').modal({
		backdrop: false,
		show: true
	});
	*/
				
				/*
				  $('.modal-dialog').draggable({
					handle: ".modal-header"
					});
					*/
				
				
			</script>		
		ENDTEXT	
			
    END FORM o	
	
	
retu nil