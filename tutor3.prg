//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o, oWeb
	
	DEFINE WEB oWeb TITLE 'Tutor3' INIT
	
    DEFINE FORM o 
		o:lDessign 	:= .T.
		
	INIT FORM o  		
		
		ROWGROUP o 
			SAY VALUE 'Id:' ALIGN 'right' OF o
			GET VALUE '123' OF o
		ENDROW o	

		ROWGROUP o 
			SAY VALUE 'Phone:' ALIGN 'right' OF o
			GET VALUE '' OF o
		ENDROW o		
		
    END FORM o	
	
retu nil