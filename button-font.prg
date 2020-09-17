//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o

	DEFINE WEB oWeb TITLE 'Button Font' INIT

    DEFINE FORM o

		DEFINE FONT oFont NAME 'MyFont' COLOR 'green' ITALIC BOLD SIZE 20 OF o

	INIT FORM o  	
		
		BUTTON ID 'mybtn'	LABEL 'Test' GRID 4 FONT 'MyFont' CLASS 'btn-outline-danger' OF o        			
		
    END FORM o	
	
retu nil