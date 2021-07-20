//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

function main()

	local hParam 	:= GetMsgServer()
	
	?? '<h3>MsgServer() - Request data</h3><hr>'	

	?? 'Type:', valtype(hParam)
	?  'Parameter/s => ', hParam
	
retu nil