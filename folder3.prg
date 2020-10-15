//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o

	DEFINE WEB oWeb TITLE 'Tutor9' INIT

	DEFINE FORM o 

	HTML o
		<div class="alert alert-dark form_title" role="alert">
			<h5 style="margin:0px;">
				<i class="far fa-share-square"></i>
				Test Folder
			</h5>
		</div>
	ENDTEXT

	INIT FORM o  

		ROWGROUP o
		
			FOLDER oFld ID 'fld' ;
				TABS 'general', 'admin' ;
				PROMPT 'General', 'Admin' ;
				OPTION 'admin' OF o
				
				oFld:lBorder := .t.
			
				DEFINE TAB 'general' OF oFld

				
				ENDTAB oFld
				
				DEFINE TAB 'admin' CLASS 'p-5' OF oFld 

					GET oGet ID 'myid' VALUE '' LABEL 'Id. User' GRID 12 BUTTON 'Hello' ACTION "alert('hola')" OF oFld
					
				ENDTAB oFld			
			
			END oFld

		END o
		
	END FORM o    
	
retu nil