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

METHOD New( oParent, cId, nHeight, lSingleSelect, lMultiSelect, lClickSelect, lPrint, lExport, lSearch, lTools, cAction, cDblClick, lEdit, cUniqueId, cEditor, cTitle, cPostEdit, cRowStyle, cToolbar ) CLASS TWebBrowse

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
	DEFAULT cUniqueId		TO ''
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
	::cUniqueId			:= cUniqueId
	::cEditor			:= cEditor
	::cTitle 			:= cTitle
	::cPostEdit 		:= cPostEdit
	::cRowStyle 		:= cRowStyle
	::cToolbar 			:= cToolbar

	IF Valtype( oParent ) == 'O'	
		oParent:AddControl( SELF )	
	ENDIF
	


RETU SELF

METHOD AddCol( cId, hCfg, cHead, nWidth, lSortable, cAlign, cFormatter, cClass, lEdit, cEdit_Type, cEdit_With, lEdit_Escape, cClass_Event ) CLASS TWebBrowse

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
		hDefCol[ 'edit_escape' ]:= HB_HGetDef( hCfg, 'edit_escape', .f. ) 
		hDefCol[ 'class_event' ]:= HB_HGetDef( hCfg, 'class_event', '' ) 
	
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
					data-row-style="{{ oThis:cRowStyle }}"																			
	ENDTEXT														
					if !empty( ::cToolbar ) 					
						cHtml += 'data-toolbar="#' + ::cToolbar + '" '
					endif
					
					if !empty( ::cUniqueId ) 					
						cHtml += 'data-unique-id="' + ::cUniqueId + '" '
					endif
	
	BLOCKS ADDITIVE cHtml
				> 	<!-- end table -->

					<thead  class="thead-dark">
						<tr>																					
	ENDTEXT														
								IF ::lMultiSelect .OR. ::lSingleSelect
								
									cHtml += '<th data-field="_st" data-checkbox="true" name="btSelectItem"></th>'									
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

	::cInit += '$(document).ready(function () {	'							+ CRLF
	
		if !Empty( ::cUniqueId ) 				
			::cInit += cVarJS + ".Set( 'uniqueid', '" + ::cUniqueId  + "'); "
		endif	
		
		if !Empty( ::cTitle ) 	
			//::cInit += cVarJS + ".cTitle = '" + ::cTitle + "'; "
			::cInit += cVarJS + ".Set( 'title', '" + ::cTitle + "'); "
			
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

	DATA cAlias						INIT ''
	DATA aError						INIT {}
	DATA aFields					INIT {}
	DATA bBeforeSave				INIT NIL 

	METHOD New( cAlias ) 					CONSTRUCTOR
	METHOD Row()
	METHOD Field( cField, cType )
	METHOD Save( aRows )
	METHOD SaveRow( aRows )	
	METHOD ValidRow( hRow )	
	METHOD ReadRow( hRow )
	METHOD SetError( cError )	
	METHOD GetError()				INLINE ::aError 
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
		cId 	:= aRows[ nI ][ 'id' ]
		hRow 	:= aRows[ nI ][ 'row' ]
		nRecno  := 0
		
		lValid		:= .T.

		if valtype( ::bBeforeSave ) == 'B' 	
			lValid := eval( ::bBeforeSave, Self, hRow )
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