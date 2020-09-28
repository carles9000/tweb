//	-------------------------------------------------------------

CLASS TWebImage FROM TWebControl

	DATA cSrc						INIT ''
	DATA cBigSrc					INIT ''
	DATA cGallery					INIT ''
	DATA lZoom						INIT .t.

	METHOD New() 					CONSTRUCTOR
	METHOD Activate()


ENDCLASS 

METHOD New( oParent, cId, cSrc, cBigSrc, nGrid, cAlign, cClass, nWidth, cGallery, lNoZoom ) CLASS TWebImage

	DEFAULT cId TO ''
	DEFAULT cSrc TO ''
	DEFAULT cBigSrc TO ''
	DEFAULT nGrid TO 4
	DEFAULT cAlign TO ''
	DEFAULT cClass TO ''
	DEFAULT nWidth TO 0
	DEFAULT cGallery TO ''
	DEFAULT lNoZoom TO .F.
	
	::oParent 		:= oParent
	::cId			:= cId
	::cSrc			:= cSrc
	::cBigSrc		:= cBigSrc
	::nGrid			:= nGrid
	::cAlign 		:= lower( cAlign )
	::cClass 		:= cClass
	::nWidth 		:= nWidth
	::cGallery		:= cGallery
	::lZoom			:= !lNoZoom


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
	
	if ( !empty( ::cBigSrc ) .or. ::lZoom  )
	
		if empty( ::cBigSrc ) 
			::cBigSrc = ::cSrc
		endif
		
		cHtml += '<a href="' + ::cBigSrc + '" '
		
		if  empty( ::cGallery ) 				
			cHtml += 'data-lightbox="twebimg_' + ::cId + '" '
		else 
			cHtml += 'data-lightbox="' + ::cGallery + '" '
		endif
		
		if !empty( ::uValue )
			cHtml += 'data-title="' + ::cCaption + '" '
		endif
		
		cHtml += ' >'		
	
	endif

	
	cHtml += '<img id="' + ::cId + '" src="' + ::cSrc + '" class="rounded " '
	
	if ::nWidth > 0
		cHtml += ' style="width:' + ltrim(str(::nWidth)) + 'px; '
	endif
		
	cHtml += ' alt="...">'
	
	if ( !empty( ::cBigSrc ) .or.  ::lZoom  )			
		cHtml += '</a>'
	endif	

	cHtml += '</div>'

RETU cHtml