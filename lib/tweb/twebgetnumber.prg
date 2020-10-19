//	-------------------------------------------------------------

CLASS TWebGetNumber FROM TWebControl

	DATA cType		 				INIT 'text'
	DATA cPlaceHolder 				INIT ''

	METHOD New() 					CONSTRUCTOR
	METHOD Activate()


ENDCLASS 

METHOD New( oParent, cId, uValue, nGrid, cLabel, cAlign, lReadOnly, cPlaceHolder, lRequired, cChange, cClass, cFont ) CLASS TWebGetNumber

	DEFAULT cId TO ''
	DEFAULT uValue TO ''
	DEFAULT nGrid TO 6
	DEFAULT cLabel TO ''
	DEFAULT cAlign TO 'center'
	DEFAULT lReadOnly TO .F.
	DEFAULT cPlaceHolder TO ''
	DEFAULT lRequired TO .F.
	DEFAULT cChange TO ''
	DEFAULT cClass TO ''
	DEFAULT cFont TO ''

	::oParent 		:= oParent
	::cId			:= cId
	::uValue		:= uValue
	::nGrid			:= nGrid
	::cLabel 		:= cLabel
	::cAlign 		:= cAlign
	::lReadOnly		:= lReadOnly
	::lRequired		:= lRequired
	::cChange 		:= cChange
	::cClass 		:= cClass
	::cFont 		:= cFont


	IF Valtype( oParent ) == 'O'	
		oParent:AddControl( SELF )			
	ENDIF

RETU SELF

METHOD Activate() CLASS TWebGetNumber

	LOCAL cHtml, hSource
	LOCAL cSize 	 := ''
	LOCAL cAlign 	 := ''
	LOCAL cSizeLabel := 'col-form-label'
	LOCAL cBtnSize 	 := ''
	local cLabel
	
	DO CASE
		CASE ::cAlign == 'center' ; cAlign := 'text-center'
		CASE ::cAlign == 'right'  ; cAlign := 'text-right'
	ENDCASE
	
	DO CASE
		CASE upper(::oParent:cSizing) == 'SM' 
			cSize 		:= 'form-control-sm'
			cSizeLabel	:= 'col-form-label-sm'
			cBtnSize 	:= 'btn-sm'
		CASE upper(::oParent:cSizing) == 'LG' 
			cSize 		:= 'form-control-lg'
			cSizeLabel	:= 'col-form-label-lg'
			cBtnSize 	:= 'btn-lg'
	ENDCASE	

	cHtml := '<div class="col-' + ltrim(str(::nGrid)) 

	cHtml += IF( ::oParent:lDessign, ' tweb_dessign', '') 		
	cHtml += '" '
	chtml += IF( ::oParent:lDessign, 'style="border:1px solid blue;"', '' ) 
	cHtml += ' >'
	
	cHtml += '<div class="input-group">'	
	
		cHtml += '<div class="input-group-prepend">'
		
			cHtml += '<button id="btn_minus_' + ::cId + '" class="btn btn-outline-secondary ' + cBtnSize + '" type="button" '			
			
			cHtml += ' ><i class="fas fa-minus"></i></button>'			
		
		cHtml += '</div>'		
	
	IF !empty( ::cLabel )
		cHtml += '<label class="' + cSizeLabel + ' " for="' + ::cId + '">' + ::cLabel + '</label>'	
	ENDIF
	
	
	cHtml += '<input type="tlf" class="form-control ' + cSize + ' ' + cAlign
	
	if !empty( ::cClass )	
		cHtml += ' ' + ::cClass
	endif
	
	if !empty( ::cFont )	
		cHtml += ' ' + ::cFont
	endif						
	
	cHtml += '" '
	cHtml += 'id="' + ::cId + '"	 name="' + ::cId + '" ' 
	cHtml += 'placeholder="' + ::cPlaceHolder + '" ' 
	
	IF ::lReadOnly
		cHtml += ' readonly '
	ENDIF
	
	IF ::lRequired
		cHtml += ' required '
	ENDIF	
	
	IF !empty( ::cChange )		
		cHtml += ' onchange="' + ::cChange + '" '
	ENDIF
	
	cHtml += ' value="' + ::uValue + '">'	
	
		cHtml += '<div class="input-group-append">'		
			
		cHtml += '<button id="btn_plus_' + ::cId + '" class="btn btn-outline-secondary ' + cBtnSize + '" type="button" '			
		
		cHtml += ' ><i class="fas fa-plus"></i>'
		cHtml += '</button>'						
		cHtml += '</div>'	
		

	cHtml += '	</div>'
	cHtml += '</div>'
	

	
	cHtml += '<script>'
	
		cHtml += "$('#btn_minus_" + ::cId + "').click(function(e){"
        cHtml += "    e.preventDefault();"
        cHtml += "    var quantity = parseInt($('#" + ::cId + "').val());" 
		cHtml += "    $('#" + ::cId + "').val(quantity - 1);"
		cHtml += "    $('#" + ::cId + "').trigger('change');"
        cHtml += "});"	
   
		cHtml += "$('#btn_plus_" + ::cId + "').click(function(e){"
        cHtml += "    e.preventDefault();"
        cHtml += "    var quantity = parseInt($('#" + ::cId + "').val());" 
		cHtml += "    $('#" + ::cId + "').val(quantity + 1);"
		cHtml += "    $('#" + ::cId + "').trigger('change');"
        cHtml += "});"
   
	cHtml += '</script>'


RETU cHtml