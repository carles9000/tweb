//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o

	DEFINE WEB oWeb TITLE 'MsgServer()' INIT

    DEFINE FORM o 
		
        HTML o INLINE '<h3>Test MsgServer()</h3><hr>'

    INIT FORM o  		
       
        GET ID 'myid' 		VALUE '123' GRID 12 LABEL 'Id.' BUTTON 'GetId' ACTION 'GetId()' OF o			
	
		HTML o
		
			<script>
			
				function GetId() {				
					var cId = $('#myid').val() 
				
					MsgServer( 'srv_recno.prg', cId, PostCall )
				}
				
				function PostCall( data ) {				
					MsgInfo( data )				
				}			
				
			</script>	
			
		ENDTEXT
		
    END FORM o	
	
retu nil