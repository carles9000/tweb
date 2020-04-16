//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#define PATH_DATA 		HB_GetEnv( "PRGPATH" ) + '/data/'

#include {% TWebInclude() %}

function main()

    local o, oWeb, oCol, oBrw
	local aRows := LoadData()	

	DEFINE WEB oWeb TITLE 'Test Browse' ICON 'images/favicon.ico' TABLES INIT
	
	DEFINE FORM o ID 'demo'

		HTML o INLINE '<h3>Test Browse - onchange event</h3><hr>'
		
	INIT FORM o 

		ROW o
		
			COL o GRID 6

				DEFINE BROWSE oBrw ID 'ringo' HEIGHT 400 ONCHANGE 'SelData' OF o

					ADD oCol TO oBrw ID 'first' 	HEADER 'First' 	ALIGN 'right'
					ADD oCol TO oBrw ID 'last'		HEADER 'Last'  	SORT			
					ADD oCol TO oBrw ID 'age'		HEADER 'Age' 	WIDTH 70 

				INIT BROWSE oBrw DATA aRows
		
			END o
			
			COL o GRID 6
			
				ROWGROUP o
					GET ID 'city' VALUE '' GRID 12  LABEL 'City' OF o
				END o
				
				ROWGROUP o
					GET ID 'st'   VALUE '' GRID 4 LABEL 'State' OF o
					GET ID 'zip'  VALUE '' GRID 6 LABEL 'Zip'   OF o
				END o
				
				ROWGROUP o
					GET ID 'hiredate' VALUE '' GRID 6 LABEL 'Hiredate' OF o
				END o  
				
				ROWGROUP o
					CHECKBOX ID 'married' LABEL 'Married' GRID 6 OF o					
				END o  					
					
				ROWGROUP o
					GET ID 'notes' VALUE '' GRID 12 LABEL 'Notes' OF o
				END o				

			END o

		END o

		HTML o 
		
			<script>				
				
				function SelData( e, row ) {
					$('#city').val( row.city )
					$('#st').val( row.state )
					$('#zip').val( row.zip )
					$('#hiredate').val( row.hiredate )
					$('#married').prop('checked', row.married );
					$('#notes').val( row.notes )
					$('#married').prop('checked', row.married );
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

