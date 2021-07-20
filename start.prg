//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}	//	Loading lib TWeb...


#include {% TWebInclude() %}

function main()

    local oForm	

	DEFINE WEB oWeb TITLE 'Test START' INIT
	
	DEFINE FORM oForm 

		HTML oForm INLINE '<h3>Test START</h3><hr>'
		
	INIT FORM oForm  
	
		ROWGROUP oForm
		
			GET ID 'myid' LABEL 'Id.' VALUE '' COL 6 OF oForm
			
		ENDROW oForm		
	
		HTML oForm
		
			<script>
			
				function MyInit() {
				
					MsgInfo( 'Execute MyInit() with START CLAUSE' )		
				}
				
			</script>
			
		ENDTEXT

	END FORM oForm START 'MyInit()'
	
retu nil