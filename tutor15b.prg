//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o, oCol, oBrw

	DEFINE WEB oWeb TITLE 'Test CharSet - Latin-1' 
		oWeb:cCharset := 'Latin-1'		//	'utf-8'
	INIT WEB oWeb
	
	DEFINE FORM o ID 'demo'

		
	INIT FORM o  			

		HTML o PARAMS oWeb 
		
			<h3>
				Source Format: ANSI <br>
				Charset: <$ oWeb:cCharset $>
			</h3><hr>
			
			<br><b><u>Bloc 1</u></b>
			
			<br> Special characters ÄäÕõüÜ Barça caña àáèéíòóú ü î	
			<br>
			
			<br><b><u>Bloc 2</u></b>
			
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