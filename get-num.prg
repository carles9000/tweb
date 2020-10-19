//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o

	DEFINE WEB oWeb TITLE 'Get Number Button' INIT

    DEFINE FORM o		
	
		DEFINE FONT NAME 'MyFontGet' COLOR 'green' ITALIC BOLD SIZE 38 OF o

	INIT FORM o  	

		ROWGROUP o
			SAY LABEL 'Default' OF o
			GETNUMBER ID 'qty' VALUE '123' OF o		
		END o	
		
		ROWGROUP o
		
			SAY VALUE 'Test ONCHANGE' OF o
			GETNUMBER ID 'qty2' VALUE '123' ONCHANGE 'Notify()' OF o		
		END o

		ROWGROUP o
			SAY LABEL 'Test FONT' OF o
			GETNUMBER ID 'qty3' VALUE '123' FONT 'MyFontGet' OF o		
		END o		

		HTML o
			<script>
			
				function Notify() {
				
					var cId = $('#qty2').val() 
				
					MsgNotify( cId )
				}				
				
			</script>		
		ENDTEXT
		
    END FORM o	
	
retu nil