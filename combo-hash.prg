//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o, oWeb
	LOCAL hKeyValue := {=>}

	hKeyValue[ 'V' ] := 'Volvo'
	hKeyValue[ 'R' ] := 'Renault'
	hKeyValue[ 'M' ] := 'Mercedes'
	
	DEFINE WEB oWeb TITLE 'Combobox' INIT

	DEFINE FORM o 
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

			SELECT oSelect  ID 'cars' KEYVALUE hKeyValue GRID 6  ONCHANGE 'Select()' OF o
			
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