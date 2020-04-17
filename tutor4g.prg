//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#define PATH_DATA 		HB_GetEnv( "PRGPATH" ) + '/data/'

#include {% TWebInclude() %}

function main()

    local o, oWeb, oCol, oBrw
	local aRows := LoadData()	

	DEFINE WEB oWeb TITLE 'Test Browse' ICON 'images/favicon.ico' TABLES INIT
	
	DEFINE FORM o ID 'demo'
		
		HTML o INLINE '<h3>Test Browse - dblclick event</h3><hr>'
		
	INIT FORM o 

		ROW o
		
			COL o GRID 12

				DEFINE BROWSE oBrw ID 'ringo' HEIGHT 400 DBLCLICK 'ViewRow' OF o

					ADD oCol TO oBrw ID 'first' 	HEADER 'First' 	ALIGN 'right'
					ADD oCol TO oBrw ID 'last'	HEADER 'Last'  	SORT			
					ADD oCol TO oBrw ID 'age'		HEADER 'Age' 	WIDTH 70 

				INIT BROWSE oBrw DATA aRows
		
			END o
			


		END o

		HTML o 
		
			<script>				
				
				function ViewRow( e, row ) {
				
					MsgInfo( row.first.trim() + ' ' + row.last + '<br>' + row.street + ' ' + row.city, 'Customer' ) 
				}					
				
			</script>
			
		ENDTEXT

	END FORM o	
	
retu nil

function LoadData() 

	local aRows := {}
	local cAlias, nI

	USE ( PATH_DATA + 'test.dbf' ) SHARED NEW VIA 'DBFCDX'
	
	cAlias := Alias()
	
	for nI := 1 to 100
	
		Aadd( aRows,  {'first' 	=> UHtmlEncode( (cAlias)->first  )	,;
						'last' 		=> UHtmlEncode( (cAlias)->last 	 )	,;						
						'street'	=> UHtmlEncode( (cAlias)->street  )	,;						
						'city'		=> UHtmlEncode( (cAlias)->city 	 )	,;						
						'state'		=> UHtmlEncode( (cAlias)->state 	 )	,;						
						'zip'		=> UHtmlEncode( (cAlias)->zip 	 )	,;						
						'hiredate'	=> DToC( (cAlias)->hiredate )			,;						
						'married'	=> (cAlias)->married 	 				,;						
						'age' 		=> (cAlias)->age 						,;	
						'salary'	=> (cAlias)->salary					,;						
						'notes'		=> UHtmlEncode( (cAlias)->notes 	 )	 ;
					})
		
		(cAlias)->( dbskip() )
	next

retu aRows 

