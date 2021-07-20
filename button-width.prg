//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o

	DEFINE WEB oWeb TITLE 'Button' INIT

    DEFINE FORM o
		o:lDessign := .t.
	
		HTML o FILE 'templates/title_test.tpl' PARAMS 'Test Buttons - Width'	

	INIT FORM o  
	
		ROWGROUP o
			BUTTON LABEL 'MyButton' GRID 6 OF o        			
		ENDROW o
		
		ROWGROUP o
			BUTTON LABEL 'MyButton 100% grid' GRID 6 WIDTH '100%' OF o        			
		ENDROW o
		
		ROWGROUP o
			BUTTON LABEL 'MyButton 200px' GRID 6 WIDTH '200px' OF o        			
		ENDROW o		
			
    END FORM o		
	
retu nil