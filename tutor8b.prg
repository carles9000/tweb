//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o, oWeb
	
	DEFINE WEB oWeb TITLE 'Tutor 8' INIT
	
    DEFINE FORM o 
		o:lDessign 	:= .T.
		o:lFluid 	:= .T.
		
	INIT FORM o
	
		ROW o HALIGN 'center' TOP '30%' BOTTOM '50px'
			SAY VALUE 'Hello' GRID 4 ALIGN 'center' OF o	
		ENDROW o
		
		ROW o HALIGN 'center' 
			SAY VALUE 'darling...' GRID 4 ALIGN 'center' OF o	
		ENDROW o		
		
    END FORM o	
	
retu nil