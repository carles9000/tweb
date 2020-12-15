//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    local o, oWeb
	
	DEFINE WEB oWeb TITLE 'Get Font' INIT
	
    DEFINE FORM o 
		o:lDessign 	:= .f.
		o:cSizing   := 'sm'
			
		HTML o INLINE '<h3>Test Get Font</h3><hr>'	

		
		DEFINE FONT NAME 'MyFontSay' COLOR 'blue' BOLD SIZE 18 OF o
		DEFINE FONT NAME 'MyFontGet' COLOR 'green' ITALIC SIZE 18 OF o
		
		
	INIT FORM o  		
	
		ROWGROUP o  
			SAY VALUE 'Id' ALIGN 'right' OF o
			GET VALUE '' OF o
		END o
		
		ROWGROUP o  
			SAY VALUE 'Id' ALIGN 'right' FONT 'MyFontSay' OF o
			GET VALUE 'ABC-3546' FONT 'MyFontGet' OF o
		END o		
		
    END FORM o	
	
retu nil