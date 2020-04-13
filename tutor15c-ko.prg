//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

#define PATH_DATA 		HB_GetEnv( "PRGPATH" ) + '/data/'

function main()

    LOCAL o, oWeb

	DEFINE WEB oWeb TITLE 'Test CharSet - UTF8 / Dbf' 
		oWeb:cCharset := 'Latin-1'
	INIT WEB oWeb
	
	DEFINE FORM o ID 'demo'

		
	INIT FORM o  	
	
		HTML o PARAMS oWeb 
			
			<h3>
				Demo: Uso de dbf </br>
				Source Format: UTF-8 w/o BOM </br>
				Charset: <$ oWeb:cCharset $>
			</h3><hr>	
			
		ENDTEXT				
	
	END FORM o
	
	USE ( PATH_DATA + 'utf8.dbf' ) SHARED NEW VIA 'DBFCDX'
	
	for nI := 1 TO 5
	
		? FIELD->english  + ' ' + FIELD->hindi + ' ' + FIELD->telugu
		
		dbskip() 
	next					
	
retu nil

