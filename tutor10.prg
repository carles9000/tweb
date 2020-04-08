//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o

	LOAD TWEB

    DEFINE FORM o ID 'demo'	
		o:lDessign := .F.
		
        HTML o INLINE '<h3>MyTitle</h3><hr>'

    INIT FORM o  		
       
        GET ID 'myid' 		VALUE '123' GRID 12 LABEL 'Id.' BUTTON 'GetId' ACTION 'GetId()' OF o			
	
		HTML o
		
			<script>
			
				function GetId() {				
					var cId = $('#myid').val() 
				
					MsgServer( 'tutor10-server.prg', cId, PostCall )
				}
				
				function PostCall( data ) {				
					MsgInfo( data )				
				}			
				
			</script>	
			
		ENDTEXT
		
    END FORM o	
	
retu nil