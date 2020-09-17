//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o, oWeb

	DEFINE WEB oWeb TITLE 'Test CharSet - Latin-1' CHARSET 'utf-8' INIT
	
	DEFINE FORM o 
		
	INIT FORM o  			

		HTML o PARAMS oWeb 
		
			<h3>
				Source Format: ANSI <br>
				Charset: <$ oWeb:cCharset $>
			</h3><hr>
			
			<br><b><u>Bloc 1</u></b>
			
			<br> Special characters ÄäÕõüÜ Barça caña àáèéíòóú ü î	
			<br><br>
			
			I have made a copy / paste of the charset.prg example in utf8. 
			Special symbols are not pasted correctly if our editor is Ansi encoded
			
			<br><br><b><u>Bloc 2</u></b>
			
			<br> ??? (China)
			<br> ??? (Hong Kong)
			<br> ?? (Japan)
			<br> ?? (Korea)
			<br> ??? (Taiwan)
			<br> ????? (Israel)
			<br> ????da (Greece)
			<br> ?????? ?????? (Arabic)
			<br> ?????? (Russia)
			<br> ?????? (India)
			<br> ????? (India)
			<br> ?????? (India)
			<br> ?????? (India)			
			
		ENDTEXT				
	
	END FORM o
	
retu nil