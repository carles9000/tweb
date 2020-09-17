//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o
	
	DEFINE WEB oWeb TITLE 'Combo Font' INIT

	DEFINE FORM o ID 'demo'
		o:lDessign  := .F.
		o:cSizing   := ''     //  SM/LG
		
		DEFINE FONT oFont NAME 'MyFont' COLOR 'green' ITALIC BOLD SIZE 20 OF o

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

			SELECT oSelect  ID 'cars' PROMPT 'Volvo', 'Seat', 'Renault' VALUES  'V', 'S', 'R'  GRID 6  FONT 'MyFont' OF o
			
		END o
      
	
	END FORM o
	
retu nil