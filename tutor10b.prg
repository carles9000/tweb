//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o

	DEFINE WEB oWeb TITLE 'Tutor10b' INIT

    DEFINE FORM o ID 'demo'	
		
        HTML o INLINE '<h3>System information...</h3><hr>'

    INIT FORM o  		
       
        GET ID 'recno' 			VALUE '123' GRID 12 LABEL 'Id.' BUTTON 'Go Recno' ACTION 'GetRecno()' OF o			
        GET MEMO ID 'mydata'	VALUE '' 	GRID 12 LABEL 'Data'  READONLY OF o			
	
		HTML o
		
			<script>
			
				function GetRecno() {				
					var cId = $('#recno').val() 
				
					MsgServer( 'tutor10b-server.prg', cId, PostCall )
				}
				
				function PostCall( data ) {
					$('#mydata').val( data )		
				}			
				
			</script>	
			
		ENDTEXT
		
    END FORM o	
	
retu nil