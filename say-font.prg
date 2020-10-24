//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o, oFont
	
	DEFINE WEB oWeb TITLE 'Test Say Class/Font' INIT	
	
    DEFINE FORM o 
		//o:lDessign 	:= .T.	

		DEFINE FONT oFont NAME 'MyFont' COLOR 'red' BACKGROUND 'blue' ITALIC BOLD SIZE 20 OF o
				
		CSS o		
		
			.MySay {
				height: 100px;				
				border-radius: 20px;				
				-webkit-box-shadow: 10px 10px 5px 0px rgba(0,0,0,0.75);
				-moz-box-shadow: 10px 10px 5px 0px rgba(0,0,0,0.75);
				box-shadow: 10px 10px 5px 0px rgba(0,0,0,0.75);
				padding-top: 12px;
			}

		ENDTEXT					
		
	INIT FORM o
	
		ROW o
			SAY VALUE 'Hello' GRID 6 ALIGN 'right'  FONT 'MyFont' OF o
			SAY VALUE 'Hello' GRID 4 OF o
			SAY VALUE 'Hello' GRID 2 ALIGN 'center' CLASS 'MySay' FONT 'MyFont' OF o
		END o
		
    END FORM o	
	
retu nil