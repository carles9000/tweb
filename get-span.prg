//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o, oWeb
	
	DEFINE WEB oWeb TITLE 'Test Get Span/Btn' INIT
	
    DEFINE FORM o 
		o:lDessign 	:= .F.
		
	INIT FORM o  		
		
		ROWGROUP o 						
			GET VALUE '' BUTTON 'Test' ACTION "Test()"  SPAN '0' SPANID 'myspan' OF o
		ENDROW o		
		
		HTML o 
			
			<script>
			
				function Test() {
					$('#myspan').html( '123' )
				}
			
			</script>
		
		ENDTEXT 
		
    END FORM o	
	
	
	
retu nil