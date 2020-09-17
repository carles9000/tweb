//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    local o, oWeb
	local cLoren := "<h2>Why do we use it?</h2>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."
	
	DEFINE WEB oWeb TITLE 'Tutor5' INIT
	
    DEFINE FORM o 
		o:ldessign 	:= .T.
		o:lFluid  	:= .f.
			
		HTML o INLINE '<h3>Test Form</h3><hr>'	
		
		INIT FORM o  	
		
			HTML o
				<div class="row alert alert-dark form_title" role="alert">
					<h5 style="margin:0px;">
						<i class="far fa-share-square"></i>
						Form example
					</h5>
				</div>
			ENDTEXT		
			
			ROWGROUP o  
				SAY VALUE 'Id:' ALIGN 'right' OF o
				GET VALUE '' OF o
			END o

			ROWGROUP o  
				SAY VALUE 'Phone:' ALIGN 'right' OF o
				GET VALUE '' PLACEHOLDER "Enter phone number" OF o
			END o
			
			ROWGROUP o			

				BUTTON LABEL ' Test Button' ACTION "alert( 'Hi!' )" GRID 8  ALIGN 'right' ICON '<i class="fas fa-clipboard-check"></i>' CLASS 'btn-danger btnticket' OF o

			END o			

			ROWGROUP o
				SAY VALUE cLoren GRID 12 OF o			
			END o		
		
    END FORM o	
	
retu nil