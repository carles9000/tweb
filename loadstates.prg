#define PATH_DATA 		HB_GetEnv( "PRGPATH" ) + '/data/'

function LoadStates()

    local cAlias
	local hRows := {=>}
	
	USE ( PATH_DATA + 'states.dbf' ) SHARED NEW VIA 'DBFCDX'	
	
	cAlias := Alias()
	
	(cAlias)->( OrdSetFocus( 'CODE') )
	(cAlias)->( DbGoTop() )
	
	while (cAlias)->( !eof() )
	
		hRows[ alltrim((cAlias)->code) ] := (cAlias)->name 
		
		(cAlias)->( dbskip() )
		
	end
	
return hRows