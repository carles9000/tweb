//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o

	DEFINE WEB oWeb TITLE 'Tutor3' INIT

    DEFINE FORM o ID 'demo'	
		o:lDessign := .F.

        DEFINE FORM o ID 'demo'
            o:lDessign  := .T.
            o:cSizing   := 'sm'       //  SM/LG

        HTML o
            <div class="alert alert-dark form_title" role="alert">
                <h5 style="margin:0px;">
                    <i class="far fa-share-square"></i>
                    Form example II
                </h5>
            </div>
        ENDTEXT

        INIT FORM o  
       
       
        ROWGROUP o
           
            SEPARATOR o LABEL 'Datos de Salida'

            CAPTION o LABEL 'Identficador' GRID 6
            CAPTION o LABEL '<b>Información</b>' GRID 6
        
            GET ID 'myid' VALUE '11' GRID 6 PLACEHOLDER 'Id.' BUTTON '<i class="fas fa-search"></i>' ACTION 'GetId()' OF o

            SMALL o ID 'chofer_data' Label 'Test...' GRID 6
        
        END o
        
        
        ROWGROUP o
           
            GET ID 'chofer' VALUE '11' GRID 6 PLACEHOLDER 'Id.' LABEL 'Chofer'  BUTTON '<i class="fas fa-search"></i>' ACTION 'LoadChofer()' OF o

        END o
        
        ROWGROUP o
            
            SEPARATOR o LABEL 'Crear Ticket de Salida'

            BUTTON ID 'btn' LABEL ' Test Button' ACTION 'alert(123)' GRID 6 ICON '<i class="fas fa-clipboard-check"></i>' CLASS 'btn-primary btnticket' OF o
        
            SWITCH ID 'onoff' VALUE .T. LABEL 'Ready' OF o

        END o          
        
        
        ROWGROUP o

            SWITCH ID 'onoff2' VALUE .T. LABEL 'Ready.' ACTION  "alert('change')" OF o

        END o  
        
        cLoren := "Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. "

        
        ROWGROUP o
        
            SEPARATOR o LABEL 'Crear Ticket de Salida'
            
            COL o GRID 8 
            
                ROWGROUP o

                    BUTTON ID 'btn' LABEL ' Test' ACTION 'alert(123)' GRID 6 ICON '<i class="fas fa-clipboard-check"></i>' CLASS 'btn-primary btnticket' OF o
        
                    SWITCH ID 'onoff3' VALUE .T. LABEL 'Ready' GRID 6 OF o
                
                END o
            
            END o
            
            COL o GRID 4
                ROWGROUP o
                     SMALL o ID 'chofer_data' Label cLoren  GRID 12
                END o
            END o            

        END o           
        
        ROW o
            SEPARATOR o LABEL 'Test Select'
            SELECT oSelect  ID 'cars'  LABEL 'Cars' PROMPT 'Volvo', 'Seat', 'Renault' VALUES  'V', 'S', 'R'  GRID 6  ONCHANGE 'Select()' OF o
            SELECT oSelect  ID 'cars2'              PROMPT 'Volvo', 'Seat', 'Renault' VALUES  'V', 'S', 'R'  GRID 6  OF o            
        END o
		
		HTML o
			<script>
			
				function GetId() {
				
					var cId = $('#myid').val() 
				
					MsgInfo( cId )
				}
				
				function TestBtn() {
				
					alert( 'Button...' )
				}				
				
			</script>		
		ENDTEXT
		
    END FORM o	