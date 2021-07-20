//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o

	DEFINE WEB oWeb TITLE 'Test Icon' INIT

    DEFINE FORM o	

		o:lDessign = .t.

	INIT FORM o  	
	
		DEFINE FONT NAME 'MyFont' COLOR 'red' BOLD SIZE 10 OF o
	   
		ROWGROUP o VALIGN 'center'	
					
			ICON ID 'myicon' SRC '<i class="fas fa-recycle"></i>' ALIGN 'right' OF o
			
			SAY ID 'myid' VALUE '123' GRID 8 OF o	
			
			ICON SRC '<i class="fas fa-ban"></i>' ALIGN 'center' FONT 'MyFont'  OF o
			ICON SRC '<i class="far fa-trash-alt"></i>' LINK 'https://google.es' OF o			
		
		ENDROW o

		ROWGROUP o  HALIGN 'center'	
					
			BUTTON LABEL 'Icon Toggle' ACTION 'IconOnOff()' ALIGN 'center' OF o	
		
		ENDROW o	

		HTML o 
		
			<script>
				
				function IconOnOff() {

					//$('#myicon').toggle()
					
					if($('#myicon').css('display') == 'none'){ 
					   $('#myicon').show('slow'); 
					} else { 
					   $('#myicon').hide('slow'); 
					}					
				}
				
			</script>
		
		ENDTEXT 
		
		
		
    END FORM o	
	
retu nil