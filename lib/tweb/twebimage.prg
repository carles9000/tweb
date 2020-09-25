//	-------------------------------------------------------------

CLASS TWebImage FROM TWebControl

	DATA cSrc						INIT ''

	METHOD New() 					CONSTRUCTOR
	METHOD Activate()


ENDCLASS 

METHOD New( oParent, cId, cSrc, nGrid, cAlign, cClass, nWidth ) CLASS TWebImage

	DEFAULT cId TO ''
	DEFAULT cSrc TO ''
	DEFAULT nGrid TO 4
	DEFAULT cAlign TO ''
	DEFAULT cClass TO ''
	DEFAULT nWidth TO 0
	
	::oParent 		:= oParent
	::cId			:= cId
	::cSrc			:= cSrc
	::nGrid			:= nGrid
	::cAlign 		:= lower( cAlign )
	::cClass 		:= cClass
	::nWidth 		:= nWidth


	IF Valtype( oParent ) == 'O'	
		oParent:AddControl( SELF )	
	ENDIF

RETU SELF

METHOD Activate() CLASS TWebImage

	LOCAL cHtml, hSource
	LOCAL cSize 	:= ''
	
	
	DO CASE
		CASE upper(::oParent:cSizing) == 'SM' ;	cSize 		:= 'form-control-sm'			
		CASE upper(::oParent:cSizing) == 'LG' ;	cSize 		:= 'form-control-lg'			
	ENDCASE	

	cHtml := '<div class="col-' + ltrim(str(::nGrid)) 
	
	cHtml += IF( ::oParent:lDessign, ' tweb_dessign', '') 
	cHtml += ' tweb_image' 
	
	do case
		case ::cAlign == 'center' ; cHtml += ' text-center'
		case ::cAlign == 'right'  ; cHtml += ' text-right'
	endcase

	
	if !empty( ::cClass )	
		cHtml += ' ' + ::cClass
	endif

	
	
	cHtml += '" '
	cHtml += IF( ::oParent:lDessign, 'style="border:1px solid black;"', '' ) 		
	cHtml += ' >'

	
	cHtml += '<img src="' + ::cSrc + '" class="rounded " '
	
	if ::nWidth > 0
		cHtml += ' style="width:' + ltrim(str(::nWidth)) + 'px; '
	endif
		
	cHtml += ' alt="...">'

	cHtml += '</div>'

RETU cHtml