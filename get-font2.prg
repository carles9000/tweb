//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    local o, oWeb
	
	DEFINE WEB oWeb TITLE 'Get Font Label' INIT
	
    DEFINE FORM o 
			
		HTML o INLINE '<h3>Test Get Font Label</h3><hr>'	
		
		DEFINE FONT NAME 'MyFontSay' COLOR 'blue'  FAMILY 'Impact' SIZE 18 OF o
		DEFINE FONT NAME 'MyFontGet' COLOR 'green' ITALIC SIZE 18 OF o
		
		
	INIT FORM o  		
		
		ROWGROUP o  
			GET VALUE 'ABC-3546' LABEL 'Identifica' FONT 'MyFontGet' FONTLABEL 'MyFontSay' OF o
		ENDROW o		
		
    END FORM o	
	
retu nil