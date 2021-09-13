//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    local o, oWeb, oCol, oBrw
	local aRows := LoadData()	
	local aChecked := { 1,2,4 }

	DEFINE WEB oWeb TITLE 'Test Browse' ICON 'images/favicon.ico' TABLES INIT
	
	DEFINE FORM o
		
		HTML o INLINE '<h3>Test Browse - multiselect - Checked</h3><hr>'
		
	INIT FORM o 

		ROW o
		
			COL o GRID 12
			
				//	3 Options
				//	SELECT 				= Select only one
				//	MULTISELECT 			= MultiSelect Ctrl+Click or Shift+Click
				//	SELECT MULTISELECT 	= Multiselect toglee

				DEFINE BROWSE oBrw ID 'ringo' SELECT MULTISELECT HEIGHT 400   CLICKSELECT OF o	//	SELECT
				
					oBrw:cUniqueId := 'id'

					ADD oCol TO oBrw ID 'id' 		HEADER 'Id' 	ALIGN 'center'
					ADD oCol TO oBrw ID 'first' 	HEADER 'First' 	ALIGN 'right'
					ADD oCol TO oBrw ID 'last'		HEADER 'Last'  	SORT			
					ADD oCol TO oBrw ID 'age'		HEADER 'Age' 	WIDTH 70 

				INIT BROWSE oBrw DATA aRows CHECKED aChecked 
		
			ENDCOL o	
			
			BUTTON LABEL 'Test' ACTION 'Test()' OF o
			
		ENDROW o
		
		

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
