//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o, oWeb
	
	DEFINE WEB oWeb TITLE 'Login Smartphone' INIT

    DEFINE FORM o
		o:lDessign := .f.
		o:lFluid := .t.

    INIT FORM o 		
       
		HTML o FILE 'templates/nav.tpl' 	PARAMS { 'title' => 'App Custo' }
		HTML o FILE 'templates/banner.tpl' 	PARAMS { 'image' => 'images/bg-head-02.jpg' }
		
		ROW o HALIGN 'center'
		
			HTML o FILE 'templates/mycard.tpl' 	PARAMS { 'title' => 'Autentication' }				
			
				ROWGROUP o HALIGN 'center'        
					SAY VALUE 'User' ALIGN 'right' GRID 5 OF o
					GET ID 'user'  VALUE '' ALIGN 'right' GRID 5 OF o
				ENDROW o
				
				
				ROWGROUP o HALIGN 'center'        
					SAY VALUE 'Password' ALIGN 'right' GRID 5 OF o
					GET ID 'psw'  TYPE 'password' VALUE 'police' GRID 5 OF o
				ENDROW o

				ROWGROUP o HALIGN 'center'		
					BUTTON LABEL ' Login' ACTION "Login()" GRID 10 ALIGN 'center' ICON '<i class="fas fa-key"></i>' OF o
				ENDROW o				
				
			HTML o FILE 'templates/mycard_end.tpl' 			
			
		ENDROW o						
		
		HTML o
			<script>
			
				function Info() {
					MsgInfo( 'Hello world' )
				}
			
			</script>		
		ENDTEXT
		
    END FORM o	
	
retu nil