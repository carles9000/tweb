//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    local o, oWeb, oCol, oBrw
	local aRows := LoadData()	

	DEFINE WEB oWeb TITLE 'Test Browse' ICON 'images/favicon.ico' TABLES INIT
	
	DEFINE FORM o
		
		HTML o INLINE '<h3>Test Browse - Select Radio</h3><hr>'
		
	INIT FORM o 

		ROW o 
		
			COL o GRID 6
			
				ROWGROUP o			

					DEFINE BROWSE oBrw ID 'brw_A' HEIGHT 300 SELECT RADIO CLICKSELECT OF o	

						ADD oCol TO oBrw ID 'first' 	HEADER 'First' 	ALIGN 'right'
						ADD oCol TO oBrw ID 'last'		HEADER 'Last'  	SORT			
						ADD oCol TO oBrw ID 'age'		HEADER 'Age' 	WIDTH 70 

					INIT BROWSE oBrw DATA aRows										
					
				ENDROW o
			
				BUTTON LABEL 'Test' ACTION 'Test_A()' OF o
				
			ENDCOL o 
			
			COL o GRID 6 
			
				ROWGROUP o			

					DEFINE BROWSE oBrw ID 'brw_B' HEIGHT 300 SELECT RADIO CLICKSELECT OF o	

						ADD oCol TO oBrw ID 'first' 	HEADER 'First' 

					INIT BROWSE oBrw DATA aRows										
					
				ENDROW o
			
				BUTTON LABEL 'Test' ACTION 'Test_B()' OF o
				
			ENDCOL o 		
		
		ENDROW o 		
		

		HTML o 
		
			<script>				
				
				var oBrw_A 	= new TWebBrowse( 'brw_A' )
				var oBrw_B 	= new TWebBrowse( 'brw_B' )
				
				function Test_A() {
				
					var oItem = oBrw_A.GetItem()
					
					console.log( 'Select', oItem )				
										
					MsgInfo( 'First: ' + oItem.first + '<br>State: ' + oItem.state + '<br>Salary: ' + oItem.salary )
				}	

				function Test_B() {
				
					var oItem = oBrw_B.GetItem()
					
					console.log( 'Select', oItem )				
										
					MsgInfo( 'First: ' + oItem.first  )
				}				
				
			</script>
			
		ENDTEXT

	END FORM o	
	
retu nil

{% LoadFile( 'loaddata.prg' ) %} 
