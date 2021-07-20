//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    local o, oCol, oBrw
	local aRows 	:= LoadData()	//	Return all fields + id (recno)

	DEFINE WEB oWeb TITLE 'xBrowse I' TABLES INIT
	
	DEFINE FORM o

		HTML o INLINE '<h3>Basic xBrowse I</h3><hr>'		
		
	INIT FORM o		
		
		DEFINE BROWSE ID 'ringo' DATA aRows UNIQUEID 'id' OF o
	
	END FORM o	
	
retu nil

{% LoadFile( 'loaddata.prg' ) %} 