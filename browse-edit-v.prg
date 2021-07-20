//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    local o, oCol, oBrw
	local aRows 	:= {}
	local hCars 	:= {=>}
	
	Aadd( aRows, { 'id' => 'A1', 'name' => 'Charly Aubia' , 'car' => 'V' })
	Aadd( aRows, { 'id' => 'A2', 'name' => 'Maria de la O', 'car' => 'R' })
	Aadd( aRows, { 'id' => 'A3', 'name' => 'John Kocinsky', 'car' => 'F' })
	Aadd( aRows, { 'id' => 'A4', 'name' => 'Anne Clark'   , 'car' => ''  })
	Aadd( aRows, { 'id' => 'A5', 'name' => 'Daniel Clark' , 'car' => 'V' })
	Aadd( aRows, { 'id' => 'A6', 'name' => 'Rod Steward'  , 'car' => 'F' })
	Aadd( aRows, { 'id' => 'A7', 'name' => 'Ally McPerson', 'car' => 'F' })
	Aadd( aRows, { 'id' => 'A8', 'name' => 'Bruce Polest' , 'car' => 'R' })

	hCars[ ''  ] := '' 
	hCars[ 'V' ] := 'Volvo' 
	hCars[ 'R' ] := 'Renault'	
	hCars[ 'F' ] := 'Ferrari'	
	hCars[ 'S' ] := 'Seat'	
	hCars[ 'T' ] := 'Toyota' 	
	hCars[ 'C' ] := 'Citroen'		

	DEFINE WEB oWeb TITLE 'Browse - Edit' TABLES INIT
	
	DEFINE FORM o

		HTML o INLINE '<h3>Basic Browse - Clause Edit V </h3><hr>'
		
	INIT FORM o 

		DIV o ID 'bar' CLASS 'btn-group'
			BUTTON LABEL ' Edit' 	ICON '<i class="far fa-edit"></i>' 			ACTION 'Edit()' 	CLASS 'btn-secondary mybtnbar' GRID 0 OF o
		ENDDIV o 

		DEFINE BROWSE oBrw ID 'ringo' MULTISELECT CLICKSELECT HEIGHT 400 ;
			EDIT UNIQUEID 'id' ;
			TOOLBAR "bar" ;
			OF o

			oBrw:cLocale := 'es-ES'

			ADD oCol TO oBrw ID 'id' 		HEADER 'Id.' 		ALIGN 'center' 
			ADD oCol TO oBrw ID 'name'		HEADER 'Name' 		EDIT TYPE 'V'	//	Only data view
			ADD oCol TO oBrw ID 'car'		HEADER 'Car' 		EDIT TYPE 'COMBOBOX' WITH hCars
			

		INIT BROWSE oBrw DATA aRows			
	
		
		HTML o 
		
			<script>

				var oBrw = new TWebBrowse( 'ringo' )				

				function Edit() 	{ oBrw.Edit() }					
		
			</script>
		
		ENDTEXT

	
	END FORM o	
	
retu nil