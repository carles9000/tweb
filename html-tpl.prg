//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o

	DEFINE WEB oWeb TITLE 'html template' INIT

	DEFINE FORM o ID 'demo'	
		o:lDessign := .F.
		
		HTML o FILE 'html-title.tpl' PARAMS '<i class="far fa-share-square"></i>', 'Form example'

	INIT FORM o  				

		HTML o 
			<div class="alert alert-success">
				<strong>Success!</strong> Indicates a successful or positive action.
			</div>
		ENDTEXT
		
	END FORM o	
	
retu nil