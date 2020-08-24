//	-------------------------------------------------------------

/*
	The Bootstrap grid system has four classes:

		xs (for phones - screens less than 768px wide)
		sm (for tablets - screens equal to or greater than 768px wide)
		md (for small laptops - screens equal to or greater than 992px wide)
		lg (for laptops and desktops - screens equal to or greater than 1200px wide)

	Controls
		form-group-sm/lg 	(get,select)
		btn-sm/lg			(button)	
*/



CLASS TWebForm FROM TWebControl


	DATA aControls					INIT {}
	DATA cAction					INIT ''		
	DATA cMethod					INIT 'POST'
	DATA cType						INIT ''		//	sm, md, lg, xl, xs
	DATA cSizing					INIT ''		//	sm, lg
	DATA lFluid						INIT .F. 
	DATA lRowGroupVertical			INIT .F. 

	METHOD New() 					CONSTRUCTOR	

	METHOD AddControl( uValue )		INLINE Aadd( ::aControls, uValue )
	METHOD Html( cCode ) 			INLINE Aadd( ::aControls, cCode )
	METHOD Caption()
	METHOD Separator()
	METHOD Small()
	METHOD InitForm() 					
	METHOD Col() 					
	METHOD Row() 					
	METHOD RowGroup() 					
	METHOD End() 					INLINE ::Html( '</div>' )				
	METHOD Activate()

	METHOD Echo()
	
	
ENDCLASS 

METHOD New( cId, cAction, cMethod ) CLASS TWebForm		

	DEFAULT cId 	TO ''
	DEFAULT cAction TO ''
	DEFAULT cMethod TO 'POST'
	
	::cAction := cAction
	::cMethod := cMethod


RETU SELF

METHOD InitForm() CLASS TWebForm

	LOCAL cClass := IF( ::lFluid, 'container-fluid', 'container' )

	::Html( '<div class="' + cClass + '" ' + IF( ::lDessign, 'style="border:2px solid green;"', '' ) + '>'  )
	
	IF !empty( ::cAction )
	
		::Html( '<form action="' + ::cAction + '" method="' + ::cMethod + '">'  )
	
	ENDIF
	
	::lRowGroupVertical := .F.		
	
RETU NIL

METHOD Col( nCol, cType ) CLASS TWebForm

	LOCAL cPrefix := IF( empty(::cType), '', ::cType + '-' )
	
	DEFAULT cType TO ''
	
	IF !Empty( cType )
		cPrefix := cType + '-' 	
	ELSE
		cPrefix := IF( empty(::cType), '', ::cType + '-' )
	ENDIF		
	
	DEFAULT nCol TO 12

	//	Si ponemos e- -sm, responsive y pone 1 debajo de otro...
	//::Html ( '<div class="col-sm-' + ltrim(str(nCol)) + '"' + IF( ::lDessign, 'style="border:1px solid blue;"', '' ) + '>' )	
	
	::Html ( '<div class="col-' + cPrefix + ltrim(str(nCol)) + '"' + IF( ::lDessign, 'style="border:1px solid blue;"', '' ) + '>' )
	
RETU NIL

METHOD Row() CLASS TWebForm

	::Html( '<div class="row" ' + IF( ::lDessign, 'style="border:1px solid red;"', '' ) + ' >' )
	
RETU NIL


METHOD RowGroup() CLASS TWebForm

	::Html( '<div class="form-group row align-items-center" ' + IF( ::lDessign, 'style="border:1px solid red;"', '' ) + ' >' )

RETU NIL


METHOD Activate() CLASS TWebForm

	LOCAL cHtml := ''
	LOCAL nI
	
	IF !empty( ::cAction )
	
		::Html( '</form>' )
	
	ENDIF	
	
	::Html( '</div>' )

	FOR nI := 1 To len( ::aControls )
	
		IF Valtype( ::aControls[nI] ) == 'O'			
			cHtml += ::aControls[nI]:Activate()			
		ELSE		
			cHtml += ::aControls[nI]
		ENDIF
	
	NEXT

RETU cHtml


METHOD Caption( cTitle, nGrid ) CLASS TWebForm

	LOCAL cHtml := ''		
	
	DEFAULT cTitle TO ''
	DEFAULT nGrid TO 12
	
	cHtml := '<div class="col-' + ltrim(str(nGrid)) + '">'
	
	cHtml += '<small>' + cTitle + '</small>'
	cHtml += '</div>'
	
	::Html( cHtml )

RETU NIL


METHOD Separator( cTitle ) CLASS TWebForm

	LOCAL cHtml := '<div class="col-12 form_separator"' + IF( ::lDessign, 'style="border:1px solid blue;"', '' ) + '>'
	
	DEFAULT cTitle TO ''
	
	cHtml += '<small>' + cTitle + '</small>'
	cHtml += '</div>'
	
	::Html( cHtml )

RETU NIL

METHOD Small( cId, cText, nGrid  ) CLASS TWebForm
	LOCAL cHtml := ''
	
	DEFAULT cId	TO ''
	DEFAULT cText 	TO ''
	DEFAULT nGrid 	TO 6
	
	cHtml := '<div class="col-' + ltrim(str(nGrid)) + IF( ::lDessign, ' tweb_dessign', '')  + '" ' + IF( ::lDessign, 'style="border:1px solid blue;"', '' )   + ' >'
	
	cHtml += '<small id="' + cId + '" class="text-muted">'	
	cHtml += cText
	cHtml += '</small>'
	cHtml += '</div>'	

	::Html( cHtml )		

RETU NIL

METHOD Echo() CLASS TWebForm

RETU ''