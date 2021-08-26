//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

#define PATH_DATA 		HB_GetEnv( "PRGPATH" ) + '/data/'

function main()

    LOCAL o, oWeb	
	LOCAL hParam := GetMsgServer()
	local cPar1, cPar2 
	
	if !empty( hParam )
	
		USE ( PATH_DATA + 'charset.dbf' ) SHARED NEW VIA 'DBFCDX'
	
		dbgotop()						
		
		dbRlock()
		
		field->par1 := hParam[ 'par1' ]
		field->par2 := hParam[ 'par2' ]
		
		//	Read value 
		
		cPar1 := field->par1
		cPar2 := field->par2	

		?? 'Saved Par1: ', cPar1 
		 ? 'Saved Par2: ', cPar2 
		 ? 'Open and see table charset.dbf'
		 ? '<hr>'
		 
	else 
	
		//	Init vars 
		
		cPar1 := 'àáèéíòóúñç'
		cPar2 := '早上好'
		
		?? 'Init vars...<hr>'
	
	endif 			
	
	//DEFINE WEB oWeb TITLE 'Test CharSet - Dbf' CHARSET 'utf-8' INIT 
	DEFINE WEB oWeb TITLE 'Test CharSet - Dbf' INIT 
	
	DEFINE FORM o ACTION 'charset-e.prg'
		
		HTML o PARAMS oWeb 
			
			<h3>					
				Charset: <$ oWeb:cCharset $>
			</h3><hr>	
			
		ENDTEXT		

	INIT FORM o

	
		ROWGROUP o			
			GET ID 'par1' 	VALUE cPar1 	GRID 6 LABEL 'Parameter 1 (par1)' OF o
			GET ID 'par2'	VALUE cPar2	GRID 6 LABEL 'Parameter 2 (par2)' OF o			
		ENDROW o		
		
		ROWGROUP o
			BUTTON LABEL 'Send' GRID 4 SUBMIT OF o      
		ENDROW o		
	
	END FORM o 
	

	
	
	
	
retu nil