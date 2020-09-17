//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    local cHtml 	:= ''
	local cString	:= 'James Bond'
	local nNumeric	:= 1234
	local lLogic	:= .T.
	local dDate		:= date()
	local hData		:= { 'string' => cString, 'numeric' => nNumeric, 'logic' => lLogic }
	local aFruits  := { 'banana', 4567, .T. }
	
	SET DATE TO ITALIAN
	
	DEFINE WEB oWeb TITLE 'PRGTOJS' INIT
	
	??	'<h3>Transform PRG var To JAVASCRIPT var  (II)</h3>'
	??	'<h4><a href="#" onclick="SendData()">Send parameters to server and come back info (click me)</a></h4><hr>'	
	
	TEXT TO cHtml PARAMS cString, nNumeric, lLogic, dDate, hData, aFruits					
	
		<script>
		
			function SendData() {
			
				var oParam = new Object()
					oParam[ 'string' ] 		= <$  SetDataJS( cString ) $>
					oParam[ 'numeric' ] 	= <$  SetDataJS( nNumeric ) $>
					oParam[ 'logic' ] 		= <$  SetDataJS( lLogic ) $>
					oParam[ 'dDate' ] 		= <$  SetDataJS( dDate ) $>
					oParam[ 'hData' ] 		= <$  SetDataJS( hData ) $>
					oParam[ 'aFruits' ]		= <$  SetDataJS( aFruits ) $>
				
					console.log( 'Send', oParam )
				
				MsgServer( 'srv_msgserver.prg', oParam, PostView )			
			}
			
			//  Recibimos los mismos parámetros q hemos enviados y en el mismo formato...
			
			function PostView( dat ) {

				console.log( 'Response', dat )
				
				var cData = '<pre>' + JSON.stringify( dat, undefined, 2) + '</pre>'
				
				MsgInfo( cData, 'Check console...' )
			}

		</script>
	
	ENDTEXT
	
	? cHtml 
	
retu nil