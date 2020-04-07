#include 'hbclass.ch'
#include 'common.ch'

CLASS TWebSwitch FROM TWebControl

	METHOD New() 					CONSTRUCTOR
	METHOD Activate()


ENDCLASS 

METHOD New( oParent, cId, lValue, cLabel, nGrid, cAction  ) CLASS TWebSwitch

	DEFAULT cId TO ''
	DEFAULT lValue TO .F.
	DEFAULT nGrid TO 4
	DEFAULT cLabel TO ''
	DEFAULT cAction TO ''
	
	::oParent		:= oParent
	::cId			:= cId
	::uValue 		:= IF( lValue, .T., .F. )
	::cLabel 		:= cLabel
	::nGrid			:= nGrid
	::cAction		:= cAction

	IF Valtype( oParent ) == 'O'
	
		oParent:AddControl( SELF )
	
	ENDIF

RETU SELF


METHOD Activate() CLASS TWebSwitch

	LOCAL cHtml 	:= ''
	LOCAL cChecked	:= ''
	
	IF ::uValue
		cChecked := 'checked'
	ENDIF	

	cHtml := '<div class="col-' + ltrim(str(::nGrid)) + ' custom-control custom-switch tweb_switch' + IF( ::oParent:lDessign, ' tweb_dessign', '')  + '" ' + IF( ::oParent:lDessign, 'style="border:1px solid blue;"', '' )   + ' >'
	cHtml += '<input type="checkbox" class="custom-control-input" id="' + ::cId + '" ' + cChecked 
	cHtml += ' onclick="' + ::cAction + '" ' 
	cHtml += '>' 
	
	IF !empty( ::cLabel )
	
		cHtml += '<label class="custom-control-label" for="' + ::cId + '">' + ::cLabel + '</label>'
	
	ENDIF	

	cHtml += '</div>'

RETU cHtml