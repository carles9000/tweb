//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}	//	Loading lib TWeb...

#define PATH_DATA 		HB_GetEnv( "PRGPATH" ) + '/data/'

#include {% TWebInclude() %}

function main()

    local oForm, oCol, oBrw, cAlias, nI
	local aRows := {}
	
	USE ( PATH_DATA + 'test.dbf' ) SHARED NEW VIA 'DBFCDX'
	
	cAlias := Alias()
	
	for nI := 1 to 100
	
		Aadd( aRows,  {'first' 	=> UHtmlEncode( (cAlias)->first  )	,;
						'last' 		=> UHtmlEncode( (cAlias)->last 	 )	,;						
						'street' 	=> UHtmlEncode( (cAlias)->street )	})
		
		(cAlias)->( dbskip() )
	next

	DEFINE WEB oWeb TITLE 'Test Browse' ICON 'images/favicon.ico' TABLES INIT
	
	DEFINE FORM oForm ID 'demo'

		HTML oForm INLINE '<h3>Test Browse</h3><hr>'
		
	INIT FORM oForm  
	
		ROWGROUP oForm
		
			GET ID 'myid' VALUE '' GRID 6 BUTTON 'Search' ACTION 'GetId()' OF oForm
		END oForm		

		DEFINE BROWSE oBrw ID 'ringo' HEIGHT 400 OF oForm

			ADD oCol TO oBrw ID 'first' 	HEADER 'First' 	ALIGN 'right'
			ADD oCol TO oBrw ID 'last'	HEADER 'Last'  	SORT			
			ADD oCol TO oBrw ID 'street'	HEADER 'Street'  	SORT						

		INIT BROWSE oBrw DATA aRows			

	END FORM oForm	
	
retu nil