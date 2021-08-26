//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}


function main()

    LOCAL o, oWeb, oCol, oBrw
	LOCAL cHtml := ''

	
	DEFINE WEB oWeb TITLE 'Test Browse' TABLES INIT
	
	DEFINE FORM o ID 'demo'

		HTML o INLINE '<h3>Test Browse - Pagination / Search</h3><hr>'	
		
		HTML o
		
			<style>
				.mybtnbar {
					border-radius:0px;
				}			
				
				.myid {
					background-color: lightgray;
					font-weight: bold;
					text-align: center;
					border-left: 2px solid gray !important;
					border-right: 2px solid gray !important;
					border-top: 0px solid !important;
					border-bottom: 0px solid !important;
				}
				
				.myrow {
					background-color: #ff000040;
					color: black;
					border: 2px solid #e91e1e;
					font-weight: bold;
				}

				.mycustombar {			
					background-color: lightgray;
					padding: 5px;
					border-bottom: 1px solid black;
					border-right: 1px solid black;				
				}				
				
			</style>
		
		ENDTEXT 		
		
	INIT FORM o  		

		DIV o ID 'bar' CLASS 'btn-group'
			BUTTON LABEL ' New' 	ICON '<i class="far fa-plus-square"></i>' 		ACTION 'Add()' 			CLASS 'btn-secondary mybtnbar' GRID 0 OF o
			BUTTON LABEL ' Edit' 	ICON '<i class="far fa-edit"></i>' 				ACTION 'Edit()' 		CLASS 'btn-secondary mybtnbar' GRID 0 OF o
			BUTTON LABEL ' Delete' ICON '<i class="far fa-trash-alt"></i>' 		ACTION 'Delete()' 		CLASS 'btn-secondary mybtnbar' GRID 0 OF o
			BUTTON LABEL ' Save' 	ICON '<i class="far fa-save"></i>' 				ACTION 'Save()' 		CLASS 'btn-secondary mybtnbar' GRID 0 OF o
			
			GET	 ID 'search' VALUE '' LABEL 'Search' GRID 6 BUTTON 'Search' ;
				PLACEHOLDER 'Example: Be,...' ;
				ACTION 'Search()' OF o
			
		ENDDIV o 	


		ROWGROUP o		   			
			
			DEFINE BROWSE oBrw ID 'ringo' MULTISELECT CLICKSELECT  HEIGHT 400 ;
				EDIT UNIQUEID '_recno' TITLE '<i class="fas fa-recycle"></i> My ABM...' POSTEDIT 'TestPostEdit' ;
				TOOLBAR "bar" ;
				TOOLS EXPORT PRINT  ;
				PAGINATION  URL 'srv_brw_pag.prg' USERINTERMEDIATE ;
				OF o
				
				oBrw:cLocale := 'es-ES'
					
				ADD oCol TO oBrw ID 'keyno' 	HEADER 'Keyno'  	ALIGN 'center'
				ADD oCol TO oBrw ID '_recno' 	HEADER 'Recno'  	ALIGN 'center'
				ADD oCol TO oBrw ID 'first' 	HEADER 'First'   	EDIT TYPE 'C' ALIGN 'right'
				ADD oCol TO oBrw ID 'last'		HEADER 'Last'  		EDIT TYPE 'C'
				ADD oCol TO oBrw ID 'street' 	HEADER 'Street' 	EDIT TYPE 'C'				
					
            INIT BROWSE oBrw
			
		ENDROW o

		
		HTML o
			<script>

				var oBrw = new TWebBrowse( 'ringo' )
				
				function Edit() 	{ oBrw.Edit() }	
				function Add()  	{ oBrw.AddRow() }	
				function Delete() { oBrw.DeleteRow() }
				function Reset() 	{ oBrw.Reset() }				
				
				function MyQuery(params) {
					
					params.search = $('#search').val()					
				
					return params
				}

				//	Cada vez que ejecutemos la funcion Search, asignara al browse la
				//	query que ejecutamos en el momento devolviéndole un resultado 
				// 	para que lo pueda pasar al servidor. Observad que es una referencia
				//	a la funcion, sin comillas y sin ejecutarla.
				
				function Search() {
				
					oBrw.SetQuery( MyQuery )					
				}			
				
			</script>		
		ENDTEXT
	
	END FORM o
	
retu nil