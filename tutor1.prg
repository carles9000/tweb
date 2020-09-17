//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o
	
	DEFINE WEB oWeb TITLE 'Tutor1' INIT
	
    DEFINE FORM o 
		o:lDessign 	:= .T.
		o:lFluid 	:= .T.
		
	INIT FORM o
	
		ROW o
			SAY VALUE 'Hello' ALIGN 'right' OF o
		END o
		
    END FORM o	
	
retu nil