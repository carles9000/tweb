//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

#define PATH_DATA 		HB_GetEnv( "PRGPATH" ) + '/data/'

function main()

    LOCAL o, oWeb	
	LOCAL hParam 	:= GetMsgServer()
	local aRows	:= {}
	local cHtml	:= ''
	
	if !empty( hParam )
		
		USE ( PATH_DATA + 'charset.dbf' ) SHARED NEW VIA 'DBFCDX'
	
		dbgotop()						
		
		while !eof()					
		
			if hParam[ 'utf8']
				cHtml +=   UNITOU8( FIELD->PAR1, 1 ) + ' - ' +  UNITOU8( FIELD->PAR2, 1 ) + '<br>'			
			else
				cHtml +=   FIELD->PAR1 + ' - ' +  FIELD->PAR2 + '<br>'			
			endif
		
			dbskip()
			
		end 		

		AP_SetContentType( "application/json" )
	
		?? hb_jsonEncode( { 'html' => cHtml } )		
		
		retu nil 
	
	endif 	
	
			
	
	//DEFINE WEB oWeb TITLE 'Test CharSet - Dbf' CHARSET 'utf-8' INIT 
	DEFINE WEB oWeb TITLE 'Test CharSet - Dbf' INIT 
	
	DEFINE FORM o
		
		HTML o PARAMS oWeb 
			
			<h3>					
				Charset: <$ oWeb:cCharset $>
			</h3><hr>	
			
		ENDTEXT		

	INIT FORM o
		
		ROWGROUP o
			BUTTON LABEL 'Load Data' GRID 4 ACTION 'Load()' OF o
			SWITCH ID 'utf8' VALUE .F. LABEL 'Convert To Utf8' OF o			
		ENDROW o
		
		DIV o ID 'content' 
		ENDDIV o

		HTML o 
		
			<script>			
			
				function Load(){
				
					$('#content').html( '')
				
					var oPar = new Object()
						oPar[ 'utf8'] = $('#utf8').is( ":checked" )
						
					MsgServer( "charset-g.prg", oPar, PostLoad )									
				}
				
				function PostLoad( response ) {
					console.log( response )											
					
					$('#content').html( response.html )					
				}				
				
			</script>
		
		ENDTEXT 
	
	END FORM o 
	
retu nil