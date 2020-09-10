//	-------------------------------------------------------------

CLASS TWebButton FROM TWebControl

	DATA cType		 				INIT 'text'
	DATA cPlaceHolder 				INIT ''
	DATA lOutline 					INIT .T.
	DATA lSubmit					INIT .F.
	DATA cLink						INIT ''

	METHOD New() 					CONSTRUCTOR
	METHOD Activate()


ENDCLASS 

METHOD New( oParent, cId, cLabel, cAction , cName, cValue, nGrid, cAlign, cIcon, cClass, lDisabled, lSubmit, cLink  ) CLASS TWebButton

	DEFAULT cId TO ''
	DEFAULT cLabel TO 'Submit'
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
	::lDisabled	:= lDisabled
	::lSubmit		:= lSubmit
	::cLink			:= cLink

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
	
	
	
	cHtml += '<button type="' + cType + '" class="btn ' + ::cClass + ' ' + cSize + ' tweb_button" ' 

	
	IF !empty( ::cAction )
		cHtml += 'onclick="' + ::cAction + '" ' 
	ENDIF
		
	cHtml += 'id="' + ::cId + '" name="' + ::cName + '" value="' + ::uValue + '" ' 
	cHtml += IF( ::lDisabled, 'disabled', '' ) + ' >' 
	cHtml += ::cIcon + ::cLabel
	cHtml += '</button>'
	cHtml += '</div>'

	

RETU cHtml