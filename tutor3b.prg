//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o

	DEFINE WEB oWeb TITLE 'Tutor3b' INIT

    DEFINE FORM o ID 'demo'	
		o:lDessign := .T.
        o:cSizing   := 'sm'       //  SM/LG

		//HTML o FILE 'templates/header.tpl' PARAMS { 'icon' => '<i class="far fa-share-square"></i>', 'title' => 'Form example...' }
		HTML o FILE 'templates/header.tpl' PARAMS '<i class="far fa-share-square"></i>', 'Form example...'

        INIT FORM o               
        
        ROWGROUP o ALIGN 'top'
            SEPARATOR o LABEL 'Align top'
            SELECT oSelect  ID 'cars'  LABEL 'Cars' PROMPT 'Volvo', 'Seat', 'Renault' VALUES  'V', 'S', 'R'  GRID 6  OF o
            SELECT oSelect  ID 'cars2'              PROMPT 'Volvo', 'Seat', 'Renault' VALUES  'V', 'S', 'R'  GRID 6  OF o            
        END o
		
        ROWGROUP o ALIGN 'center'
            SEPARATOR o LABEL 'Align center'
            SELECT oSelect  ID 'cars'  LABEL 'Cars' PROMPT 'Volvo', 'Seat', 'Renault' VALUES  'V', 'S', 'R'  GRID 6  OF o
            SELECT oSelect  ID 'cars2'              PROMPT 'Volvo', 'Seat', 'Renault' VALUES  'V', 'S', 'R'  GRID 6  OF o            
        END o		
		
        ROWGROUP o ALIGN 'bottom'
            SEPARATOR o LABEL 'Test bottom'
            SELECT oSelect  ID 'cars'  LABEL 'Cars' PROMPT 'Volvo', 'Seat', 'Renault' VALUES  'V', 'S', 'R'  GRID 6  OF o
            SELECT oSelect  ID 'cars2'              PROMPT 'Volvo', 'Seat', 'Renault' VALUES  'V', 'S', 'R'  GRID 6  OF o            
        END o		

		
    END FORM o	