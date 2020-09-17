//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o
	LOCAL nI, nJ


	DEFINE WEB oWeb TITLE 'html template' INIT

	DEFINE FORM o 
		o:lDessign 	:= .F.
		o:cType     := ''     //  xs,sm,md,lg
		o:cSizing   := 'sm'     //  sm,lg
		

	INIT FORM o  				

		HTML o 
			<div class="alert alert-success">
				<strong>Success!</strong> Indicates a successful or positive action.
			</div>
		ENDTEXT
		
		ROW o HALIGN 'center'				
				
			HTML o FILE 'templates/card-a.tpl' PARAMS 'Helluu', 'Form example'					
				
		END o
			
		/*
		FOR nJ := 1 to 3
		
			ROW o
			
				FOR nI := 1 to 4
				
					COL o GRID 3 
					
						HTML o FILE 'templates/card-a.tpl' PARAMS 'Helluu', 'Form example'
					
					ENDCOL o
				
				NEXT
			
			END o
		
		next
		*/
		
	END FORM o	
	
retu nil