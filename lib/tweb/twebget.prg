#include 'hbclass.ch'
#include 'common.ch'

CLASS TWebGet FROM TWebControl

	DATA cType		 				INIT 'text'
	DATA cPlaceHolder 				INIT ''
	DATA cBtnLabel 					INIT ''
	DATA cBtnAction 				INIT ''


	METHOD New() 					CONSTRUCTOR
	METHOD Activate()


ENDCLASS 

METHOD New( oParent, cId, uValue, nGrid, cLabel, cAlign, lReadOnly, cType, cPlaceHolder, cBtnLabel, cBtnAction, lRequired  ) CLASS TWebGet

	DEFAULT cId TO ''
	DEFAULT uValue TO ''
	DEFAULT nGrid TO 4
	DEFAULT cLabel TO ''
	DEFAULT cAlign TO ''
	DEFAULT lReadOnly TO .F.
	DEFAULT cType TO 'text'
	DEFAULT cPlaceHolder TO ''
	DEFAULT cBtnLabel TO ''
	DEFAULT cBtnAction TO '&nbsp;'	
	DEFAULT lRequired TO .F.	
	
	::oParent 		:= oParent
	::cId			:= cId
	::uValue		:= uValue
	::nGrid			:= nGrid
	::cLabel 		:= cLabel
	::cAlign 		:= cAlign
	::lReadOnly		:= lReadOnly
	::cType			:= cType
	::cPlaceHolder 	:= cPlaceHolder
	::cBtnLabel		:= cBtnLabel
	::cBtnAction	:= cBtnAction	
	::lRequired		:= lRequired

	IF Valtype( oParent ) == 'O'	
		oParent:AddControl( SELF )	
	ENDIF

RETU SELF

METHOD Activate() CLASS TWebGet

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
	
	cHtml += '<div class="input-group">'
	
	cHtml += '<input type="' + ::cType + '" class="form-control ' + cSize + '" '
	cHtml += 'id="' + ::cId + '"	 name="' + ::cId + '" ' 
	cHtml += 'placeholder="' + ::cPlaceHolder + '" ' 
	
	IF ::lReadOnly
		cHtml += ' readonly '
	ENDIF
	
	IF ::lRequired
		cHtml += ' required '
	ENDIF	
	
	cHtml += ' value="' + ::uValue + '">'

	IF !empty( ::cBtnLabel )
	
		cHtml += '<div class="input-group-append">'
		
		cHtml += '<button class="btn btn-outline-secondary" type="button" onclick="' + ::cBtnAction + '">'
		cHtml += ::cBtnLabel
		cHtml += '</button>'
		
		cHtml += '</div>'			
	
	ENDIF
	
	
	cHtml += '	</div>'
	cHtml += '</div>'

	
	
/*	
	DO CASE
		CASE hCtrl[ 'align' ] == 'center' ; cHtml += ' text-center '
		CASE hCtrl[ 'align' ] == 'right'  ; cHtml += ' text-right '						
	ENDCASE	
*/	

	
	//Aadd( ::aHtml, cHtml )		


RETU cHtml