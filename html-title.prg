function main( cIcon, cTitle )

	local c

//	DEFAULT cIcon 	TO ''
//	DEFAULT cTitle	TO ''	
	
	c := Eval( {|| Test1() } )


retu c


function Test1( a, b ) 


retu "Hello !, I'm Test1 at " + time()