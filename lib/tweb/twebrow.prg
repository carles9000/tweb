//	-------------------------------------------------------------

CLASS TWebRow FROM TWebForm
	
	DATA oParent
	DATA aTabs	 					INIT {}
	DATA aPrompts 					INIT {}
	DATA aTabs 						INIT {=>}
	DATA cInitTab 					INIT ''
	DATA lAdjust 					INIT .F.

	METHOD New() 					CONSTRUCTOR
	METHOD Activate()
	
		
	METHOD AddTab( cId, cHtml )
	METHOD EndTab()					INLINE ::Html( '</div>' )
	METHOD EndFolder()				INLINE ::Html( '</div></div>' )

ENDCLASS 

METHOD New( oParent ) CLASS TWebRow

		
	::oParent 		:= oParent


	IF Valtype( oParent ) == 'O'	
		oParent:AddControl( SELF )	
		
		::lDessign := oParent:lDessign		
	ENDIF

RETU SELF



METHOD AddTab( cId , lFocus ) CLASS TWebRow

	LOCAL cHtml := ''
	LOCAL cClass := IF( ::oParent:lFluid, 'container-fluid', 'container' )
	
	IF ::lAdjust
		cClass += ' tweb_folder '
	ENDIF

	DEFAULT lFocus TO .F.
	
	cHtml := '<div class="tab-pane ' + cClass + ' '  + IF( lFocus, 'active', 'fade' ) + '" '
	cHtml += ' id="' +  cId + '">'
	
	::Html( cHtml )	

RETU NIL

METHOD Activate() CLASS TWebRow

	LOCAL cHtml := ''
	LOCAL nI

	
	cHtml += '<div class="row" ' + IF( ::lDessign, 'style="border:1px solid red;"', '' ) + ' >' )

	FOR nI := 1 To len( ::aControls )
	
		IF Valtype( ::aControls[nI] ) == 'O'			
			cHtml += ::aControls[nI]:Activate()			
		ELSE		
			cHtml += ::aControls[nI]
		ENDIF
	
	NEXT			

RETU cHtml