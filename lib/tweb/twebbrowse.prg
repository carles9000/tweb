//	-------------------------------------------------------------
	
CLASS TWebBrowse FROM TWebControl


	DATA cId						INIT 'table'
	DATA oForm					
		
	DATA hCols						INIT {=>}
	DATA lAdd 						INIT .F.
	DATA lEdit						INIT .F.
	DATA cKey						INIT ''
	DATA cEditor					INIT ''
	DATA aBtn						INIT {}
	DATA lPrint						INIT .F.
	DATA lExport					INIT .F.
	DATA lSearch					INIT .F.
	DATA lMultiSelect				INIT .F.
	DATA lSingleSelect				INIT .F.
	DATA lClickSelect				INIT .F.
	DATA lTools						INIT .F.
	DATA lSmall						INIT .T.
	DATA lStripped					INIT .F.
	DATA lDark						INIT .F.
	DATA nHeight					INIT 400
	DATA cLocale					INIT "en-EN"
	DATA cData						INIT ''
	DATA cInit						INIT ''
	DATA cTitle						INIT ''
	DATA cPostEdit					INIT ''
	DATA cRowStyle					INIT ''
	DATA cToolbar					INIT ''


	METHOD New() 					CONSTRUCTOR
	METHOD SetData( aData )
	METHOD AddCol()
	
	
	METHOD Init( cVarJS )
	METHOD Activate()


ENDCLASS 

METHOD New( oParent, cId, nHeight, lSingleSelect, lMultiSelect, lClickSelect, lPrint, lExport, lSearch, lTools, cAction, cDblClick, lEdit, cKey, cEditor, cTitle, cPostEdit, cRowStyle, cToolbar ) CLASS TWebBrowse

	DEFAULT cId 			TO cId
	DEFAULT nHeight			TO 400
	DEFAULT lSingleSelect	TO .F.
	DEFAULT lMultiSelect	TO .F.
	DEFAULT lClickSelect	TO .F.
	DEFAULT lPrint			TO .T.
	DEFAULT lExport			TO .F.
	DEFAULT lSearch			TO .F.
	DEFAULT lTools			TO .F.
	DEFAULT cAction			TO ''
	DEFAULT cDblClick		TO ''
	DEFAULT lEdit			TO .F.
	DEFAULT cKey			TO ''
	DEFAULT cEditor			TO ''
	DEFAULT cTitle			TO ''
	DEFAULT cPostEdit		TO ''
	DEFAULT cRowStyle		TO ''
	DEFAULT cToolbar		TO ''


	::cId 				:= cId
	::nHeight 			:= nHeight
	::lSingleSelect 	:= lSingleSelect
	::lMultiSelect 		:= lMultiSelect
	::lClickSelect 		:= lClickSelect
	::lPrint 			:= lPrint
	::lExport 			:= lExport
	::lSearch 			:= lSearch
	::lTools 			:= lTools		
	::cAction 			:= cAction
	::cDblClick			:= cDblClick
	::lEdit				:= lEdit
	::cKey				:= cKey
	::cEditor			:= cEditor
	::cTitle 			:= cTitle
	::cPostEdit 		:= cPostEdit
	::cRowStyle 		:= cRowStyle
	::cToolbar 			:= cToolbar

	IF Valtype( oParent ) == 'O'	
		oParent:AddControl( SELF )	
	ENDIF

RETU SELF

METHOD AddCol( cId, hCfg, cHead, nWidth, lSortable, cAlign, cFormatter, cClass, lEdit, cEdit_Type, cEdit_With ) CLASS TWebBrowse

	LOCAL hDefCol	:= {=>}
	
	IF Valtype( hCfg ) == 'H'

		HB_HCaseMatch( hCfg, .F. ) 

		hDefCol[ 'id' ] 		:= HB_HGetDef( hCfg, 'id'		, cId ) 
		hDefCol[ 'head' ] 		:= HB_HGetDef( hCfg, 'head'		, cId ) 
		hDefCol[ 'width' ] 		:= HB_HGetDef( hCfg, 'width'	, '' ) 
		hDefCol[ 'sortable' ] 	:= HB_HGetDef( hCfg, 'sortable'	, .F. ) 
		hDefCol[ 'align' ]		:= HB_HGetDef( hCfg, 'align'	, '' ) 
		hDefCol[ 'formatter' ]	:= HB_HGetDef( hCfg, 'formatter'	, '' ) 
		hDefCol[ 'class' ]		:= HB_HGetDef( hCfg, 'class'	, '' ) 
		hDefCol[ 'edit' ]		:= HB_HGetDef( hCfg, 'edit'		, .f. ) 
		hDefCol[ 'edit_type' ]	:= HB_HGetDef( hCfg, 'edit_type', 'C' ) 
		hDefCol[ 'edit_with' ]	:= HB_HGetDef( hCfg, 'edit_with', '' ) 
	
	ELSE
	
		DEFAULT cHead 			TO cId
		DEFAULT nWidth 			TO ''
		DEFAULT lSortable		TO .F.
		DEFAULT cAlign			TO ''
		DEFAULT cFormatter		TO ''
		DEFAULT cClass			TO ''
		DEFAULT lEdit			TO .F.
		DEFAULT cEdit_Type		TO 'C'
		DEFAULT cEdit_With		TO ''
	
		hDefCol[ 'id' ] 		:= cId
		hDefCol[ 'head' ] 		:= cHead
		hDefCol[ 'width' ] 		:= nWidth
		hDefCol[ 'sortable' ] 	:= lSortable 	
		hDefCol[ 'align' ]		:= cAlign
		hDefCol[ 'formatter' ]	:= cFormatter
		hDefCol[ 'class' ]		:= cClass 
		hDefCol[ 'edit' ]		:= lEdit
		hDefCol[ 'edit_type' ]	:= upper( cEdit_Type )
		hDefCol[ 'edit_with' ]	:= cEdit_With
	
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
	local u 
	local lCombo, lLogic, lDate
	
	if ::lSmall
		cClass += 'table-sm '
	endif
	
	if ::lDark
		cClass += 'table-dark '
	endif
	
	if ::lStripped
		cClass += 'table-striped '
	endif
	
	IF !empty(::cClass)
		cClass += ' ' + ::cClass
	ENDIF	
	
//					data-multiple-select-row="{{ IF( oThis:lMultiSelect, 'true',  'false') }}"
//					data-single-select="{{ IF( oThis:lSingleSelect, 'true',  'false') }}"
//					data-toggle="{{ oThis:cId }}" 
//					data-multiple-select-row="false"

	/*
		Si data-multiple-select-row = true ->  Multiple select with ctrl-key/shift-key
		data-single-select = true , only one check, sino multiselect			
	*/	


	
	BLOCKS ADDITIVE cHtml PARAMS oThis, cClass
	
			<div class="col-12" style="padding:0px;">		<!-- //	ULL !!! Padding a pelo !!!!			-->
				<table id="{{ oThis:cId }}" class="{{ cClass }}"  
					data-single-select="{{ IF( oThis:lSingleSelect, 'true',  'false') }}"
					data-multiple-select-row="{{ IF( oThis:lMultiSelect, 'true',  'false') }}"
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
					data-unique-id="id"	
					data-row-style="{{ oThis:cRowStyle }}"										
					data-toolbar="{{ '#' + oThis:cToolbar }}"					
					>

					<thead  class="thead-dark">
						<tr>
							
							<!--<th data-field="_keyno" data-width="70" data-align="center">Id</th>-->
							
	ENDTEXT														
								IF ::lMultiSelect .OR. ::lSingleSelect
								
									cHtml += '<th data-field="state" data-checkbox="true" name="btSelectItem"></th>'									
								
								ENDIF
								
								lCombo := .F. 
								lLogic := .F. 
								lDate  := .F. 
							
								FOR n := 1 TO Len( ::hCols )
								
									aField 		:= HB_HPairAt( ::hCols, n )
									cField		:= aField[1]
									hDef 		:= aField[2]	
									
							
									cHtml += '<th data-field="' + cField + '" '
									cHtml += 'data-width="' + valtochar(hDef[ 'width' ]) + '" '
									cHtml += 'data-sortable="' + IF( hDef[ 'sortable' ], 'true', 'false' ) + '" '
									
									if !empty( hDef[ 'class' ] )										
										cHtml += 'data-cell-style="' + hDef[ 'class' ] + '" '
									endif
									
									if !empty( hDef[ 'formatter' ] )	
									
										cHtml += 'data-formatter="' + hDef[ 'formatter' ] + '" '
										
									else
									
										do case
											case  hDef[ 'edit_type' ] == 'COMBOBOX' 
											
												if empty( hDef[ 'formatter' ] )
													cHtml += 'data-formatter="TWebBrwFormatterCombo_' + ::cId + '" '

													if !lCombo 											
														lCombo := .T.
														?? '<script>' 
														??	"var __oBrw_" + ::cId + " = new Object();"																				
														?? '</script>' 																																																
													endif 
													
													u := hb_jsonencode( hDef[ 'edit_with' ] )
													
													?? '<script>' 											
													??	"__oBrw_" + ::cId + "[ '" + hDef[ 'id' ]  + "' ] = JSON.parse( '" + u + "' );"										
													?? '</script>' 											
													
												endif																																	
											
											case  hDef[ 'edit_type' ] == 'CHECKBOX' .OR. hDef[ 'edit_type' ] == 'L'
											
												if empty( hDef[ 'formatter' ] )
												
													if !lLogic
														lLogic := .T.
													endif
												
													cHtml += 'data-formatter="TWebBrwFormatterLogic_' + ::cId + '" '
													
													hDef[ 'align' ] = 'center'
													
												endif
												
											case  hDef[ 'edit_type' ] == 'D'
											
												if empty( hDef[ 'formatter' ] )
												
													if !lDate
														lDate := .T.
													endif
												
													cHtml += 'data-formatter="TWebBrwFormatterDate_' + ::cId + '" '
													
							
												endif												
											
										endcase
									
									endif
									
									cHtml += 'data-align="' + hDef[ 'align' ] + '" '
											
									
									cHtml += '>' + hDef[ 'head' ] + '</th>'							

								NEXT
								
								if lCombo 
									?? '<script>'
									?? 'function TWebBrwFormatterCombo_' + ::cId + '( value, a, b, cFieldName ) {'
									?? ' 	return __oBrw_' + ::cId + '[ cFieldName ][ value ]'
									?? '}'
									?? '</script>'
								endif
								
								if lLogic 
									?? '<script>'
									?? 'function TWebBrwFormatterLogic_' + ::cId + '( value, a, b, cFieldName ) {'						
									?? ' 	if (value) {'
									?? [ 		return '<i class="fas fa-check"></i>' ]
									?? "    } else { "
									?? " 		return '' "
									?? '    }'
									?? '}'
									?? '</script>'
								endif
								
								if lDate 
									?? '<script>'
									?? 'function TWebBrwFormatterDate_' + ::cId + '( value, a, b, cFieldName ) {'								
									?? "    var newDate = value.split('-').reverse().join('/'); "								
									?? '    return (newDate);'
									?? '}'
									?? '</script>'
								endif
								

	BLOCKS ADDITIVE cHtml
	
						</tr>
						
					</thead>
					
				</table>										
					
			</div>					

	ENDTEXT 
	
	IF !Empty( ::cData )
/*
		cHtml += '<script>'
		cHtml += "  console.log( 'INITDATA BROWSE => " + ::cId + "');"
		cHtml += "  var data = JSON.parse( '" + ::cData + "' );"
		cHtml += "  console.log( 'DATA', data );"
		cHtml += "  var $table = $('#" + ::cId + "');"
		cHtml += "  $table.bootstrapTable({data: data});"
		cHtml += "  console.log( 'FINAL', '===========================' );"
		cHtml += '</script>'
*/		
	
	ENDIF	

	cHtml += "<script>"
	cHtml += " var _oBrw = new TWebBrowse( '" + ::cId + "', null, false );"
	cHtml += " _oBrw.SetCfgCols( JSON.parse( '" + hb_jsonencode(::hCols) + "' ) );"

	cHtml += "</script>"
	

	cHtml += ::cInit


RETU cHtml


METHOD Init( cVarJS, aRows ) CLASS TWebBrowse

	local cVar		:= '_' + ::cId
	local cRows

	IF cVarJS == NIL
		cVarJS	:= '_' + ::cId
	ENDIF	

 
	
	::cInit += '<script>'													+ CRLF

	::cInit += 'var ' + cVarJS + ' = new TWebBrowse( "' + ::cId + '", null, false );'	+ CRLF			
	::cInit += '$(document).ready(function () {	'							+ CRLF
	
	
		
		if !Empty( ::cTitle ) 	
			::cInit += cVarJS + ".cTitle = '" + ::cTitle + "'; "
		endif
		
		if !Empty( ::cPostEdit ) 	
			::cInit += cVarJS + ".bPostEdit = '" + ::cPostEdit + "'; "
		endif
		

		if !Empty( ::cAction ) 	
			::cInit += cVarJS + ".bClick = '" + ::cAction + "'; "
		endif
		
		if ::lEdit 
		
			::cInit += cVarJS + ".lEdit = true;" 							+ CRLF
			
			if !Empty( ::cEditor )
				::cInit += cVarJS + ".bEditor = " + ::cEditor + "; "		+ CRLF						
			endif
		
		else 
		
			if !Empty( ::cDblClick ) 	
				::cInit += cVarJS + ".bDblClick = " + ::cDblClick + "; "
			endif		
		
		endif		
		
		//	----------------------------------------

	::cInit += cVarJS + '.Init();'									+ CRLF

	IF Valtype( aRows ) == 'A'
		cRows 	:=  hb_jsonencode(aRows)
		::cInit += "	var aRows = JSON.parse( '" + cRows + "' );	"		+ CRLF
		::cInit += "	" + cVarJS + '.SetData( aRows ); 	'				+ CRLF
	ENDIF
	
	::cInit += '})'															+ CRLF
	::cInit += '</script>'													+ CRLF

RETU NIL 