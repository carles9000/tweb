//	-------------------------------------------------------------

CLASS TWebSelect FROM TWebControl

	
	DATA aItems						INIT {}
	DATA aValues					INIT {}

	METHOD New() 					CONSTRUCTOR
	METHOD Activate()


ENDCLASS 

METHOD New( oParent, cId, uValue, aItems, aValues, nGrid, cAction, cLabel  ) CLASS TWebSelect

	DEFAULT cId TO ''
	DEFAULT aItems TO {}
	DEFAULT aValues TO {}
	DEFAULT nGrid TO 4
	DEFAULT cAction TO ''
	DEFAULT cLabel TO ''
	DEFAULT uValue TO ''
	

	::oParent 		:= oParent	
	::cId			:= cId
	::aItems 		:= IF( valtype( aItems ) == 'A', aItems, {} )
	::aValues		:= IF( valtype( aValues ) == 'A' .AND. len( aValues ) == len( aItems ), aValues, aItems )
	::nGrid			:= nGrid
	::cAction		:= cAction
	::cLabel		:= cLabel
	::uValue		:= uValue 
	

	IF Valtype( oParent ) == 'O'	
		oParent:AddControl( SELF )	
	ENDIF

RETU SELF


METHOD Activate() CLASS TWebSelect

	LOCAL cHtml 	:= ''
	LOCAL cChecked	:= ''
	LOCAL nI
	LOCAL cSize := ''
	
	DO CASE
		CASE upper(::oParent:cSizing) == 'SM' ; cSize := 'form-control-sm'
		CASE upper(::oParent:cSizing) == 'LG' ; cSize := 'form-control-lg'
	ENDCASE		

	cHtml := '<div class="col-' + ltrim(str(::nGrid)) + IF( ::oParent:lDessign, ' tweb_dessign', '') + '" ' + IF( ::oParent:lDessign, 'style="border:1px solid blue;"', '' )   + ' >'

	IF !empty( ::cLabel )
	
		cHtml += '<label for="' + ::cId + '">' + ::cLabel + '</label>'
	
	ENDIF	
	
	cHtml += '<div class="input-group">'	
	
	//cHtml += '<select class="col-' + ltrim(str(::nGrid)) + ' custom-select form-control ' + cSize + '" id="' + ::cId + '" onchange="' + ::cAction + '" >'
	//cHtml += '<select class="col-' + ltrim(str(::nGrid)) + ' form-control ' + cSize + IF( ::oParent:lDessign, ' tweb_dessign', '')  + '" ' + IF( ::oParent:lDessign, 'style="border:1px solid blue;"', '' ) + ' id="' + ::cId + '" onchange="' + ::cAction + '" >'
	cHtml += '<select class="col-12 form-control ' + cSize + IF( ::oParent:lDessign, ' tweb_dessign', '')  + '" ' + IF( ::oParent:lDessign, 'style="border:1px solid blue;"', '' ) + ' id="' + ::cId + '" name="' + ::cId + '" onchange="' + ::cAction + '" >'
	
	FOR nI := 1 TO len( ::aItems )
	
		cHtml += '<option value="' + ::aValues[nI] + '" ' 			
		
		IF ::uValue == ::aValues[nI] 
			cHtml += ' selected '					
		ENDIF
		
		cHtml += '>' + ::aItems[nI] 		
		cHtml += '</option>'			
		
	NEXT	

	cHtml += '</select>' 
	
	cHtml += '	</div>'
	cHtml += '</div>'	

RETU cHtml