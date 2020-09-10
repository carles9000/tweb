//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o
	
	DEFINE WEB oWeb TITLE 'Tutor1' INIT
	
    DEFINE FORM o ID 'demo'	
		o:lDessign 	:= .T.
		o:lFluid 	:= .T.
		
	INIT FORM o
	
		SAY VALUE 'Hello' ALIGN 'right' OF o
		
    END FORM o	
	
retu nil