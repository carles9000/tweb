//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o, oWeb

	DEFINE WEB oWeb TITLE 'html template' INIT

	DEFINE FORM o 
		o:lDessign := .t.		
	
	INIT FORM o  		
	
		HTML o FILE 'templates/test.tpl' PARAMS '<i class="far fa-share-square"></i>', 'TPL example with parameters'
		
		HTML o FILE 'templates/test_hash.tpl' ;
			PARAMS { 'icon'  => '<i class="far fa-share-square"></i>',;
					 'title' => 'TPL example with hash' }
					 
		HTML o FILE 'templates/test_error.tpl' ;
			PARAMS { 'icon'  => '<i class="far fa-share-square"></i>',;
					 'title' => 'TPL example hash error'}
		
	END FORM o	
	
retu nil