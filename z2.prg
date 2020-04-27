#define PATH HB_GetEnv( "PRGPATH" ) + '/data/'

function main()

	local nTotalAge 	:= 0
	
	USE ( PATH + 'test.dbf' ) SHARED NEW 
	
	while ! Eof()
	
		nTotalAge += FIELD->age
	
		DbSkip()
	end
	
	? 'Average: ', ( nTotalAge / RecCount() )
	
return nil