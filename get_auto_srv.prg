//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o, oWeb

	DEFINE WEB oWeb TITLE 'Test Autocomplete - Server' INIT

    DEFINE FORM o 

    INIT FORM o  		
       
		HTML o INLINE '<h3>Test Get Autocomplete - Server</h3></hr>'
		
        ROWGROUP o        
            
            GET ID 'birds' VALUE '' GRID 6 LABEL 'Source: Server' AUTOCOMPLETE 'srv_get_auto.prg' ;
				PLACEHOLDER 'ex: Charles, Chris, Irene,... ' OF o
        
        ENDROW o	
		
    END FORM o	
	
retu nil