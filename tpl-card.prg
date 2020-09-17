//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o, oWeb

	DEFINE WEB oWeb TITLE 'Test template' INIT

	DEFINE FORM o 
	
	HTML o INLINE '<h4>Test Template...</h4><hr>'

	INIT FORM o  				
		
		ROW o HALIGN 'center'				
				
			HTML o FILE 'templates/card.tpl' ;
				PARAMS { 'id' => 'ACF-7639',;
						 'name' => 'John Kocinsky',;
						 'photo' => 'images/user.jpg' }
				
		END o

	END FORM o	
	
retu nil