//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o, oWeb
	LOCAL aTxt := { 'Volvo', 'Seat', 'Renault' }
	LOCAL aKey := { 'V', 'S', 'R' }

	DEFINE WEB oWeb TITLE 'Tutor 7' INIT

    DEFINE FORM o 
		o:lDessign := .T.
        o:cSizing   := 'sm'       	//  SM/LG
		
    INIT FORM o               
        
        ROWGROUP o VALIGN 'top'		//	Default
            SEPARATOR o LABEL 'Align top'
            SELECT oSelect  LABEL 'Cars' PROMPT aTxt VALUES aKey  GRID 6  OF o
            SELECT oSelect               PROMPT aTxt VALUES aKey  GRID 6  OF o            
        ENDROW o
		
        ROWGROUP o VALIGN 'center'
            SEPARATOR o LABEL 'Align center'
            SELECT oSelect  LABEL 'Cars' PROMPT aTxt VALUES aKey  GRID 6  OF o
            SELECT oSelect               PROMPT aTxt VALUES aKey  GRID 6  OF o             
        ENDROW o		
		
        ROWGROUP o VALIGN 'bottom'
            SEPARATOR o LABEL 'Test bottom'
            SELECT oSelect  LABEL 'Cars' PROMPT aTxt VALUES aKey  GRID 6  OF o
            SELECT oSelect               PROMPT aTxt VALUES aKey  GRID 6  OF o              
        ENDROW o		
		
    END FORM o	
	
retu nil