//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o
	
	DEFINE WEB oWeb TITLE 'Test Image' INIT
	
    DEFINE FORM o 
		o:lDessign := .t.

    INIT FORM o  		
       
        ROWGROUP o
        
            IMAGE ID 'img_a' FILE 'images/tokyo.jpg' BIGFILE 'images/tokyo_big.jpg' ALIGN 'center' GRID 6  OF o
            IMAGE ID 'img_b' FILE 'images/tokyo.jpg' ALIGN 'center' GRID 6  OF o
        
        END o	

        ROWGROUP o        

            IMAGE ID 'img_b' FILE 'images/tokyo.jpg' GRID 6 NOZOOM OF o
        
        END o			
			
    END FORM o	
	
retu nil