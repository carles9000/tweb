//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o, oWeb
	
	DEFINE WEB oWeb TITLE 'Test Get Btn' INIT
	
    DEFINE FORM o 
		o:lDessign 	:= .F.
		
	INIT FORM o  		
		
		ROWGROUP o 			
			GET VALUE '123' BUTTON 'Search' ACTION "alert('Search')" OF o
		END o		
		
    END FORM o	
	
retu nil