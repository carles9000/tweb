//	-------------------------------------------------------------
	
CLASS TWebBrowse FROM TWebControl


	DATA cId						INIT 'table'
	DATA oForm					
		
	DATA hCols						INIT {=>}
	DATA lAdd 						INIT .F.
	DATA lEdit						INIT .F.
	DATA cUniqueId					INIT ''
	DATA cEditor					INIT ''
	DATA aBtn						INIT {}
	DATA lPrint						INIT .F.
	DATA lExport					INIT .F.
	DATA lSearch					INIT .F.
	DATA lMultiSelect				INIT .F.
	DATA lSingleSelect				INIT .F.
	DATA lRadio						INIT .F.
	DATA lClickSelect				INIT .F.
	DATA lVirtualScroll				INIT .F.	//	if .T. can flickering with vertical scrollbar
	DATA lTools						INIT .F.
	DATA lSmall						INIT .T.
	DATA lStripped					INIT .F.
	DATA lDark						INIT .F.
	DATA nHeight					INIT 400
	DATA cLocale					INIT "en-EN"
	DATA cData						INIT ''
	DATA cInit						INIT ''
	DATA cTitle						INIT ''
	DATA cPreEdit					INIT ''
	DATA cPostEdit					INIT ''
	DATA cRowStyle					INIT ''
	DATA cToolbar					INIT ''
	
	DATA cPag_Url					INIT ''	
	DATA lPag_UseIntermediate		INIT .F.
	
	

	METHOD New() 					CONSTRUCTOR
	METHOD SetData( aData )
	METHOD AddCol()
	
	
	METHOD Init( cVarJS )
	METHOD Activate()


ENDCLASS 

METHOD New( oParent, cId, nHeight, lSingleSelect, lRadio, lMultiSelect, lClickSelect, lPrint, lExport, lSearch, lTools, cAction, cDblClick, lEdit, cUniqueId, cEditor, cTitle, cPreEdit, cPostEdit, cRowStyle, cToolbar, cPag_Url, lPag_UseIntermediate ) CLASS TWebBrowse

	DEFAULT cId 					TO cId
	DEFAULT nHeight				TO 400
	DEFAULT lSingleSelect			TO .F.
	DEFAULT lRadio					TO .F.
	DEFAULT lMultiSelect			TO .F.
	DEFAULT lClickSelect			TO .F.
	DEFAULT lPrint					TO .T.
	DEFAULT lExport				TO .F.
	DEFAULT lSearch				TO .F.
	DEFAULT lTools					TO .F.
	DEFAULT cAction				TO ''
	DEFAULT cDblClick				TO ''
	DEFAULT lEdit					TO .F.
	DEFAULT cUniqueId				TO ''
	DEFAULT cEditor				TO ''
	DEFAULT cTitle					TO ''
	DEFAULT cPreEdit				TO ''
	DEFAULT cPostEdit				TO ''
	DEFAULT cRowStyle				TO ''
	DEFAULT cToolbar				TO ''
	DEFAULT cPag_Url				TO ''	
	DEFAULT lPag_UseIntermediate	TO .F.



	::cId 							:= cId
	::nHeight 						:= nHeight
	::lSingleSelect 				:= lSingleSelect
	::lRadio 						:= lRadio
	::lMultiSelect 				:= lMultiSelect
	::lClickSelect 				:= lClickSelect
	::lPrint 						:= lPrint
	::lExport 						:= lExport
	::lSearch 						:= lSearch
	::lTools 						:= lTools		
	::cAction 						:= cAction
	::cDblClick					:= cDblClick
	::lEdit							:= lEdit
	::cUniqueId					:= cUniqueId
	::cEditor						:= cEditor
	::cTitle 						:= cTitle
	::cPreEdit 					:= cPreEdit
	::cPostEdit 					:= cPostEdit
	::cRowStyle 					:= cRowStyle
	::cToolbar 					:= cToolbar
	::cPag_Url						:= cPag_Url				
	::lPag_UseIntermediate    	:= lPag_UseIntermediate
	
	

	IF Valtype( oParent ) == 'O'	
		oParent:AddControl( SELF )	
	ENDIF
	


RETU SELF

METHOD AddCol( cId, hCfg, cHead, nWidth, lSortable, cAlign, cFormatter, cClass, lEdit, cEdit_Type, cEdit_With, lEdit_Escape, cClass_Event ) CLASS TWebBrowse

	LOCAL hDefCol	:= {=>}
	
	IF Valtype( hCfg ) == 'H'

		HB_HCaseMatch( hCfg, .F. ) 

		hDefCol[ 'id' ] 			:= HB_HGetDef( hCfg, 'id'		, cId ) 
		hDefCol[ 'head' ] 			:= HB_HGetDef( hCfg, 'head'		, cId ) 
		hDefCol[ 'width' ] 			:= HB_HGetDef( hCfg, 'width'	, '' ) 
		hDefCol[ 'sortable' ] 		:= HB_HGetDef( hCfg, 'sortable'	, .F. ) 
		hDefCol[ 'align' ]			:= HB_HGetDef( hCfg, 'align'	, '' ) 
		hDefCol[ 'formatter' ]		:= HB_HGetDef( hCfg, 'formatter'	, '' ) 
		hDefCol[ 'class' ]			:= HB_HGetDef( hCfg, 'class'	, '' ) 
		hDefCol[ 'edit' ]			:= HB_HGetDef( hCfg, 'edit'		, .f. ) 
		hDefCol[ 'edit_type' ]		:= HB_HGetDef( hCfg, 'edit_type', 'C' ) 
		hDefCol[ 'edit_with' ]		:= HB_HGetDef( hCfg, 'edit_with', '' ) 
		hDefCol[ 'edit_escape' ]	:= HB_HGetDef( hCfg, 'edit_escape', .f. ) 
		hDefCol[ 'class_event' ]	:= HB_HGetDef( hCfg, 'class_event', '' ) 
		
	
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
		DEFAULT lEdit_Escape	TO .f.
		DEFAULT cClass_Event	TO ''
		
	
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
		hDefCol[ 'edit_escape' ]:= lEdit_Escape
		hDefCol[ 'class_event' ]:= cClass_Event 
		
	
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
	local lSelect 			:= .F. 
	
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


	/*
		Si data-multiple-select-row = true ->  Multiple select with ctrl-key/shift-key
		data-single-select = true , only one check, sino multiselect	+ toglee	
	*/	
	
	if  oThis:lMultiSelect .and. oThis:lSingleSelect 
		oThis:lSingleSelect   := .F.
		oThis:lMultiSelect 	:= .F.
		lSelect 				:= .T.
	endif 			
	

	BLOCKS ADDITIVE cHtml PARAMS oThis, cClass, lSelect
	
			<div class="col-12" style="padding:0px;">		<!-- //	ULL !!! Padding a pelo !!!!			-->
				<table id="{{ oThis:cId }}" class="{{ cClass }}"  
					data-toggle="{{ oThis:cId }}"				
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
					data-row-style="{{ oThis:cRowStyle }}"																			
					data-virtual-scroll="{{ IF( oThis:lVirtualScroll, 'true',  'false') }}"																			
	ENDTEXT					

			
					if !empty( ::cToolbar ) 					
						cHtml += 'data-toolbar="#' + ::cToolbar + '" '
					endif
					
					if !empty( ::cUniqueId ) 					
						cHtml += 'data-unique-id="' + ::cUniqueId + '" '
					endif

					
	//	Pagination 
	
		/*
		
			var options = { 
				url: "srv_brw_pag.prg", 
				sidePagination: "server",
				pagination: true,
				queryParams: MyQuery,
				queryParamsType: 'limit',
				pageList : [10, 25, 50, 100],	//	[10, 25, 50, 100, 200, 'All'],
				paginationUseIntermediate: true,
				//paginationParts: []
			}	

			$table.bootstrapTable('refreshOptions', options )	
		
		*/

		if !empty( ::cPag_Url ) 
		
			cHtml += 'data-url="' + ::cPag_Url  + '" '
			cHtml += 'data-side-pagination="server" '
			cHtml += 'data-pagination="true" '
			
			//if !empty( ::cPag_Query ) 
			//	cHtml += 'data-query-params="' + ::cPag_Query + '" '
			//endif
			
			if ::lPag_UseIntermediate		
				cHtml += 'data-pagination-use-intermediate="true" '
			endif 
			
		endif
				
				
	
	BLOCKS ADDITIVE cHtml
				> 	<!-- end table -->

					<thead  class="thead-dark">
						<tr>																					
	ENDTEXT														
								IF ::lMultiSelect .OR. ::lSingleSelect .OR. lSelect 																
								
									cHtml += '<th data-field="_st" data-checkbox="true" data-radio="' + If( ::lRadio, 'true', 'false' ) + '" name="btSelectItem"></th>'
									
									//cHtml += '<th data-field="$index" data-checkbox="true" name="btSelectItem"></th>'									
								
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
									//cHtml += 'data-escape="false" '
									
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

											case  hDef[ 'edit_type' ] == 'B'

												//if ! empty( hDef[ 'edit_action' ] ) .and. 
													//cHtml += 'data-events="TWebOperateEvents" '
												//endif
											
										endcase
									
									endif
									
									if !empty( hDef[ 'class_event' ] )
										cHtml += 'data-events="TWebOperateEvents" '
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
									?? '    if ( value ) {'								
									?? "      var newDate = value.split('-').reverse().join('/'); "								
									?? '      return (newDate);'
									?? '    } else {'
									?? "      return '';"
									?? '    }'
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
/*
	cHtml += "<script>"
	cHtml += " var _oBrw = new TWebBrowse( '" + ::cId + "', null, false );"
	cHtml += " _oBrw.SetCfgCols( JSON.parse( '" + hb_jsonencode(::hCols) + "' ) );"
	cHtml += "</script>"
*/	
	

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
	::cInit += cVarJS + ".SetCfgCols( JSON.parse( '" + hb_jsonencode(::hCols) + "' ) );"
	
	if !empty( ::cPag_Url )  
		::cInit += 'function _tweb_query(params){ ' + CRLF
		::cInit += '  params.search=""; ' + CRLF
		::cInit += '  return params; ' + CRLF
		::cInit += '}' + CRLF
	endif

	::cInit += '$(document).ready(function () {	'							+ CRLF
	
		if !Empty( ::cUniqueId ) 				
			::cInit += cVarJS + ".Set( 'uniqueid', '" + ::cUniqueId  + "'); "
		endif	
		
		if !Empty( ::cTitle ) 	
			//::cInit += cVarJS + ".cTitle = '" + ::cTitle + "'; "
			::cInit += cVarJS + ".Set( 'title', '" + ::cTitle + "'); "
			
		endif
		
		if !Empty( ::cPreEdit ) 	
			::cInit += cVarJS + ".Set( 'preedit', '" + ::cPreEdit + "'); "		
		endif		
		
		if !Empty( ::cPostEdit ) 	
			::cInit += cVarJS + ".Set( 'postedit', '" + ::cPostEdit + "'); "		
		endif
		

		if !Empty( ::cAction ) 				
			::cInit += cVarJS + ".Set( 'click', '" + ::cAction + "'); "		
		endif
		
		if ::lEdit 

			::cInit += cVarJS + ".Set( 'edit', true ); "					+ CRLF 
			
			if !Empty( ::cEditor )				
				::cInit += cVarJS + ".Set( 'editor', '" + ::cEditor + "'); "	+ CRLF 
			endif
		
		else 
		
			::cInit += cVarJS + ".Set( 'edit', false ); "					+ CRLF 
			
			if !Empty( ::cDblClick ) 	
				::cInit += cVarJS + ".Set( 'dblclick', '" + ::cDblClick + "'); "
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

//	-------------------------------------------------------------------------------

//	-----------------------------------------------------------------------------

CLASS TBrwDataset

	DATA cAlias							INIT ''
	DATA aError							INIT {}
	DATA aFields						INIT {}
	DATA bBeforeSave					INIT NIL 
	
	METHOD New( cAlias ) 				CONSTRUCTOR
	METHOD Alias()						INLINE ::cAlias
	METHOD Row()	
	METHOD Field( cField, cType )	
	METHOD Save( aRows )	
	METHOD SaveRow( aRows )		
	METHOD ValidRow( hRow )		
	METHOD ReadRow( hRow )	
	METHOD SetError( cError )		
	METHOD GetError()					INLINE ::aError 
	METHOD GetErrorString()	
	
ENDCLASS

METHOD New( cAlias ) CLASS TBrwDataset 

	DEFAULT cAlias TO ''

	::cAlias := cAlias 		
	
RETU Self 

METHOD Field( cField, lUpdate, bValidate, lEscape ) CLASS TBrwDataset 

	local oItem 	:= {=>}
	
	
	DEFAULT lUpdate TO .F.
	DEFAULT lEscape TO .T.
	
	oItem[ 'field' ] 		:= cField 	
	oItem[ 'field_pos' ] 	:= (::cAlias)->( FIELDPOS( cField ) )
	oItem[ 'field_type' ] 	:= ValType(FieldGet( (::cAlias)->( FIELDPOS( cField ) )))
	oItem[ 'update' ] 		:= lUpdate
	oItem[ 'validate' ] 	:= bValidate
	oItem[ 'escape' ] 		:= lEscape
	
	
	Aadd( ::aFields, oItem )

RETU nil

METHOD Row() CLASS TBrwDataset 

	local hRow := {=>}
	local nLen := len( ::aFields )
	local nI, cField, cField_Type,  uValue
	local cFormat := Set( _SET_DATEFORMAT, 'YYYY-MM-DD' )

	
	hRow[ '_recno' ] := (::cAlias)->( Recno() )
	
	for nI := 1 to nLen  
	
		cField 		 	:= ::aFields[nI][ 'field' ]
		cField_Type 	:= ::aFields[nI][ 'field_type' ]		
		
		do case
			//case cField_Type == 'C'  ; uValue := alltrim((::cAlias)->( FieldGet( ::aFields[nI][ 'field_pos' ] ) ))
			case cField_Type == 'C'  
				uValue := alltrim((::cAlias)->( FieldGet( ::aFields[nI][ 'field_pos' ] ) )) 
				
				if ::aFields[nI][ 'escape' ]
					uValue := UHtmlEncode( uValue )
				endif
				
			case cField_Type == 'D'  ; uValue := DToC( (::cAlias)->( FieldGet( ::aFields[nI][ 'field_pos' ] ) ) )
			otherwise
				uValue := (::cAlias)->( FieldGet( ::aFields[nI][ 'field_pos' ] ) )
		endcase
		
		hRow[ cField ] := uValue 
	
	next
	
	Set( _SET_DATEFORMAT, cFormat )

RETU hRow 

METHOD Save( aRows ) CLASS TBrwDataset 

	local nRows 		:= len( aRows )
	local nUpdated 		:= 0
	local aRowsUpdated 	:= {}
	local cFormat 		:= Set( _SET_DATEFORMAT, 'YYYY-MM-DD' )
	local nI, cAction, hRow, lValid, lUpdated, cId, nRecno  

	for nI := 1 to nRows 

		cAction := aRows[ nI ][ 'action' ]
		cId 	 := aRows[ nI ][ 'id' ]
		hRow 	 := aRows[ nI ][ 'row' ]
		nRecno  := 0
		
		lValid		:= .T.

		if valtype( ::bBeforeSave ) == 'B' 	
			lValid := eval( ::bBeforeSave, Self, hRow, cAction )
		endif
		
		if lValid 
		
			lUpdated := .F. 
		
			do case
			
				case cAction == 'A' 
				
					::ReadRow( hRow )
				
					if ::ValidRow( hRow ) 
				
						(::cAlias)->( DbAppend() )
					
						lUpdated := ::SaveRow( hRow )
						
						if lUpdated 
							nRecno := (::cAlias)->( Recno() )
						endif
						
					endif
					
				case cAction == 'U'
				
					::ReadRow( hRow )
				
					if ::ValidRow( hRow ) 				
				
						(::cAlias)->( DbGoTo( hRow[ '_recno' ] ) )
						
						if (::cAlias)->( DbRlock() )
							lUpdated := ::SaveRow( hRow )
							
							if lUpdated 
								nRecno := (::cAlias)->( Recno() )
							endif
							
						endif
						
					endif 
					
				case cAction == 'D'
				
					(::cAlias)->( DbGoTo( hRow[ '_recno' ] ) )
					
					if (::cAlias)->( DbRlock() )				
						(::cAlias)->( DbDelete() )				
						lUpdated := .T.				
					endif															
			
			endcase 
			
			if lUpdated
				nUpdated++
				Aadd( aRowsUpdated, { 'id' => cId, 'action' => cAction, 'value' => nRecno } )
			endif

		endif 
	
	next
	
	Set( _SET_DATEFORMAT, cFormat )

RETU aRowsUpdated

METHOD SaveRow( hRow ) CLASS TBrwDataset 

	local nLen := len( ::aFields )
	local hValues 	:= {=>}
	local lValid 	:= .t.
	local nI, cField, cField_Type, nField_Pos, uValue, lUpdate, bValid
	LOCAL bErrorHandler, bLastHandler 
	
	//	Recojemos valores
	
	for nI := 1 to nLen  
	
		cField 			:= ::aFields[nI][ 'field' ]
		cField_Type 	:= ::aFields[nI][ 'field_type' ]
		nField_Pos 		:= ::aFields[nI][ 'field_pos' ]
		lUpdate 		:= ::aFields[nI][ 'update' ]						

		if lUpdate .and. HB_HHasKey( hRow, cField )
			
			do case 
				case cField_Type == 'C'
					::aFields[nI][ 'value' ] := hRow[ cField ] 
				case cField_Type == 'D'
					if valtype( hRow[ cField ] ) == 'C'															
						::aFields[nI][ 'value' ] := CToD( hRow[ cField ] )
					else
						::aFields[nI][ 'value' ] := CToD( '  -  -  ' )						
					endif				
				case cField_Type == 'N'
					if valtype( hRow[ cField ] ) != 'N' 
						::aFields[nI][ 'value' ] := Val(hRow[ cField ])
					else
						::aFields[nI][ 'value' ] := hRow[ cField ]										
					endif
				otherwise				
					::aFields[nI][ 'value' ] :=  hRow[ cField ]
			endcase			
			
		endif
		
	next
	
	// 	Validate Data 
	
		lValid	:= ::ValidRow( hRow )
			
	
	// Save data
	
	if lValid 
	
		bErrorHandler 	:= {|oError| DoBreak(oError) }  
		bLastHandler 	:= ErrorBlock(bErrorHandler)
	
		for nI := 1 to nLen  
		
			cField 			:= ::aFields[nI][ 'field' ]		
			nField_Pos 		:= ::aFields[nI][ 'field_pos' ]
			lUpdate 		:= ::aFields[nI][ 'update' ]						

			if lUpdate .and. HB_HHasKey( hRow, cField )
			
				(::cAlias)->( FieldPut( nField_Pos, ::aFields[nI][ 'value' ] ) )					
				
			endif
			
		next

		ErrorBlock(bLastHandler)		
	
	endif	

RETU lValid

METHOD ReadRow( hRow ) CLASS TBrwDataset 

	local nLen := len( ::aFields )
	local nI, cField, cField_Type, nField_Pos, lUpdate	
	
	//	Recojemos valores
	
	for nI := 1 to nLen  
	
		cField 			:= ::aFields[nI][ 'field' ]
		cField_Type 	:= ::aFields[nI][ 'field_type' ]
		nField_Pos 	:= ::aFields[nI][ 'field_pos' ]
		lUpdate 		:= ::aFields[nI][ 'update' ]						

		if lUpdate .and. HB_HHasKey( hRow, cField )
			
			do case 
				case cField_Type == 'C'
					::aFields[nI][ 'value' ] := hRow[ cField ] 
				case cField_Type == 'D'
					if valtype( hRow[ cField ] ) == 'C'															
						::aFields[nI][ 'value' ] := CToD( hRow[ cField ] )
					else
						::aFields[nI][ 'value' ] := CToD( '  -  -  ' )						
					endif				
				case cField_Type == 'N'
					if valtype( hRow[ cField ] ) != 'N' 
						::aFields[nI][ 'value' ] := Val(hRow[ cField ])
					else
						::aFields[nI][ 'value' ] := hRow[ cField ]										
					endif
				otherwise				
					::aFields[nI][ 'value' ] :=  hRow[ cField ]
			endcase			
			
		endif
		
	next

RETU nil

METHOD ValidRow( hRow ) CLASS TBrwDataset 

	local nLen 		:= len( ::aFields )
	local lValid 	:= .t.
	local nI, cField, nField_Pos, lUpdate, bValid
	
	// Validate Data 
	
	for nI := 1 to nLen  
	
		cField 			:= ::aFields[nI][ 'field' ]		
		nField_Pos 		:= ::aFields[nI][ 'field_pos' ]
		lUpdate 		:= ::aFields[nI][ 'update' ]				
		bValid 			:= ::aFields[nI][ 'validate' ]

		if lUpdate .and. valtype( bValid ) == 'B'  .and. HB_HHasKey( hRow, cField ) 
		
			if ! eval( bValid, Self, ::aFields[nI][ 'value' ], hRow )
				lValid := .f.
			endif
			
		endif
		
	next				

RETU lValid

METHOD SetError( cError ) CLASS TBrwDataset 

	Aadd( ::aError, cError )

RETU NIL

METHOD GetErrorString() CLASS TBrwDataset 

	local cError  := ''
	local nI
	
	for nI := 1 to len( ::aError )
	
		cError += valtochar(::aError[nI]) + '<br>' 
		
	next

RETU cError

static function DoBreak(oError) 

	local cError := '<pre>'
	local n
	
	cError += '<b>Operation:</b> ' + oError:Operation + '<br>'
	cError += '<b>Description:</b> ' + oError:description + '<br>'
	cError += '<b>System:</b> ' + oError:subsystem + '/' + valtochar( oError:subcode) + '<br>'
	cError += '<b>Args:</b><br>'
	
	for n = 1 to len(oError:args)
		cError += Replicate( '&nbsp;', 5 ) + ltrim(str(n)) + ' => ' + valtochar( oError:args[n] ) + '<br>'
	next

	cError += '</pre>'
	
	?? cError
	
	Break
	
retu nil

//	----------------------------------------------------------------	//

function XBrowse( o, cId, uData, cUniqueId, hCfg, hCols )

	local oBrw, oCol
	local cId_BtnBar, n, aPair, cKey, hCfgCol, nLen , cType, lEdit
	
	DEFAULT cId TO 'ringo'
	DEFAULT cUniqueId TO ''
	DEFAULT hCfg TO {=>}
	DEFAULT hCols TO {=>}
	
	HB_HCaseMatch(	hCfg, .f. )																
	
	if( !HB_HHasKey( hCfg, 'btnadd' ) , HB_HSet( hCfg, 'btnadd' , '_XBrwAdd()' ), nil )
	if( !HB_HHasKey( hCfg, 'btnedit' ), HB_HSet( hCfg, 'btnedit', '_XBrwEdit()' ), nil )
	if( !HB_HHasKey( hCfg, 'btndel' ) , HB_HSet( hCfg, 'btndel' , '_XBrwDel()' ), nil )
	if( !HB_HHasKey( hCfg, 'btnsave' ), HB_HSet( hCfg, 'btnsave', '_XBrwSave()' ), nil )
	
	if( !HB_HHasKey( hCfg, 'print' )  , HB_HSet( hCfg, 'print'  , .t. ), nil )
	if( !HB_HHasKey( hCfg, 'export' ) , HB_HSet( hCfg, 'export' , .t. ), nil )
	if( !HB_HHasKey( hCfg, 'search' ) , HB_HSet( hCfg, 'search' , .t. ), nil )
	if( !HB_HHasKey( hCfg, 'tools' )  , HB_HSet( hCfg, 'tools'  , .t. ), nil )
	
	
	if( !HB_HHasKey( hCfg, 'edit_title' ), HB_HSet( hCfg, 'edit_title', '<i class="far fa-edit"></i> Update row' ), nil )
	if( !HB_HHasKey( hCfg, 'lang' )      , HB_HSet( hCfg, 'lang', 'es-ES' ), nil )
	if( !HB_HHasKey( hCfg, 'dark' )      , HB_HSet( hCfg, 'dark', .f. ), nil )
	if( !HB_HHasKey( hCfg, 'stripped' )  , HB_HSet( hCfg, 'stripped', .f. ), nil )
	if( !HB_HHasKey( hCfg, 'height' )  	 , HB_HSet( hCfg, 'height', 400 ), nil )
	
	DIV o 
	
		//HTML o INLINE '<div style="border:1px solid red;">Hola Div</div>'
		
		HTML o
		
			<style>				
			
				._xbrwbtnbar {
					border-radius:0px;
				}						
				
			</style>
			
		ENDTEXT 	

		cId_BtnBar := '_xBrw_Bar_' + cId 	
	
		DIV o ID cId_BtnBar CLASS 'btn-group'
			BUTTON LABEL ' New' 	ICON '<i class="far fa-plus-square"></i>' 	ACTION hCfg[ 'btnadd'] 	CLASS 'btn-secondary _xbrwbtnbar' GRID 0 OF o
			BUTTON LABEL ' Edit' 	ICON '<i class="far fa-edit"></i>' 			ACTION hCfg[ 'btnedit'] 	CLASS 'btn-secondary _xbrwbtnbar' GRID 0 OF o
			BUTTON LABEL ' Delete' ICON '<i class="far fa-trash-alt"></i>' 		ACTION hCfg[ 'btndel'] 	CLASS 'btn-secondary _xbrwbtnbar' GRID 0 OF o
			BUTTON LABEL ' Save' 	ICON '<i class="far fa-save"></i>' 			ACTION hCfg[ 'btnsave'] 	CLASS 'btn-secondary _xbrwbtnbar' GRID 0 OF o
		ENDDIV o 	
		
	//	#xcommand DEFINE BROWSE [<oBrw>] [ ID <cId> ] [HEIGHT <nHeight>] [ <s: SELECT> [ <rd: RADIO> ] ] [ <ms: MULTISELECT> ];
	//				[<click: CLICKSELECT>] [<lPrint: PRINT>] [<lExport: EXPORT>] [<lSearch: SEARCH>] [<lTools: TOOLS>] ;
	//				[ ONCHANGE <cAction>  ] ;
	//				[ DBLCLICK <cDblClick> ] ;
	//				[ <edit: EDIT> [ WITH <cEditor>] [ TITLE <cTitle> ] [ PREEDIT <cPreEdit> ] [ POSTEDIT <cPostEdit> ] [ UNIQUEID <cKey>] ] ;
	//				[ ROWSTYLE <cRowStyle> ] ;
	//				[ TOOLBAR <cToolbar> ] ;
	//				[ PAGINATION URL <cPag_Url> [ <ui: USERINTERMEDIATE> ] ] ;
	//				[ OF <oForm> ] 
		
	//	TWebBrowse():New( <oForm>, [<cId>], <nHeight>, <.s.>, <.rd.>, <.ms.>, <.click.>, <.lPrint.>, <.lExport.>,
	//						<.lSearch.>, <.lTools.>, [<cAction>], [<cDblClick>], [<.edit.>], [<cKey>], [<cEditor>],
	//						[<cTitle>], [<cPreEdit>], [<cPostEdit>], [<cRowStyle>], [<cToolbar>], [<cPag_Url>],
	//						[<.ui.>] )
	
		lEdit := if( !empty(cUniqueId), .t., .f. )
	
	
		oBrw := TWebBrowse():New( o, cId, hCfg[ 'height'], nil, nil, .t., .t., hCfg[ 'print'],  hCfg[ 'export'],  hCfg[ 'search'],  hCfg[ 'tools'],;
									nil, nil, lEdit, cUniqueId, nil,  hCfg[ 'edit_title'], nil, nil,nil, cId_BtnBar )
		
		
/*
		DEFINE BROWSE oBrw ID cId MULTISELECT CLICKSELECT HEIGHT 400 ;
			EDIT UNIQUEID 'id' TITLE '<i class="fas fa-recycle"></i> My ABM...' POSTEDIT 'TestPostEdit' ;
			TOOLBAR "bar" ;
			SEARCH TOOLS EXPORT PRINT  ;
			OF o
*/			

			oBrw:lDark 		:= hCfg[ 'dark']
			oBrw:lStripped 	:= hCfg[ 'stripped']
			oBrw:cLocale 	:= hCfg[ 'lang' ]		
			
			if !empty( hCols )
			
				nLen := len( hCols )				
				
				for n := 1 to nLen 
				
					aPair		:= HB_HPairAt( hCols, n ) 
					cKey 		:= aPair[1]
					hCfgCol 	:= aPair[2] 
	
					/*	
					#xcommand ADD <oCol> TO <oBrw> ID <cId> ;
							[ HEADER <cHeader> ] ;		
							[ WIDTH <nWidth> ] ;
							[ ALIGN <cAlign> ] ;
							[ FORMATTER <cFormatter> ] ;
							[ <lSort: SORT> ];
							[ CLASS <cClass> ] ;
							[ CLASSEVENT <cClassEvent> ] ;		
							[ <lEdit: EDIT> ] [ [ TYPE <cEdit_Type> ] [ WITH <cEdit_With> ] [ <lEscape: ESCAPE> ] ] ;
						=> ;						
							<oCol> := <oBrw>:AddCol( <cId>, nil, [<cHeader>], [<nWidth>], [<.lSort.>], [<cAlign>], [<cFormatter>], [<cClass>], [<.lEdit.>], [<cEdit_Type>], [<cEdit_With>], [<.lEscape.>], [<cClassEvent>] )
					*/
					
					//cHeader := cKey	

					HB_HCaseMatch(	hCfgCol, .f. )

					if( !HB_HHasKey( hCfgCol, 'header'), 	HB_HSet( hCfgCol, 'header', cKey)			, nil )
					if( !HB_HHasKey( hCfgCol, 'align' ),		HB_HSet( hCfgCol, 'align', nil )		, nil )
					if( !HB_HHasKey( hCfgCol, 'class' ), 	HB_HSet( hCfgCol, 'class', nil )		, nil )
					if( !HB_HHasKey( hCfgCol, 'edit'  ), 	HB_HSet( hCfgCol, 'edit', .f. )		, nil )
					if( !HB_HHasKey( hCfgCol, 'edit_type' ),HB_HSet( hCfgCol, 'edit_type', 'C' )	, nil )
					if( !HB_HHasKey( hCfgCol, 'edit_with' ),HB_HSet( hCfgCol, 'edit_with', nil )	, nil )
					if( !HB_HHasKey( hCfgCol, 'width' ), 	HB_HSet( hCfgCol, 'width', nil )		, nil )
					if( !HB_HHasKey( hCfgCol, 'sort' ), 	HB_HSet( hCfgCol, 'sort', .f. )		, nil )
					if( !HB_HHasKey( hCfgCol, 'edit_escape' ), 	HB_HSet( hCfgCol, 'edit_escape', .f.  )	, nil )
					if( !HB_HHasKey( hCfgCol, 'formatter' ),HB_HSet( hCfgCol, 'formatter', nil  )	, nil )

					oBrw:AddCol( cKey, nil, ;									
									hCfgCol[ 'header' ],;
									hCfgCol[ 'width' ],;
									hCfgCol[ 'sort' ],;
									hCfgCol[ 'align' ],;
									hCfgCol[ 'formatter' ],;
									hCfgCol[ 'class' ],;
									hCfgCol[ 'edit' ],;
									hCfgCol[ 'edit_type' ],;
									hCfgCol[ 'edit_with' ],;									
									hCfgCol[ 'edit_escape' ]; 
									)				
				next 	
				
			else 
			
				nLen := len( uData[1] )
				
				for n := 1 to nLen 
				
					aPair		:= HB_HPairAt( uData[1], n ) 
					cKey 		:= aPair[1]
					cType 		:= ValType( aPair[2] )				
					
					if ! lEdit 
					
						ADD oCol TO oBrw ID cKey 	HEADER cKey	 
						
					else 
					
						if !empty( cUniqueId ) .and. cKey ==  cUniqueId
							ADD oCol TO oBrw ID cKey 	HEADER cKey	EDIT TYPE 'V'	//	Type View					
						else 
							ADD oCol TO oBrw ID cKey 	HEADER cKey EDIT TYPE cType				
						endif
					endif
				
				next 
		
			endif

		INIT BROWSE oBrw DATA uData			

	ENDDIV o 
	
	HTML o PARAMS cId 
		
		<script>
		
			var _oBrw_<$ cId $> 	= new TWebBrowse( '<$ cId $>' )					

			function _XBrwEdit() 	{ _oBrw_<$ cId $>.Edit() }	
			function _XBrwAdd()  	{ _oBrw_<$ cId $>.AddRow() }	
			function _XBrwDel() 	{ _oBrw_<$ cId $>.DeleteRow() }
			function _XBrwSave() 	{ MsgInfo( 'Action not defined' ) }	

		</script>
		
	ENDTEXT							

retu nil


