//	-------------------------------------------------------------

CLASS TWebGetMemo FROM TWebControl

	DATA cType		 				INIT 'text'
	DATA cPlaceHolder 				INIT ''
	DATA cBtnLabel 					INIT ''
	DATA cBtnAction 				INIT ''
	DATA nRows						INIT 3


	METHOD New() 					CONSTRUCTOR
	METHOD Activate()


ENDCLASS 

METHOD New( oParent, cId, uValue, nGrid, cLabel, cAlign, lReadOnly, nRows ) CLASS TWebGetMemo

	DEFAULT cId TO ''
	DEFAULT uValue TO ''
	DEFAULT nGrid TO 4
	DEFAULT cLabel TO ''
	DEFAULT cAlign TO ''
	DEFAULT lReadOnly TO .F.
	DEFAULT nRows TO 3
	

	
	::oParent 		:= oParent
	::cId			:= cId
	::uValue		:= uValue
	::nGrid			:= nGrid
	::cLabel 		:= cLabel
	::cAlign 		:= cAlign
	::lReadOnly		:= lReadOnly
	::nRows 		:= nRows
	

	IF Valtype( oParent ) == 'O'	
		oParent:AddControl( SELF )	
	ENDIF

RETU SELF

METHOD Activate() CLASS TWebGetMemo

	LOCAL cHtml
	LOCAL cSize := ''
	
	DO CASE
		CASE upper(::oParent:cSizing) == 'SM' ; cSize := 'form-control-sm'
		CASE upper(::oParent:cSizing) == 'LG' ; cSize := 'form-control-lg'
	ENDCASE	

	cHtml := '<div class="col-' + ltrim(str(::nGrid)) + IF( ::oParent:lDessign, ' tweb_dessign', '') + '" ' + IF( ::oParent:lDessign, 'style="border:1px solid blue;"', '' )   + ' >'
	
	IF !empty( ::cLabel )
	
		cHtml += '<label for="' + ::cId + '">' + ::cLabel + '</label>'
	
	ENDIF	
	
	cHtml += '<textarea class="form-control ' + cSize + '" rows="' + ltrim(str(::nRows)) + '" '
	cHtml += 'id="' + ::cId + '"	 name="' + ::cId + '" ' 
	//cHtml += 'placeholder="' + ::cPlaceHolder + '" ' 
	
	IF ::lReadOnly
		cHtml += ' readonly '
	ENDIF
	
	//cHtml += ' value="' + ::uValue + '">'
	cHtml += ' >'
	cHtml += ::uValue

	cHtml += '</textarea>'

	cHtml += '</div>'

RETU cHtml