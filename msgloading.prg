//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o, oWeb

	DEFINE WEB oWeb TITLE 'MsgLoading' INIT

    DEFINE FORM o
	
		HTML o FILE 'templates/title_test.tpl' PARAMS 'Test MsgLoading'	

	INIT FORM o  
	
		ROWGROUP o
			BUTTON LABEL 'MsgLoading()' GRID 4 ACTION 'MsgLoading()' OF o        			
		ENDROW o
		
		
		ROWGROUP o
			BUTTON LABEL 'MsgLoading() with Title' GRID 4 ACTION "MsgLoading( 'Process...', 'App', null , true )" OF o        			
		ENDROW o
					
			
    END FORM o	
	
retu nil