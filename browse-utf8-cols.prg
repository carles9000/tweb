//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#define PATH_DATA 		HB_GetEnv( "PRGPATH" ) + '/data/'

#include {% TWebInclude() %}

function main()

    local o, oCol, oBrw, cAlias
	local hRow 	:= {=>}
	local aRows := {}
	
	//	Example with dbf utf8 encoded. We will need  CHARSET 'utf-8' 
		
		USE ( PATH_DATA + 'utf8.dbf' ) SHARED NEW VIA 'DBFCDX'
		
		cAlias := Alias()
		
		while (cAlias)->( !Eof() )
		
			Aadd( aRows,  { 'english' 	=> (cAlias)->english 	,;
							'hindi' 	=> (cAlias)->hindi 		,;
							'telugu' 	=> (cAlias)->telugu 	})
			
			(cAlias)->( dbskip() )
		end	

	DEFINE WEB oWeb TITLE 'Test Browse UTF8' ICON 'images/favicon.ico' CHARSET 'utf-8' TABLES INIT

	
	DEFINE FORM o

		HTML o INLINE '<h3>Test Browse</h3><hr>'
		
	INIT FORM o  	

		ROW o 
		
			COL o GRID 6

				DEFINE BROWSE oBrw ID 'ringo' HEIGHT 400 OF o

					ADD oCol TO oBrw ID 'english' 	HEADER 'English' 
					ADD oCol TO oBrw ID 'hindi'		HEADER 'Hindi'  
					ADD oCol TO oBrw ID 'telugu'	HEADER 'Telugu' 			

				INIT BROWSE oBrw DATA aRows		
		
			ENDCOL o
			
			COL o GRID 6

				DEFINE BROWSE oBrw ID 'ringo2' HEIGHT 400 OF o

					ADD oCol TO oBrw ID 'english' 	HEADER 'English' 
					ADD oCol TO oBrw ID 'hindi'		HEADER 'Hindi'  
					ADD oCol TO oBrw ID 'telugu'	HEADER 'Telugu' 			

				INIT BROWSE oBrw DATA aRows		
		
			ENDCOL o			
			
		ENDROW o
	
	END FORM o	
	
retu nil