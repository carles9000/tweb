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
						'salary' 	=> (cAlias)->salary		})
		
		(cAlias)->( dbskip() )
	next

	DEFINE WEB oWeb TITLE 'Test Browse' ICON 'images/favicon.ico' TABLES INIT
	
	DEFINE FORM o ID 'demo'

		HTML o INLINE '<h3>Test Browse - Footer</h3><hr>'
		
	INIT FORM o  			

		DEFINE BROWSE oBrw ID 'ringo' HEIGHT 400 OF o

			ADD oCol TO oBrw ID 'first' 	HEADER 'First' 	ALIGN 'right' FOOTER 'Customers'
			ADD oCol TO oBrw ID 'last'		HEADER 'Last'  	SORT			
			ADD oCol TO oBrw ID 'salary'	HEADER 'Salary' 	WIDTH 200 ALIGN 'center' ;
				FORMATTER 'salaryFormatter' FOOTER 'Average'	

		INIT BROWSE oBrw DATA aRows			

		HTML o 
		
			<script>				
				
				function salaryFormatter(value, row) {
						
					return parseFloat( row.salary).toLocaleString(window.document.documentElement.lang)									
				}	

				function Customers( data ) { 
					return 'Total Customers ' + data.length 
				}
				
				function Average( data ) {
				
					var nTotal = 0; 
					
					for ( n = 0; n < data.length;  n++) {
						nTotal += data[n].salary 
					}	

					var nAverage = nTotal/data.length
										
					return 'Average: ' + parseFloat(nAverage).toLocaleString(window.document.documentElement.lang)
				}
				
			</script>
			
		ENDTEXT

	END FORM o	
	
retu nil