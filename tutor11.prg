//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    local cHtml 	:= ''
	local cString	:= 'James Bond'
	local nNumeric	:= 1234
	local lLogic	:= .T.
	local dDate	:= date()
	local hData	:= { 'string' => cString, 'numeric' => nNumeric, 'logic' => lLogic }
	local aFruits  := { 'banana', 4567, .T. }
	
	SET DATE TO ITALIAN
	
	??	'<h2>Transform PRG var To JAVASCRIPT var</h2>'
	??	'<h3>Go to console...</h3><hr>'
	
	?	'String', cString
	?	'Numeric', valtochar( nNumeric )
	?	'Logic', valtochar( lLogic )
	?	'Date', valtochar( dDate )
	?	'Hash', valtochar( hData )
	?	'Array', valtochar( aFruits )
	
	
	TEXT TO cHtml PARAMS cString, nNumeric, lLogic, dDate, hData, aFruits					
	
		<script>
			var cString 	= <$  SetDataJS( cString ) $>
			var nNumeric 	= <$  SetDataJS( nNumeric ) $>
			var lLogic 	= <$  SetDataJS( lLogic ) $>
			var dDate 		= <$  SetDataJS( dDate ) $>
			var hData 		= <$  SetDataJS( hData ) $>
			var aFruits	= <$  SetDataJS( aFruits ) $>
			
			console.log( typeof( cString ), cString )
			console.log( typeof( nNumeric ), nNumeric )
			console.log( typeof( lLogic ), lLogic )
			console.log( typeof( dDate ), dDate )
			console.log( typeof( hData ), hData )
			console.log( typeof( aFruits ), aFruits )
		</script>
	
	ENDTEXT
	
	? cHtml 
	
retu nil