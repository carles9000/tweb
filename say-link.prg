//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o, oFont
	
	DEFINE WEB oWeb TITLE 'Test Say Link' INIT	
	
    DEFINE FORM o 	
		
	INIT FORM o
	
		ROW o
			SAY VALUE 'Say-Font example' LINK 'say-font.prg' GRID 6  OF o
		ENDROW o
		
    END FORM o	
	
retu nil