//	-------------------------------------------------------------
	
CLASS TWebBrowse FROM TWebControl


	DATA cId						INIT 'table'
	DATA oForm					
		
	DATA hCols						INIT {=>}
	DATA lAdd 						INIT .F.
	DATA lEdit						INIT .F.
	DATA aBtn						INIT {}
	DATA lPrint						INIT .F.
	DATA lExport					INIT .F.
	DATA lSearch					INIT .F.
	DATA lMultiSelect				INIT .F.
	DATA lSingleSelect				INIT .F.
	DATA lClickSelect				INIT .F.
	DATA lTools						INIT .F.
	DATA lSmall						INIT .T.
	DATA lDark						INIT .F.
	DATA nHeight					INIT 400
	DATA cLocale					INIT "en-EN"
	DATA cData						INIT ''
	DATA cInit						INIT ''

	METHOD New() 					CONSTRUCTOR
	METHOD SetData( aData )
	METHOD AddCol()
	
	
	METHOD Init( cVarJS )
	METHOD Activate()


ENDCLASS 

METHOD New( oParent, cId, nHeight, lSingleSelect, lMultiSelect, lClickSelect, lPrint, lExport, lSearch, lTools, cAction, cDblClick ) CLASS TWebBrowse

	DEFAULT cId 			TO cId
	DEFAULT nHeight		TO 400
	DEFAULT lSingleSelect	TO .F.
	DEFAULT lMultiSelect	TO .F.
	DEFAULT lClickSelect	TO .F.
	DEFAULT lPrint			TO .T.
	DEFAULT lExport		TO .F.
	DEFAULT lSearch		TO .F.
	DEFAULT lTools			TO .F.
	DEFAULT cAction		TO ''
	DEFAULT cDblClick		TO ''

	::cId 				:= cId
	::nHeight 			:= nHeight
	::lSingleSelect 	:= lSingleSelect
	::lMultiSelect 	:= lMultiSelect
	::lClickSelect 	:= lClickSelect
	::lPrint 			:= lPrint
	::lExport 			:= lExport
	::lSearch 			:= lSearch
	::lTools 			:= lTools		
	::cAction 			:= cAction
	::cDblClick		:= cDblClick

	IF Valtype( oParent ) == 'O'	
		oParent:AddControl( SELF )	
	ENDIF

RETU SELF

METHOD AddCol( cId, hCfg, cHead, nWidth, lSortable, cAlign, cFormatter, cClass ) CLASS TWebBrowse

	LOCAL hDefCol	:= {=>}
	
	IF Valtype( hCfg ) == 'H'

		HB_HCaseMatch( hCfg, .F. ) 

		hDefCol[ 'head' ] 		:= HB_HGetDef( hCfg, 'head'		, cId ) 
		hDefCol[ 'width' ] 	:= HB_HGetDef( hCfg, 'width'	, '' ) 
		hDefCol[ 'sortable' ] 	:= HB_HGetDef( hCfg, 'sortable'	, .F. ) 
		hDefCol[ 'align' ]		:= HB_HGetDef( hCfg, 'align'	, '' ) 
		hDefCol[ 'formatter' ]	:= HB_HGetDef( hCfg, 'formatter'	, '' ) 
		hDefCol[ 'class' ]		:= HB_HGetDef( hCfg, 'class'	, '' ) 
	
	ELSE
	
		DEFAULT cHead 			TO cId
		DEFAULT nWidth 		TO ''
		DEFAULT lSortable		TO .F.
		DEFAULT cAlign			TO ''
		DEFAULT cFormatter		TO ''
		DEFAULT cClass			TO ''
	
		hDefCol[ 'head' ] 		:= cHead
		hDefCol[ 'width' ] 	:= nWidth
		hDefCol[ 'sortable' ] 	:= lSortable 	
		hDefCol[ 'align' ]		:= cAlign
		hDefCol[ 'formatter' ]	:= cFormatter
		hDefCol[ 'class' ]		:= cClass 
	
	ENDIF
	
	
	::hCols[ cId ] := hDefCol		

RETU NIL

METHOD SetData( aData ) CLASS TWebBrowse

	::cData := hb_jsonencode( aData )	
	
RETU NIL

METHOD Activate() CLASS TWebBrowse

	local oThis			:= SELF
	local cHtml 			:= ''	
	local cClass 			:= ''
	local nWidth  			:= 0	
	local n, cField, hDef, aField
	
	if ::lSmall
		cClass += 'table-sm '
	endif
	
	if ::lDark
		cClass += 'table-dark '
	endif
	
	IF !empty(::cClass)
		cClass += ' ' + ::cClass
	ENDIF	
	
	BLOCKS ADDITIVE cHtml PARAMS oThis, cClass
	
			<div class="col-12" style="padding:0px;">		<!-- //	ULL !!! Padding a pelo !!!!			-->
				<table id="{{ oThis:cId }}" class="{{ cClass }}"  
					data-multiple-select-row="{{ IF( oThis:lMultiSelect, 'true',  'false') }}"
					data-single-select="{{ IF( oThis:lSingleSelect, 'true',  'false') }}"
					data-click-to-select="{{ IF( oThis:lClickSelect, 'true',  'false') }}"
					data-height="{{ oThis:nHeight }}"
					data-locale="{{ oThis:cLocale }}"
					data-search="{{ IF( oThis:lSearch, 'true',  'false') }}"
					data-search-time-out="200"
					data-search-align="right"
					data-show-search-clear-button="true"
					data-show-toggle="{{ IF( oThis:lTools, 'true',  'false') }}"
					data-show-fullscreen="{{ IF( oThis:lTools, 'true',  'false') }}"
					data-show-columns="{{ IF( oThis:lTools, 'true',  'false') }}"
					data-show-print="{{ IF( oThis:lPrint, 'true',  'false') }}"
					data-show-export="{{ IF( oThis:lExport, 'true',  'false') }}"
					>

					<thead  class="thead-dark">
						<tr>
							
							<!--<th data-field="_keyno" data-width="70" data-align="center">Id</th>-->
							
	ENDTEXT														
							
								IF ::lMultiSelect .OR. ::lSingleSelect
								
									cHtml += '<th data-field="st" data-checkbox="true"></th>'
								
								ENDIF							
							
								FOR n := 1 TO Len( ::hCols )
								
									aField 		:= HB_HPairAt( ::hCols, n )
									cField		:= aField[1]
									hDef 		:= aField[2]	
									
									cHtml += '<th data-field="' + cField + '" '
									cHtml += 'data-width="' + valtochar(hDef[ 'width' ]) + '" '
									cHtml += 'data-sortable="' + IF( hDef[ 'sortable' ], 'true', 'false' ) + '" '
									cHtml += 'data-align="' + hDef[ 'align' ] + '" '
									cHtml += 'data-formatter="' + hDef[ 'formatter' ] + '" '
									cHtml += '>' + hDef[ 'head' ] + '</th>'							
									
								NEXT																																			

	BLOCKS ADDITIVE cHtml
	
						</tr>
						
					</thead>
					
				</table>										
					
			</div>					

	ENDTEXT 
	
	IF !Empty( ::cData )

		cHtml += '<script>'
		cHtml += "  console.log( 'INITDATA');"
		cHtml += "  var data = JSON.parse( '" + ::cData + "' );"
		cHtml += "  console.log( 'DATA', data );"
		cHtml += "  var $table = $('#" + ::cId + "');"
		cHtml += "  $table.bootstrapTable({data: data});"
		cHtml += "  console.log( 'FINAL', '===========================' );"
		cHtml += '</script>'
	
	ENDIF			

	cHtml += ::cInit
	

RETU cHtml


METHOD Init( cVarJS, aRows ) CLASS TWebBrowse

	local cVar		:= '_' + ::cId
	local cRows

	IF cVarJS == NIL
		cVarJS	:= '_' + ::cId
	ENDIF	

	::cInit += '<script>'													+ CRLF

	::cInit += 'var ' + cVarJS + ' = new TWebBrowse( "' + ::cId + '" );'	+ CRLF			
	::cInit += '$(document).ready(function () {	'							+ CRLF
	
		IF !Empty( ::cAction ) 
			::cInit += '   '  + cVarJS + '.bClick = ' + ::cAction + ' ' + CRLF
		ENDIF
		
		IF !Empty( ::cDblClick ) 
			::cInit += '   '  + cVarJS + '.bDblClick = ' + ::cDblClick + ' ' + CRLF
		ENDIF		
		
	::cInit += '    ' + cVarJS + '.Init();'									+ CRLF

	IF Valtype( aRows ) == 'A'
		cRows 	:=  hb_jsonencode(aRows)
		::cInit += "	var aRows = JSON.parse( '" + cRows + "' );	"		+ CRLF
		::cInit += "	" + cVarJS + '.SetData( aRows ); 	'				+ CRLF
	ENDIF
	
	::cInit += '})'															+ CRLF
	::cInit += '</script>'													+ CRLF

RETU NIL 