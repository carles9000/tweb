//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

#define PATH_DATA 		HB_GetEnv( "PRGPATH" ) + '/data/'

function main()

    LOCAL o, oWeb

	DEFINE WEB oWeb TITLE 'Test CharSet - ANSI / Dbf' 
		oWeb:cCharset := 'Latin-1'				
		//oWeb:cCharset := 'utf-8'
	INIT WEB oWeb
	
	DEFINE FORM o ID 'demo'

		
	INIT FORM o  	
	
		HTML o PARAMS oWeb 
			
			<h3>
				Demo: Uso de dbf </br>
				Source Format: ANSI </br>
				Charset: <$ oWeb:cCharset $>
			</h3><hr>	
			
		ENDTEXT				
	
	END FORM o
	
	USE ( PATH_DATA + 'ansi.dbf' ) SHARED NEW VIA 'DBFCDX'
	
	while ( !eof() )
	
		? FIELD->text 
		
		dbskip() 
	end	
	
retu nil

