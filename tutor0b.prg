//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o
	
	DEFINE WEB oWeb TITLE 'Tutor1' INIT
	
    DEFINE FORM o ID 'demo'	
		o:lDessign 	:= .T.
		o:lFluid 	:= .F.
		
	INIT FORM o  		
		
		ROWGROUP o
			SAY VALUE 'Id:' ALIGN 'right' OF o
			GET VALUE '' OF o
		END o		
		
    END FORM o	
	
retu nil