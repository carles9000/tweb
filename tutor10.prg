//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o
	LOCAL cTxt := ''

	DEFINE WEB oWeb TITLE 'Tutor8' INIT

	DEFINE FORM o ID 'demo'
		o:lDessign  := .F.
		o:cType     := 'md'    //  xs,sm,md,lg
		o:cSizing   := 'sm'     //  sm,lg

	HTML o
		<div class="alert alert-dark form_title" role="alert">
			<h5 style="margin:0px;">
				<i class="far fa-share-square"></i>
				Test Memo (Resizing screen...)
			</h5>
		</div>
	ENDTEXT
	
	TEXT TO cTxt
Lorem Ipsum is simply dummy text of the printing and typesetting industry.
Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, 
when an unknown printer took a galley of type and scrambled it to make a type specimen book. 
It has survived not only five centuries, but also the leap into electronic typesetting, 
remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets 
containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker 
including versions of Lorem Ipsum.
	ENDTEXT

	INIT FORM o  
	
		ROW o VALIGN 'top'
		
			COL o GRID 6
			
				SEPARATOR o LABEL 'Col 1'
				
				GET oGet MEMO LABEL 'Text Area...' VALUE cTxt GRID 12 OF o
				
			ENDCOL o
			
			COL o GRID 6
		
				SEPARATOR o LABEL 'Col 2'
				
				 SMALL o  LABEL cTxt GRID 12
				
			ENDCOL o
		
		ENDROW o
	
	END FORM o    
	
retu nil