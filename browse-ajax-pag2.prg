//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}


function main()

    LOCAL o, oWeb, oCol, oBrw
	LOCAL cHtml := ''

	
	DEFINE WEB oWeb TITLE 'Test Browse' TABLES INIT
	
	DEFINE FORM o ID 'demo'

		HTML o INLINE '<h3>Test Browse - Pagination / Search</h3><hr>'	
		
	INIT FORM o  			
		
		ROWGROUP o		
		
			GET	 ID 'search' VALUE '' LABEL 'Search' GRID 12 BUTTON 'Search' ;
				PLACEHOLDER 'Example: Be,...' ;
				ACTION 'Search()' OF o
			
		ENDROW o 

		ROWGROUP o		   			
			
			DEFINE BROWSE oBrw ID 'ringo' HEIGHT 400 ;
				PAGINATION  URL 'srv_brw_pag.prg' USERINTERMEDIATE ;
				OF o
				
				oBrw:cLocale := 'es-ES'
					
				ADD oCol TO oBrw ID 'keyno' 	HEADER 'Keyno'  	ALIGN 'center'
				ADD oCol TO oBrw ID '_recno' 	HEADER 'Recno'  	ALIGN 'center'
				ADD oCol TO oBrw ID 'first' 	HEADER 'First'   	ALIGN 'right'
				ADD oCol TO oBrw ID 'last'		HEADER 'Last'  		SORT
				ADD oCol TO oBrw ID 'street' 	HEADER 'Street' 	SORT					
					
            INIT BROWSE oBrw
			
		ENDROW o

		
		HTML o
			<script>

				var oBrw = new TWebBrowse( 'ringo' )
				
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