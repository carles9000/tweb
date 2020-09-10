//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o
	
	DEFINE WEB oWeb TITLE 'Tutor1' INIT
	
    DEFINE FORM o ID 'demo'	
		o:lDessign 	:= .T.
		
		
	INIT FORM o

			SAY ID 'myid' VALUE 'Hello' ALIGN 'right' OF o
			SAY ID 'myid' VALUE 'Bye bye' ALIGN 'center' OF o
			SAY  		  VALUE 'Iepass'  OF o
			SAY  		  VALUE 'Iepass'  GRID 12 OF o
			SAY  		  VALUE 'Iepass'  ALIGN 'RIGht' GRID 6 OF o
			SAY 		  VALUE 'Hello <small>little bit</small>' ALIGN 'right' OF o
			SAY 		  VALUE 'Hello <span style="color:red;">world!</span> <small>(little bit)</small>' ALIGN 'right' OF o

    END FORM o	
	
retu nil