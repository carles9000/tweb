//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o
	
	DEFINE WEB oWeb TITLE 'Tutor6' INIT

	DEFINE FORM o ID 'demo'
		o:lDessign  := .F.
		o:cSizing   := ''     //  SM/LG

	HTML o
		<div class="alert alert-dark form_title" role="alert">
			<h5 style="margin:0px;">
				<i class="far fa-share-square"></i>
				Test Combobox
			</h5>
		</div>
	ENDTEXT

	INIT FORM o         
   
		ROWGROUP o
		   
			SEPARATOR o LABEL 'Datos de Salida'

			SELECT oSelect  ID 'cars' PROMPT 'Volvo', 'Seat', 'Renault' VALUES  'V', 'S', 'R'  GRID 6  ONCHANGE 'Select()' OF o
			
		ENDROW o

		HTML o
		
			<script>
				
				function Select() {
					
					alert( $('#cars').val() )
				}				
				
			</script>	
		ENDTEXT		        
	
	END FORM o
	
retu nil