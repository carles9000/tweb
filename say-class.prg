//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o
	
	DEFINE WEB oWeb TITLE 'Test Say Class' INIT	
	
    DEFINE FORM o 
		//o:lDessign 	:= .T.		
		
		CSS o		
		
			.MySay {
				background-color: #607D8B;
				color: #FFEB3B;
			}

			.MySayItalic {
			    font-style: italic;
				font-family: auto;
				font-weight: bold;								
			}
			
		ENDTEXT
	
		
	INIT FORM o
	
		ROW o
			SAY VALUE 'Hello' GRID 6 ALIGN 'right'  CLASS 'MySay' OF o
			SAY VALUE 'Hello' GRID 4 OF o
			SAY VALUE 'Hello' GRID 2 ALIGN 'center' CLASS 'MySay MySayItalic' OF o
		ENDROW o
		
    END FORM o	
	
retu nil