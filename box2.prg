//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o, oWeb, oBox
	local c := ''
	
	DEFINE WEB oWeb TITLE 'Box example II' 
	
		HTML oWeb 
		
			<style>
				.MyBox {
					background-color:lightgray;	
					box-shadow: 5px 5px 10px 0px #888888;					
				}
			</style>		
		
		ENDTEXT			
	
	INIT WEB oWeb
	
    DEFINE FORM o 
		o:lDessign 	:= .T.
		o:lFluid 	:= .T.
		o:cType 	:= 'lg'		 //  xs,sm,md,lg		
		
	INIT FORM o	
	
		ROW o HALIGN 'center'
		
			COL o GRID 8
			
				ROWGROUP o 

					BOX oBox ID 'AA' GRID 6 HEIGHT 180 CLASS 'MyBox' OF o
					
						ROW oBox
						
							SAY VALUE 'Hello' GRID 6 ALIGN 'right' OF oBox
							SAY VALUE 'Hello' GRID 4 OF oBox
							SAY VALUE 'Hello' GRID 2 ALIGN 'center' OF oBox
						
						END oBox	

						ROW oBox
						
							SAY VALUE 'Hello' GRID 6 ALIGN 'right' OF oBox
							SAY VALUE 'Hello' GRID 4 OF oBox
							SAY VALUE 'Hello' GRID 2 ALIGN 'center' OF oBox
						
						END oBox						
					
					ENDBOX oBox
					
					BOX oBox ID 'BB' GRID 4 CLASS 'MyBox' OF o
					
						ROW oBox
						
							SAY VALUE 'Bye' GRID 4 ALIGN 'right' OF oBox
							SAY VALUE 'Bye' GRID 8 OF oBox						
						
						END oBox						
					
					ENDBOX oBox
				
				END o
				
			END o		
		
		END o
	
	END FORM o
	
		
	
retu nil