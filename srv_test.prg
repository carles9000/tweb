//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

function main()

	local uValue := GetMsgServer()
	
	?? 'Type: ' + valtype( uValue )
	? valtochar(uValue)
	
retu nil