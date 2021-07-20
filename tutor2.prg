//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o
	
	DEFINE WEB oWeb TITLE 'Tutor2' INIT
	
    DEFINE FORM o 
		o:lDessign 	:= .T.
		o:lFluid 	:= .T.
		
	INIT FORM o
	
		ROW o
			SAY VALUE 'Hello' GRID 6 ALIGN 'right' OF o
			SAY VALUE 'Hello' GRID 4 OF o
			SAY VALUE 'Hello' GRID 2 ALIGN 'center' OF o
		ENDROW o
		
    END FORM o	
	
retu nil