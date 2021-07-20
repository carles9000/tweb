//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}


function main()

    LOCAL o, oWeb, oCol, oBrw
	LOCAL cHtml := ''

	
	DEFINE WEB oWeb TITLE 'Test Browse' TABLES INIT
	
	DEFINE FORM o ID 'demo'

		HTML o INLINE '<h3>Test Browse - Pagination</h3><hr>'	
		
	INIT FORM o  			

		ROWGROUP o		   			
			
			DEFINE BROWSE oBrw ID 'ringo' HEIGHT 400 ;
				PAGINATION URL 'srv_brw_pag.prg' ;
				OF o
				
				oBrw:cLocale := 'es-ES'
					
				ADD oCol TO oBrw ID 'keyno' 	HEADER 'Keyno'  	ALIGN 'center'
				ADD oCol TO oBrw ID '_recno' 	HEADER 'Recno'   	ALIGN 'center'
				ADD oCol TO oBrw ID 'first' 	HEADER 'First'  	ALIGN 'right'
				ADD oCol TO oBrw ID 'last'		HEADER 'Last'  		
				ADD oCol TO oBrw ID 'street' 	HEADER 'Street' 					
					
            INIT BROWSE oBrw
			
		ENDROW o
		
		HTML o
			<script>

				var oBrw = new TWebBrowse( 'ringo' )
				
				oBrw.SetQuery()								
				
			</script>		
		ENDTEXT		

	END FORM o
	
retu nil