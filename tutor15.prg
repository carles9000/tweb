//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o, oCol, oBrw

	DEFINE WEB oWeb TITLE 'Test Browse' 
		oWeb:cCharset := 'utf-8'
		//oWeb:cCharset := 'Latin-1'		
	INIT WEB oWeb
	
	DEFINE FORM o ID 'demo'

		
	INIT FORM o  	
	
		HTML o PARAMS oWeb 
			
			<h3>
				Source Format: UTF-8 w/o BOM <br>
				Charset: <$ oWeb:cCharset $>
			</h3><hr>
			
			<br><b><u>Bloc 1</u></b>
			
			<br> Special characters ÄäÕõüÜ Barça caña àáèéíòóú ü î	
			<br>
			
			<br><b><u>Bloc 2</u></b>
			
			<br> 中国版 (China)
			<br> 香港版 (Hong Kong)
			<br> 日本 (Japan)
			<br> 한국 (Korea)
			<br> 台灣版 (Taiwan)
			<br> ישראל (Israel)
			<br> Ελλάδα (Greece)
			<br> العالم العربي (Arabic)
			<br> Россия (Russia)
			<br> हिन्दी (India)
			<br> தமிழ் (India)
			<br> മലയാളം (India)
			<br> తెలుగు (India)			
			
		ENDTEXT				
	
	END FORM o
	
retu nil