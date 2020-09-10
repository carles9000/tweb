//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#define PATH_DATA 		HB_GetEnv( "PRGPATH" ) + '/data/'

#include {% TWebInclude() %}

function main()

    local o, oCol, oBrw, cAlias, nI
	local aRows := {}
	
	USE ( PATH_DATA + 'test.dbf' ) SHARED NEW VIA 'DBFCDX'
	
	cAlias := Alias()
	
	for nI := 1 to 100
	
		Aadd( aRows,  { 'first' 	=> UHtmlEncode( (cAlias)->first  )	,;
						'last' 		=> UHtmlEncode( (cAlias)->last 	 )	,;						
						'age' 		=> (cAlias)->age 		})
		
		(cAlias)->( dbskip() )
	next

	DEFINE WEB oWeb TITLE 'Test Browse' ICON 'images/favicon.ico' TABLES INIT
	
	DEFINE FORM o ID 'demo'

		HTML o INLINE '<h3>Test Browse</h3><hr>'
		
	INIT FORM o  			

		DEFINE BROWSE oBrw ID 'ringo' HEIGHT 400 OF o

			ADD oCol TO oBrw ID 'first' 	HEADER 'First' 	ALIGN 'right'
			ADD oCol TO oBrw ID 'last'		HEADER 'Last'  	SORT			
			ADD oCol TO oBrw ID 'age'		HEADER 'Age' 	WIDTH 70 ALIGN 'center' FORMATTER 'ageFormatter'	

		INIT BROWSE oBrw DATA aRows			

		HTML o 
		
			<script>				
				
				function ageFormatter(value, row) {
						
					if ( row.age > 50 )
						return '<i class="fa fa-star"></i>&nbsp;' + value
					else
						return '<img src="images/ball_green.png">&nbsp' + value									
				}						
				
			</script>
			
		ENDTEXT

	END FORM o	
	
retu nil