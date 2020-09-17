//	-------------------------------------------------------------

CLASS TWebCard FROM TWebForm

	//DATA aControls					INIT {}

	METHOD New() 					CONSTRUCTOR	
	METHOD Activate()
	METHOD End()

	//METHOD AddControl( uValue )		INLINE Aadd( ::aControls, uValue )

ENDCLASS 

METHOD New( oParent, cId, cTitle, nWidth, cClass ) CLASS TWebCard

	DEFAULT cId TO ''
	DEFAULT cTitle TO ''
	DEFAULT nWidth TO 0
	DEFAULT cClass TO ''
	
	::oParent 		:= oParent
	::cId			:= cId
	::uValue		:= cTitle	
	::cClass 		:= cClass
	
	IF Valtype( oParent ) == 'O'	
		oParent:AddControl( SELF )	
	ENDIF

RETU SELF

METHOD Activate() CLASS TWebCard

	LOCAL cHtml, hSource
	LOCAL cSize 	:= ''
	local nI	

	cHtml := '<div class="card ' + IF( ::oParent:lDessign, ' tweb_dessign', '') + '" >' // style="width:400px">
	
	cHtml += '<div class="card-body">'
	
	if !empty( ::uValue )
		cHtml += '<h4 class="card-title text-center">' + ::uValue + '</h4>'
	endif	

	FOR nI := 1 To len( ::aControls )
	
		IF Valtype( ::aControls[nI] ) == 'O'			
			cHtml += ::aControls[nI]:Activate()			
		ELSE		
			cHtml += ::aControls[nI]
		ENDIF
	
	NEXT

	

RETU cHtml

METHOD End() CLASS TWebCard

	local cHtml
	
	cHtml := '  </div>'
	cHtml := ' </div>'
	cHtml := '</div>'

RETU cHtml