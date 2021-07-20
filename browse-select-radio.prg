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
		
			//COL o GRID 12

				DEFINE BROWSE oBrw ID 'ringo' HEIGHT 400 SELECT RADIO CLICKSELECT OF o	

					ADD oCol TO oBrw ID 'first' 	HEADER 'First' 	ALIGN 'right'
					ADD oCol TO oBrw ID 'last'		HEADER 'Last'  	SORT			
					ADD oCol TO oBrw ID 'age'		HEADER 'Age' 	WIDTH 70 

				INIT BROWSE oBrw DATA aRows
		
			//ENDCOL o	
			
			BUTTON LABEL 'Test' ACTION 'Test()' OF o
			
		ENDROW o
		
		

		HTML o 
		
			<script>				
				
				var oBrw 	= new TWebBrowse( 'ringo' )
				
				function Test() {
				
					var oItem = oBrw.GetItem()
					
					console.log( 'Select', oItem )				
										
					MsgInfo( 'First: ' + oItem.first + '<br>State: ' + oItem.state + '<br>Salary: ' + oItem.salary )
				}					
				
			</script>
			
		ENDTEXT

	END FORM o	
	
retu nil

{% LoadFile( 'loaddata.prg' ) %} 
