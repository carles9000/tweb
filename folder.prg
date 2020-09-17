//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o

	DEFINE WEB oWeb TITLE 'Tutor9' INIT

	DEFINE FORM o ID 'demo'
	
	HTML o
		<div class="alert alert-dark form_title" role="alert">
			<h5 style="margin:0px;">
				<i class="far fa-share-square"></i>
				Test Folder
			</h5>
		</div>
	ENDTEXT

	INIT FORM o  

		ROWGROUP o
		
			FOLDER oFld ID 'fld' TABS 'menu1', 'admin' PROMPT 'Menu 1', '<i class="fas fa-tv"></i> Admin' OF o

				DEFINE TAB 'menu1' OF oFld

					GET oGet ID 'myid' VALUE '' LABEL 'Id. User' BUTTON 'Hello' ACTION "alert('hola')" OF oFld
					
				ENDTAB oFld	
				
				DEFINE TAB 'admin' OF oFld
				
					HTML oFld
					
						<div class="alert alert-primary form_title row" role="alert">
							<h5 style="margin:0px;">
								<i class="fas fa-users-cog"></i>
								Administracion Usuarios
							</h5>
						</div>
						
					ENDTEXT
					
					ROWGROUP oFld
						GET oGet ID 'aaa' VALUE 'aaa' GRID 4 PLACEHOLDER 'Test aaa' BUTTON '<i class="fas fa-search"></i>' ACTION 'LoadChofer()' OF oFld
						GET oGet ID 'bbb' VALUE 'bbb' GRID 8 PLACEHOLDER 'Test bbb' BUTTON '<i class="fas fa-search"></i>' ACTION 'LoadChofer()' OF oFld                             
					END oFld
					
					
				ENDTAB oFld					
				
			END oFld
		END o
	END FORM o    
	
retu nil