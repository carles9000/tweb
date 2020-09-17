//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    local o, oCol, oBrw
	local aRows := {}
	
	Aadd( aRows, { 'id' => 1, 'name' => 'Charly Aubia' } )
	Aadd( aRows, { 'id' => 2, 'name' => 'Maria de la O' } )
	Aadd( aRows, { 'id' => 3, 'name' => 'John Kocinsky' } )	

	DEFINE WEB oWeb TITLE 'Basic Browse' TABLES INIT
	
	DEFINE FORM o

		HTML o INLINE '<h3>Basic Browse</h3><hr>'
		
	INIT FORM o  			

		DEFINE BROWSE oBrw ID 'ringo' HEIGHT 400 OF o

			ADD oCol TO oBrw ID 'id' 	HEADER 'Id.' 
			ADD oCol TO oBrw ID 'name'	HEADER 'Name'  					

		INIT BROWSE oBrw DATA aRows		
	
	END FORM o	
	
retu nil