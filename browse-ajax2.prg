//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o, oWeb, oCol, oBrw
	LOCAL cHtml := ''
	
	DEFINE WEB oWeb TITLE 'Browse Ajax' TABLES INIT
	
	DEFINE FORM o ID 'demo'

	HTML o INLINE '<h3>Test Browse Ajax II</h3><hr>'
		
	INIT FORM o  			
		
		ROWGROUP o
			BUTTON LABEL 'Url ENDPOINT: https://www.w3schools.com/angular/customers.php' GRID 6 ACTION 'LoadCustomers()' OF o  
		ENDROW o
		
		ROWGROUP o		   			
			
			DEFINE BROWSE oBrw ID 'ringo' HEIGHT 400 TOOLS PRINT EXPORT SEARCH OF o
			
                    ADD oCol TO oBrw ID 'Name' 	HEADER 'Name  '  ALIGN 'right'
            		ADD oCol TO oBrw ID 'City'	HEADER 'City'    SORT
            		ADD oCol TO oBrw ID 'Country'	HEADER 'Country' SORT            		
		ENDROW o
		
		HTML o
			<script>

				var oBrw = new TWebBrowse( 'ringo' )

				function LoadCustomers() {
					 
					oBrw.Loading()
					
					MsgServer( 'https://www.w3schools.com/angular/customers.php', null, Post_LoadCustomer )
				}
				
				function Post_LoadCustomer( dat ){

					oBrw.Loading(false)					
					
					oBrw.SetData( dat.records ) 
				}							
				
			</script>		
		ENDTEXT
	
	END FORM o
	
retu nil