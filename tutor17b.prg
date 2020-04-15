//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o, oWeb

	DEFINE WEB oWeb TITLE 'Test Autocomplete' INIT

    DEFINE FORM o ID 'demo'

    INIT FORM o  		
       
		HTML o INLINE '<h3>Test Get Autocomplete - Server</h3></hr>'
		
        ROWGROUP o        
            
            GET ID 'birds' VALUE '' GRID 6 LABEL 'Source: Server' AUTOCOMPLETE 'tutor17-server.prg' ;
				PLACEHOLDER 'ex: Charles, Chris, Irene,... ' OF o
        
        END o	
		
    END FORM o	
	
retu nil