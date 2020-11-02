//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o

	DEFINE WEB oWeb TITLE 'Tutor5' INIT

	DEFINE FORM o ID 'demo'
		o:lDessign  := .F.

	HTML o
		<div class="alert alert-dark form_title" role="alert">
			<h5 style="margin:0px;">
				<i class="far fa-share-square"></i>
				Test Radio/Checkbox
			</h5>
		</div>
	ENDTEXT

	INIT FORM o         
   
		ROWGROUP o
		   
			SEPARATOR o LABEL 'Datos de Salida'

			RADIO    oRadio  ID 'style1'  PROMPT 'Uno', 'Dos', 'Tres' VALUES  '1', '2', '3'  CHECKED '2' GRID 6  OF o
			CHECKBOX oCheck1 ID 'accept1' LABEL 'Accept'  GRID 6  OF o

		END o
		
		ROWGROUP o
		   
			SEPARATOR o LABEL 'Datos de Salida'

			RADIO    oRadio  ID 'st1' PROMPT 'Soltero', 'Casado' VALUES  'S', 'C'  GRID 6  INLINE ONCHANGE 'Status1()' OF o
			CHECKBOX oCheck2 ID 'st2' LABEL 'Accept 2' GRID 6 ON ACTION 'Status2()' OF o
		
		END o   

		HTML o
			<script>
			
				function Status1() {
					
					alert( $('input[name=st1]:checked').val() )
				}
				
				function Status2() {
					
					 alert( $('#st2').is(":checked") )
				} 						
				
			</script>		
		ENDTEXT		
	
	
	END FORM o
	
retu nil