//	-------------------------------------------------------------

CLASS TWebFont FROM TWebControl

	DATA cColor 					INIT ''
	DATA cbackground				INIT ''
	DATA nSize 						INIT 0
	DATA lBold 						INIT .F.
	DATA lItalic 					INIT .F.

	METHOD New() 					CONSTRUCTOR
	METHOD Activate()


ENDCLASS 

METHOD New( oParent, cId, cColor, cbackGround, nSize, lBold, lItalic ) CLASS TWebFont

	DEFAULT cId 			TO ''
	DEFAULT cColor 			TO ''
	DEFAULT cBackGround 	TO ''
	DEFAULT nSize			TO 0
	DEFAULT lBold			TO .F.
	DEFAULT lItalic			TO .F.

	
	::oParent 		:= oParent
	::cId			:= cId
	::cColor		:= cColor
	::cBackGround	:= cBackGround
	::nSize 		:= nSize
	::lBold 		:= lBold
	::lItalic 		:= lItalic

	IF Valtype( oParent ) == 'O'	
		oParent:AddControl( SELF )	
	ENDIF

RETU SELF

METHOD Activate() CLASS TWebFont

	LOCAL cHtml := ''


	cHtml += '<style>'
	cHtml += '    .' + ::cId + '{ '
	
	if !empty( ::cColor )
		cHtml += 'color: ' + ::cColor + ';'
	endif
	
	if !empty( ::cBackGround )
		cHtml += 'background: ' + ::cBackGround + ';'
	endif	
	
	if ::nSize > 0
		cHtml += 'font-size: ' + ltrim(str( ::nSize )) + 'px;'
	endif	
	
	if ::lBold
		cHtml += 'font-weight: bold;'
	endif
	
	if ::lItalic
		cHtml += 'font-style: italic;'
	endif	
	
	cHtml += '} '
	cHtml += '</style>'

RETU cHtml