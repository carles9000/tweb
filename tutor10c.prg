//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    local o, oBrw, oCol, oCheck
    local cHtml := ''	

	DEFINE WEB oWeb TITLE 'Tutor10c' INIT
	
    DEFINE FORM o ID 'demo'	
		
        HTML o INLINE '<h3>System information...</h3><hr>'	

        INIT FORM o
        
            ROW o
            
                COL o GRID 12
			
					ROWGROUP o			
                        
                        GET ID 'mytext' VALUE 'James Brown...'   GRID 4 LABEL 'String' BUTTON 'Test String' ACTION 'TestString()' OF o         
    
                    END o
                    
                    ROWGROUP o
                        
                        GET ID 'mynumber' VALUE '1234.56'   GRID 4 LABEL 'Number' BUTTON 'Test Number' ACTION 'TestNumber()' OF o         
    
                    END o   
                    
                    
                    ROWGROUP o

						BUTTON ID 'btn'  LABEL 'Send All' GRID 0 ACTION 'TestAll()' OF o
    
                    END o 
				
                
                END o
            
            END o
        


	
		HTML o
		
			<script>
			
				function TestString() {
					
					var cValue = $('#mytext').val()

					MsgServer( 'tutor10c-server.prg', cValue, PostView )
				}
				
				function TestNumber() {
					
					var cValue = parseFloat( $('#mynumber').val() )         // Check parseInt() also...

					MsgServer( 'tutor10c-server.prg', cValue, PostView )
				}   
				
				function TestLogic() {
					
					var cValue = $('#mylogic').prop('checked' )

					MsgServer( 'tutor10c-server.prg', cValue, PostView )
				}  
				
				function TestAll() {
					
					var oParam = new Object()
						oParam[ 'mytext'    ] = $('#mytext').val()
						oParam[ 'mynumber'  ] = parseFloat( $('#mynumber').val() )
						//oParam[ 'mylogic'   ] = $('#mylogic').prop('checked' )
						
						MsgServer( 'tutor10c-server.prg', oParam, PostView )
				}
				
				
				//  Funcion Callback que se ejecutará cuando el servidor devuelva
				//  un resultado.
				
				function PostView( dat ) {
				
					MsgInfo( dat )
					console.log( dat )
				}	
				
			</script>	
			
		ENDTEXT
		
    END FORM o	
	
retu nil