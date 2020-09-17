//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o, oWeb
	
	DEFINE WEB oWeb TITLE 'Tutor 8' INIT
	
    DEFINE FORM o 
		o:lDessign 	:= .T.
		o:lFluid 	:= .T.
		
	INIT FORM o
	
		ROW o HALIGN 'center'
			SAY VALUE 'Hello' GRID 4 ALIGN 'right' OF o
			SAY VALUE 'Bye'   GRID 2 OF o			
		END o
		
    END FORM o	
	
retu nil