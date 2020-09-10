//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o
	local cLoren := "<h2>Why do we use it?</h2>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."
	local cIpsum := "<h5>Align top</h5>The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested."
	local z
	
	DEFINE WEB oWeb TITLE 'Tutor0e' INIT
	
    DEFINE FORM o ID 'demo'	
		o:ldessign 	:= .f.
		o:lFluid  	:= .f.
		o:cSizing   := ''

		HTML o FILE 'templates/header.tpl' PARAMS '<i class="far fa-share-square"></i>', 'Form example...'
		
		INIT FORM o  	
		
			ROW o ALIGN 'top'
				COL o GRID 8 
				
					ROWGROUP o
						SAY VALUE 'Id:' ALIGN 'right' OF o
						GET VALUE '' OF o
					ENDROW o

					ROWGROUP o
						SAY VALUE 'Phone:' ALIGN 'right' OF o
						GET VALUE '' PLACEHOLDER "Enter phone number" OF o
					ENDROW o
					
					ROWGROUP o			
				//		BUTTON GRID 8 LABEL 'Send' ALIGN 'right' ACTION "alert( 'Hi!')" OF o
						//SEPARATOR o LABEL 'Crear Ticket de Salida'

						BUTTON LABEL ' Test Button' ACTION "alert( 'Hi!' )" GRID 8  ALIGN 'right' ICON '<i class="fas fa-clipboard-check"></i>' CLASS 'btn-danger btnticket' OF o
				
						//SWITCH ID 'onoff' VALUE .T. LABEL 'Ready' OF o

					ENDROW o		

				ENDCOL o
			
				
				COL o GRID 4						

					ROWGROUP o 
						SAY VALUE cIpsum GRID 12 OF o			
					ENDROW o		
					
				ENDCOL o

			ENDROW o
			
		
			ROWGROUP o 
				SAY VALUE cLoren GRID 12 OF o			
			ENDROW o			
			
		
    END FORM o	
	
retu nil