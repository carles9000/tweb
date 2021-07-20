//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o, oWeb
	
	DEFINE WEB oWeb TITLE 'Tutor 9' INIT
	
    DEFINE FORM o 
		o:lDessign 	:= .F.
		o:cSizing 	:= 'sm'       	//  SM/LG  (small/large)
		
	INIT FORM o  		
		
		ROWGROUP o VALIGN 'bottom'
			GET VALUE '123' LABEL 'Id' OF o
			SELECT LABEL 'Cars' PROMPT 'Volvo', 'Renault' VALUES 'V', 'R' GRID 6  OF o
		ENDROW o		
		
    END FORM o	
	
retu nil