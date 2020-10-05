//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o

	DEFINE WEB oWeb TITLE 'Get Button Link' INIT

    DEFINE FORM o		

	INIT FORM o  	
	   
		ROWGROUP o
		
			GET ID 'myid' VALUE '123' GRID 12 LABEL 'Id.' ;				
				BUTTON 'Go' LINK 'https://modharbour.app/compass'  OF o				
		
		END o	
		
    END FORM o	
	
retu nil