//	-------------------------------------------------------------

CLASS TWebBox FROM TWebForm
	
	DATA oParent

	METHOD New() 					CONSTRUCTOR
	METHOD Activate()
	

	METHOD End()					INLINE ::Html( '</div>' )

ENDCLASS 

METHOD New( oParent, cId, nGrid, nHeight, cClass ) CLASS TWebBox

	DEFAULT cId 			TO ''
	DEFAULT nGrid TO 12	
	DEFAULT cClass TO ''
	DEFAULT nHeight TO 0
	
		
	::oParent 		:= oParent
	::cId			:= cId
	::nGrid			:= nGrid
	::nHeight 		:= nHeight
	::cClass 		:= cClass	
	

	IF Valtype( oParent ) == 'O'	
		oParent:AddControl( SELF )	
		
		::lDessign := oParent:lDessign
		
	ENDIF

RETU SELF

METHOD Activate() CLASS TWebBox

	LOCAL cHtml := ''
	LOCAL nI, cPrefix
	
	/*
	local cType := ::oParent:cType 	

	IF !Empty( cType )
		cPrefix := cType + '-' 	
	ELSE
		cPrefix := IF( empty(::cType), '', ::cType + '-' )
	ENDIF	
	//cHtml += '<div class="col-' + cPrefix + ltrim(str(::nGrid)) 		
	*/
	
	cHtml += '<div class="col-' + ltrim(str(::nGrid)) 		
	
	
	//cHtml += IF( ::oParent:lDessign, ' tweb_dessign', '') 
	
		if !empty( ::cClass )	
			cHtml += ' ' + ::cClass
		end
	
	cHtml += '" '
	cHtml += 'style="'
	cHtml += IF( ::oParent:lDessign, 'border:3px solid yellow;', '' )
	
		if !empty( ::nHeight )
			if valtype( ::nHeight) == 'N'
				if ::nHeight > 0
					cHtml += 'height:' + ltrim(str(::nHeight)) + 'px;'
				endif	
			else
				cHtml += 'height:' + ::nHeight + ';'	//	don't work
			endif
		endif	
	
	cHtml += '">'
		
		FOR nI := 1 To len( ::aControls )
		
			IF Valtype( ::aControls[nI] ) == 'O'			
				cHtml += ::aControls[nI]:Activate()			
			ELSE		
				cHtml += ::aControls[nI]
			ENDIF
		
		NEXT		
	

RETU cHtml