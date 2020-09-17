//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}	//	Loading lib TWeb...

#include {% TWebInclude() %}

function main()

    local oForm, oCol, oBrw
	local aRows := LoadData()


	DEFINE WEB oWeb TITLE 'Test Browse' ICON 'images/favicon.ico' TABLES INIT
	
	DEFINE FORM oForm 

		HTML oForm INLINE '<h3>Test Browse</h3><hr>'
		
	INIT FORM oForm  

		DEFINE BROWSE oBrw ID 'ringo' HEIGHT 400 OF oForm

			ADD oCol TO oBrw ID 'first' 	HEADER 'First' 	ALIGN 'right'
			ADD oCol TO oBrw ID 'last'		HEADER 'Last'  	SORT			
			ADD oCol TO oBrw ID 'street'	HEADER 'Street' SORT						

		INIT BROWSE oBrw DATA aRows			

	END FORM oForm	
	
retu nil


{% LoadFile( 'loaddata.prg' ) %}