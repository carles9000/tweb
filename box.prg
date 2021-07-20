//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o, oWeb, oBox
	
	DEFINE WEB oWeb TITLE 'Box example' INIT

	
    DEFINE FORM o 
		o:lDessign 	:= .T.		
		
	INIT FORM o	
	
		ROW o HALIGN 'center'
		
			COL o GRID 8

				BOX oBox ID 'AA' OF o
				
					ROW oBox
					
						SAY VALUE 'Hello' GRID 6 ALIGN 'right' OF oBox
						SAY VALUE 'Ep!' GRID 4 OF oBox
						SAY VALUE 'Bye' GRID 2 ALIGN 'center' OF oBox
					
					ENDROW oBox	

					ROW oBox
					
						SAY VALUE 'Bon dia!' GRID 12 ALIGN 'center' OF oBox
					
					ENDROW oBox

					ROW oBox HALIGN 'right'	

						SAY VALUE 'Right' GRID 4 ALIGN 'center' OF oBox
					
					ENDROW oBox					
				
				ENDBOX oBox
				
			ENDCOL o		
		
		ENDROW o
	
	END FORM o			
	
retu nil