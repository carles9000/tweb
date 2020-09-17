//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o

	DEFINE WEB oWeb TITLE 'Folder Font' INIT

	DEFINE FORM o 
	
		DEFINE FONT NAME 'MyFont' COLOR 'green' ITALIC BOLD SIZE 20 OF o	
	
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
		
			FOLDER oFld ID 'fld' TABS 'menu1', 'menu2' PROMPT 'Menu 1', '<i class="fas fa-tv"></i> Admin' FONT 'MyFont' OF o

				DEFINE TAB 'menu1' OF oFld

					GET oGet ID 'myid' VALUE '' LABEL 'Id. User' BUTTON 'Hello' ACTION "alert('hola')" OF oFld
					
				ENDTAB oFld	
				
				DEFINE TAB 'menu2' OF oFld
				
					HTML oFld
					
						<div class="alert alert-primary form_title row" role="alert">
							<h5 style="margin:0px;">
								<i class="fas fa-users-cog"></i>
								Administracion Usuarios
							</h5>
						</div>
						
					ENDTEXT

				ENDTAB oFld					
				
			END oFld
		END o
	END FORM o    
	
retu nil