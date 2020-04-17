//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#define PATH_DATA 		HB_GetEnv( "PRGPATH" ) + '/data/'

#include {% TWebInclude() %}

function main()

    local o, oWeb, oCol, oBrw
	local aRows := LoadData()	

	DEFINE WEB oWeb TITLE 'Test Browse' ICON 'images/favicon.ico' TABLES INIT
	
	DEFINE FORM o ID 'demo'		
		
		HTML o INLINE '<h3>View Customer</h3><small>Smartphone version</small><hr>'
		
	INIT FORM o 
	
		ROWGROUP o
	
			FOLDER oFld ID 'fld' TABS 'list', 'user' PROMPT '<i class="fas fa-th-list"></i> List', '<i class="far fa-user"></i> User' ADJUST OF o		
			
				DEFINE TAB 'list' OF oFld
				
					DEFINE BROWSE oBrw ID 'ringo' HEIGHT 400 ONCHANGE 'SelData' OF oFld

						ADD oCol TO oBrw ID 'first' 	HEADER 'First' 	ALIGN 'right'
						ADD oCol TO oBrw ID 'last'		HEADER 'Last'  	SORT			
						ADD oCol TO oBrw ID 'age'		HEADER 'Age' 	WIDTH 70 

					INIT BROWSE oBrw DATA aRows		
					
				ENDTAB oFld
				
				DEFINE TAB 'user' OF oFld
				
				    HTML oFld
						<div class="alert alert-dark form_title" role="alert">
							<h5 id="name" style="margin:0px;"></h5>
						</div>
					ENDTEXT
				
					ROWGROUP o
						GET ID 'city' VALUE '' GRID 12  LABEL 'City' OF oFld
					END o
					
					ROWGROUP o
						GET ID 'st'   VALUE '' GRID 4 LABEL 'State' OF oFld
						GET ID 'zip'  VALUE '' GRID 6 LABEL 'Zip'   OF oFld
					END o
					
					ROWGROUP o
						GET ID 'hiredate' VALUE '' GRID 6 LABEL 'Hiredate' OF oFld
					END o  
					
					ROWGROUP o
						CHECKBOX ID 'married' LABEL 'Married' GRID 6 OF oFld
					END o  					
						
					ROWGROUP o
						GET ID 'notes' VALUE '' GRID 12 LABEL 'Notes' OF oFld
					END o		
				
				ENDTAB oFld
			
			END oFld
		
		END o 

		HTML o 
		
			<script>				
				
				function SelData( e, row ) {
					$('#city').val( row.city )
					$('#st').val( row.state )
					$('#zip').val( row.zip )
					$('#hiredate').val( row.hiredate )
					$('#married').prop('checked', row.married );
					$('#notes').val( row.notes )
					$('#married').prop('checked', row.married );

					$('#name').html( '<b><i>' + row.first + ' ' + row.last + '</i></b>' );
					
					$('.nav-tabs a[href="#user"]').tab('show');
				}					
				
			</script>
			
		ENDTEXT

	END FORM o	
	
retu nil

function LoadData() 

	local aRows := {}
	local cAlias, nI

	USE ( PATH_DATA + 'test.dbf' ) SHARED NEW VIA 'DBFCDX'
	
	cAlias := Alias()
	
	for nI := 1 to 100
	
		Aadd( aRows,  {'first' 	=> UHtmlEncode( (cAlias)->first  )	,;
						'last' 		=> UHtmlEncode( (cAlias)->last 	 )	,;						
						'street'	=> UHtmlEncode( (cAlias)->street  )	,;						
						'city'		=> UHtmlEncode( (cAlias)->city 	 )	,;						
						'state'		=> UHtmlEncode( (cAlias)->state 	 )	,;						
						'zip'		=> UHtmlEncode( (cAlias)->zip 	 )	,;						
						'hiredate'	=> DToC( (cAlias)->hiredate )			,;						
						'married'	=> (cAlias)->married 	 				,;						
						'age' 		=> (cAlias)->age 						,;	
						'salary'	=> (cAlias)->salary					,;						
						'notes'		=> UHtmlEncode( (cAlias)->notes 	 )	 ;
					})
		
		(cAlias)->( dbskip() )
	next

retu aRows 




