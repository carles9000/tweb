//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    local o, oCol, oBrw
	local aRows := LoadData()

	DEFINE WEB oWeb TITLE 'Basic Browse' TABLES INIT
	
	DEFINE FORM o

		HTML o INLINE '<h3>Basic Browse</h3><hr>'
		
	INIT FORM o  			

		DEFINE BROWSE oBrw ID 'ringo' HEIGHT 400 EXPORT SEARCH PRINT TOOLS OF o

			ADD oCol TO oBrw ID 'first' 	HEADER 'First' 	ALIGN 'right'
			ADD oCol TO oBrw ID 'last'		HEADER 'Last'  	SORT			
			ADD oCol TO oBrw ID 'age'		HEADER 'Age' 	WIDTH 70  					

		INIT BROWSE oBrw DATA aRows		
	
	END FORM o	
	
retu nil

{% LoadFile( 'loaddata.prg' ) %} 