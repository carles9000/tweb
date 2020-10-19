//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    local o, oWeb, oCol, oBrw
	local aRows := LoadData()	

	DEFINE WEB oWeb TITLE 'Test Browse' ICON 'images/favicon.ico' TABLES INIT
	
	DEFINE FORM o
		
		HTML o INLINE '<h3>Test Browse - multiselect event</h3><hr>'
		
	INIT FORM o 

		ROW o
		
			COL o GRID 12

				DEFINE BROWSE oBrw ID 'ringo' HEIGHT 400 MULTISELECT CLICKSELECT OF o	//	SELECT

					ADD oCol TO oBrw ID 'first' 	HEADER 'First' 	ALIGN 'right'
					ADD oCol TO oBrw ID 'last'		HEADER 'Last'  	SORT			
					ADD oCol TO oBrw ID 'age'		HEADER 'Age' 	WIDTH 70 

				INIT BROWSE oBrw DATA aRows
		
			END o	
			
			BUTTON LABEL 'Test' ACTION 'Test()' OF o
			
		END o
		
		

		HTML o 
		
			<script>				
				
				function Test() {
				
					var oBrw 	= new TWebBrowse( 'ringo' )
					var aSelect = oBrw.Select()
										
					MsgInfo( 'Rows Selected: ' + aSelect.length, 'View console...' )
					console.log( 'Select', aSelect )				
				}					
				
			</script>
			
		ENDTEXT

	END FORM o	
	
retu nil

{% LoadFile( 'loaddata.prg' ) %} 
