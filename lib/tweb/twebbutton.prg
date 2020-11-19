//	-------------------------------------------------------------

CLASS TWebButton FROM TWebControl

	DATA cType		 				INIT 'text'
	DATA cPlaceHolder 				INIT ''
	DATA lOutline 					INIT .T.
	DATA lSubmit					INIT .F.
	DATA cLink						INIT ''
	DATA lFiles						INIT .F.

	METHOD New() 					CONSTRUCTOR
	METHOD Activate()


ENDCLASS 

METHOD New( oParent, cId, cLabel, cAction , cName, cValue, nGrid, cAlign, cIcon, lDisabled, lSubmit, cLink, cClass, cFont, lFiles  ) CLASS TWebButton

	DEFAULT cId TO ''
	DEFAULT cLabel TO ''
	DEFAULT cAction TO ''
	DEFAULT cName TO ''
	DEFAULT cValue TO ''
	DEFAULT nGrid TO 4
	DEFAULT cAlign TO ''
	DEFAULT cIcon TO ''		// '<i class="fas fa-check"></i>'
	DEFAULT cClass TO 'btn-primary'				
	DEFAULT lDisabled TO .F.				
	DEFAULT lSubmit TO .F.				
	DEFAULT cLink TO ''
	DEFAULT cClass TO ''
	DEFAULT cFont TO ''		
	DEFAULT lFiles TO .F.
	
	if empty( cClass ) 
		cClass := if( ::lOutline, 'btn-outline-primary' , 'btn-primary')	
	endif
	

	::oParent 		:= oParent
	::cId			:= cId
	::nGrid			:= nGrid
	::cAlign 		:= lower( cAlign )
	::cLabel 		:= cLabel
	::cAction		:= cAction	
	::cName			:= cName
	::uValue		:= cValue
	::cClass		:= cClass
	::cIcon			:= cIcon
	::lDisabled		:= lDisabled
	::lSubmit		:= lSubmit
	::cLink			:= cLink
	::cClass 		:= cClass
	::cFont 		:= cFont	
	::lFiles 		:= lFiles

	IF Valtype( oParent ) == 'O'	
		oParent:AddControl( SELF )		
	ENDIF

RETU SELF

METHOD Activate() CLASS TWebButton

	LOCAL cHtml := ''
	LOCAL cSize := ''
	LOCAL cType := 'button'
	
	DO CASE
		CASE upper(::oParent:cSizing) == 'SM' ; cSize := 'btn-sm'
		CASE upper(::oParent:cSizing) == 'LG' ; cSize := 'btn-lg'
	ENDCASE
	
	IF ::lSubmit
		cType := 'submit'
	ENDIF	

	IF !empty( ::cLink )
		::cAction := "location.href='" + ::cLink + "' "
	ENDIF

	IF empty( ::cName )
		::cName := ::cId
	ENDIF

	cHtml += '<div class="col-' + ltrim(str(::nGrid)) 
	cHtml += IF( ::oParent:lDessign, ' tweb_dessign', '')  
	
	do case
		case ::cAlign == 'center' ; cHtml += ' text-center'
		case ::cAlign == 'right'  ; cHtml += ' text-right'
	endcase	
	
		
	cHtml += '" ' 

	cHtml += IF( ::oParent:lDessign, 'style="border:1px solid blue;"', '' )
	cHtml += '>'
	
	if ::lFiles 
	
		cHtml += '<input type="file" id="' + ::cId + '" style="display:none;" />'
	
	endif
	
	
	
	cHtml += '<button type="' + cType + '" class="btn ' + ::cClass + ' ' + cSize 
	
	
	if !empty( ::cClass )	
		cHtml += ' ' + ::cClass
	endif
	
	if !empty( ::cFont )	
		cHtml += ' ' + ::cFont
	endif	

	/*
	if ::nGrid > 0
		cHtml += ' col-' + ltrim(str(::nGrid))
	endif
	*/
	
	cHtml += '" ' 

	
	IF !empty( ::cAction )
		cHtml += 'onclick="' + ::cAction + '" ' 
	ENDIF
		
	if ::lFiles
		cHtml += 'id="_' + ::cId + '" name="_' + ::cName + '" value="' + ::uValue + '" ' 
	else
		cHtml += 'id="' + ::cId + '" name="' + ::cName + '" value="' + ::uValue + '" ' 
	endif
	
	cHtml += IF( ::lDisabled, 'disabled', '' ) + ' >' 
	cHtml += ::cIcon + ::cLabel
	cHtml += '</button>'
	cHtml += '</div>'

	

RETU cHtml