//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o, oWeb

	DEFINE WEB oWeb TITLE 'Tutor 12' INIT

    DEFINE FORM o ACTION 'tutor12_srv.prg'

		INIT FORM o  		
		   
			ROWGROUP o			
				GET ID 'myid' 		VALUE '123' GRID 4 LABEL 'Id.'   OF o
				GET ID 'myphone'	VALUE '567' GRID 4 LABEL 'Phone' OF o			
			END o		
			
			ROWGROUP o
				BUTTON LABEL 'Enviar' GRID 4 SUBMIT OF o      
			END o					
		
    END FORM o	
	
retu nil