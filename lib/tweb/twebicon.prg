//	-------------------------------------------------------------

CLASS TWebIcon FROM TWebControl

	DATA cLink 						INIT '' 

	METHOD New() 					CONSTRUCTOR
	METHOD Activate()


ENDCLASS 

METHOD New( oParent, cId, cSrc, nGrid, cAlign, cClass, cFont, cLink ) CLASS TWebIcon

	DEFAULT cId TO ''
	DEFAULT cSrc TO ''
	DEFAULT nGrid TO 1
	DEFAULT cAlign TO ''
	DEFAULT cClass TO ''	
	DEFAULT cFont TO ''
	DEFAULT cLink TO ''
	
	::oParent 		:= oParent
	::cId			:= cId
	::cSrc			:= cSrc
	::nGrid			:= nGrid
	::cAlign 		:= lower( cAlign )
	::cClass 		:= cClass
	::cFont 		:= cFont
	::cLink 		:= cLink

	IF Valtype( oParent ) == 'O'	
		oParent:AddControl( SELF )	
	ENDIF

RETU SELF

METHOD Activate() CLASS TWebIcon

	LOCAL cHtml, hSource
	LOCAL cSize 	:= ''
	
	
	DO CASE
		CASE upper(::oParent:cSizing) == 'SM' ;	cSize 		:= 'form-control-sm'			
		CASE upper(::oParent:cSizing) == 'LG' ;	cSize 		:= 'form-control-lg'			
	ENDCASE	

	cHtml := '<div id="' + ::cId + '" class="col-' + ltrim(str(::nGrid)) 
	
	cHtml += IF( ::oParent:lDessign, ' tweb_dessign', '') 
	cHtml += ' tweb_icon' 
	
	do case
		case ::cAlign == 'center' ; cHtml += ' text-center'
		case ::cAlign == 'right'  ; cHtml += ' text-right'
	endcase

	
	if !empty( ::cClass )	
		cHtml += ' ' + ::cClass
	endif
	
	if !empty( ::cFont )	
		cHtml += ' ' + ::cFont
	endif		
	
	cHtml += '" '
	cHtml += IF( ::oParent:lDessign, 'style="border:1px solid brown;"', '' ) 		
	cHtml += ' >'
	
	if !empty( ::cLink )
		cHtml += '<a href="' + ::cLink + '">'
	endif
	
	//cHtml += '<span id="' + ::cId + '">' + ::uValue + '</span>'
	cHtml += ::cSrc
	
	if !empty( ::cLink )
		cHtml += '</a>'
	endif	

	cHtml += '</div>'

RETU cHtml