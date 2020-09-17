//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o
	
	DEFINE WEB oWeb TITLE 'Test Say' INIT	
	
    DEFINE FORM o 
		o:lDessign 	:= .T.			
		
	INIT FORM o

		SAY VALUE 'Hello World' GRID 6 ALIGN 'right'  OF o
		
    END FORM o	
	
retu nil