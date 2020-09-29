//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o, oWeb

	DEFINE WEB oWeb TITLE 'Browse Search' TABLES INIT


    DEFINE FORM o 

	INIT FORM o  	

		HTML o INLINE '<h3>Test TWebBrwSearch()</h3><hr>'	
			
		ROWGROUP o
			BUTTON LABEL 'Test TWebBrwSearch()' GRID 6 ACTION 'Test()' OF o      			
		END o
		
		HTML o
		
			<script>			
				
				function Test() {

					
					var cUrl 	= 'srv_brwsearch.prg'					
					var aHeader = { 'first':'First' ,  'last':'Last', 'age': 'Edad...' } 																											
				
					TWebBrwSearch( cUrl, aHeader, myfunc )
				}
		
				function myfunc( row ) {
				
					console.log( row )

					if ( row ) {					
						MsgInfo( row.first + '<br>' + row.last )					
					}						
				}
			
			</script>			
		
		ENDTEXT
			
		
    END FORM o	
	
retu nil