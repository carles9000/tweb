//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o

	DEFINE WEB oWeb TITLE 'Tutor2b' INIT

    DEFINE FORM o ID 'demo'	ACTION 'tutor2b_srv.prg'

		INIT FORM o  		
		   
			ROWGROUP o
			
				GET ID 'myid' 		VALUE '123' GRID 4 LABEL 'Id.' PLACEHOLDER 'User Id.' BUTTON 'GetId' ACTION 'GetId()' OF o
				GET ID 'myphone'	VALUE '' GRID 4 LABEL 'Phone' OF o
			
			END o		
			
			ROWGROUP o
				BUTTON ID 'mybtn'	LABEL 'Enviar' GRID 4 SUBMIT OF o        
			END o					
		
    END FORM o	
	
retu nil