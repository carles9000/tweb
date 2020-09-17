//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    local o, oWeb, oCol, oBrw
	local aRows := LoadData()	

	DEFINE WEB oWeb TITLE 'Test Browse' ICON 'images/favicon.ico' TABLES INIT
	
	DEFINE FORM o 
		
		HTML o INLINE '<h3>Test Browse - dblclick event. Check console</h3><hr>'
		
	INIT FORM o 

		ROW o
		
			COL o GRID 12

				DEFINE BROWSE oBrw ID 'ringo' HEIGHT 400 DBLCLICK 'ViewRow' OF o

					ADD oCol TO oBrw ID 'first' 	HEADER 'First' 	ALIGN 'right'
					ADD oCol TO oBrw ID 'last'		HEADER 'Last'  	SORT			
					ADD oCol TO oBrw ID 'age'		HEADER 'Age' 	WIDTH 70 

				INIT BROWSE oBrw DATA aRows
		
			END o	
			
		END o

		HTML o 
		
			<script>				
				
				function ViewRow( e, row, z ) {

					
					console.log( 'row data',row )
					console.log( 'event', e )
					console.log( z )
				
					var row_num = $(z).attr( 'data-index' )
					
					console.log( 'ROW', row_num )										
					
					var o = $('#ringo' )

					console.log( 'getData', o.bootstrapTable( 'getData' ) )

				}						
				
			</script>
			
		ENDTEXT

	END FORM o	
	
retu nil

{% LoadFile( 'loaddata.prg' ) %} 