//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    local o, oWeb, oCol, oBrw
	local aRows := LoadData()	

	DEFINE WEB oWeb TITLE 'Test Browse' ICON 'images/favicon.ico' TABLES INIT
	
	DEFINE FORM o 
		o:lDessign := .f.
		
		HTML o INLINE '<h3>Test Browse - onchange event</h3><hr>'
		
	INIT FORM o 

		ROW o
		
			COL o GRID 6

				DEFINE BROWSE oBrw ID 'ringo' HEIGHT 400 ONCHANGE 'SelData' OF o

					ADD oCol TO oBrw ID 'first' 	HEADER 'First' 	ALIGN 'right'
					ADD oCol TO oBrw ID 'last'		HEADER 'Last'  	SORT			
					ADD oCol TO oBrw ID 'age'		HEADER 'Age' 	WIDTH 70 
					ADD oCol TO oBrw ID 'state'		HEADER 'Estate'	

				INIT BROWSE oBrw DATA aRows
		
			ENDCOL o
			
			COL o GRID 6
			
				ROWGROUP o
					GET ID 'city' VALUE '' GRID 12  LABEL 'City' OF o
				ENDROW o
				
				ROWGROUP o
					GET ID 'st'   VALUE '' GRID 4 LABEL 'State' OF o
					GET ID 'zip'  VALUE '' GRID 6 LABEL 'Zip'   OF o
				ENDROW o
				
				ROWGROUP o
					GET ID 'hiredate' VALUE '' GRID 6 LABEL 'Hiredate' OF o
				ENDROW o  
				
				ROWGROUP o
					CHECKBOX ID 'married' LABEL 'Married' GRID 6 OF o					
				ENDROW o  					
					
				ROWGROUP o
					GET ID 'notes' VALUE '' GRID 12 LABEL 'Notes' OF o
				ENDROW o				

			ENDCOL o

		ENDROW o

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

{% LoadFile( 'loaddata.prg' ) %} 