//	{% LoadHrb( '../../lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude( '../../lib/tweb/' ) %}

function main()

    LOCAL o, oWeb

	DEFINE WEB oWeb TITLE 'App' INIT

    DEFINE FORM o

	INIT FORM o  		
	   
		ROW o HALIGN 'center' TOP '20%' 		
			SAY LABEL '<h3>Welcome to App !</h3>' ALIGN 'center' GRID 10 LINK 'app_menu.prg' OF o
		END o
		
    END FORM o	
	
retu nil