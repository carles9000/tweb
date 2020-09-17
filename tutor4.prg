//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o, oWeb
	
	DEFINE WEB oWeb TITLE 'Tutor4' INIT
	
    DEFINE FORM o 
		o:ldessign 	:= .t.
		
		HTML o INLINE '<h3>Test Html</h3><hr>'	
		
		INIT FORM o  	
		
			HTML o
				<div class="row alert alert-dark form_title" role="alert">
					<h5 style="margin:0px;">
						<i class="far fa-share-square"></i>
						Form example
					</h5>
				</div>
			ENDTEXT		
		
    END FORM o	
	
retu nil