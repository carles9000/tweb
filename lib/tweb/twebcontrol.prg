#include 'hbclass.ch'
#include 'common.ch'


CLASS TWebControl

	DATA oParent					
	DATA aControls					INIT {}
	DATA aHtml						INIT {}
	DATA cId						INIT ''
	DATA uValue						INIT ''
	DATA cLabel						INIT ''
	DATA lDessign					INIT .F.
	DATA nGrid						INIT 4
	DATA lReadOnly					INIT .F.
	DATA lDisabled					INIT .F.
	DATA cAlign						INIT 'left'
	DATA cAction					INIT ''
	DATA cClass						INIT ''	
	DATA cIcon						INIT ''
		
    METHOD New()					CONSTRUCTOR
	
	METHOD Html( cCode ) 			INLINE Aadd( ::aControls, cCode )
	METHOD AddControl( uValue )		INLINE Aadd( ::aControls, uValue )
	METHOD End() 					INLINE ::Html( '</div>' )	
	
ENDCLASS

METHOD New() CLASS TWebControl

RETU SELF
