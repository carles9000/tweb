//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o

	DEFINE WEB oWeb TITLE 'Tutor2' INIT

    DEFINE FORM o ID 'demo'	
		o:lDessign := .F.
		
        HTML o
            <div class="alert alert-dark form_title" role="alert">
                <h5 style="margin:0px;">
                    <i class="far fa-share-square"></i>
                    Form example
                </h5>
            </div>
        ENDTEXT	

    INIT FORM o  		
       
        ROWGROUP o
        
            GET ID 'myid' 		VALUE '123' GRID 4 LABEL 'Id.' PLACEHOLDER 'User Id.' BUTTON 'GetId' ACTION 'GetId()' OF o
			GET ID 'myphone'	VALUE '' GRID 4 LABEL 'Phone' OF o
		
        END o		
		
        ROWGROUP o
			BUTTON ID 'mybtn'	LABEL 'Test' GRID 4 ACTION 'TestBtn()' OF o        
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
	
retu nil