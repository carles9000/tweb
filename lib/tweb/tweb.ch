#xcommand TEXT TO <var> ECHO => #pragma __stream| AP_RPuts( <var> += %s )
#xcommand TEXT TO <var> => #pragma __stream|<var> += %s
#xcommand TEXT TO <var> [ PARAMS [<v1>] [,<vn>] ] ;
=> ;
	#pragma __cstream |<var> += InlinePrg( ReplaceBlocks( %s, '<$', "$>" [,<(v1)>][+","+<(vn)>] [, @<v1>][, @<vn>] ) ) 
	
#xcommand TEXT TO <var> PARAMS [<v1>] [,<vn>] ECHO ;
=> ;
	#pragma __cstream | AP_RPuts( <var> += InlinePrg( ReplaceBlocks( %s, '<$', "$>" [,<(v1)>][+","+<(vn)>] [, @<v1>][, @<vn>] ) ) )

#xcommand LOAD TWEB => ?? LoadTWeb()
#xcommand LOAD TWEB TABLES => ?? LoadTWebTables()

#xcommand DEFINE WEB <oWeb> [ TITLE <cTitle>] [ ICON <cIcon>] [<lTables: TABLES>] [<lInit: INIT>] ;
	=> ;
		<oWeb> := TWeb():New( [<cTitle>], [<cIcon>], [<.lTables.>], [<.lInit.>] )
		
#xcommand INIT WEB <oWeb> => <oWeb>:Activate()

#xcommand DEFINE FORM <oForm> [ID <cId> ] [ACTION <cAction>] => <oForm> := TWebForm():New([<cId>], [<cAction>])
#xcommand INIT FORM <oForm> => <oForm>:InitForm()
#xcommand END FORM <oForm> => ?? <oForm>:Activate()
#xcommand COL <oForm> [GRID <nGrid>] [TYPE <cType>] => <oForm>:Col( [<nGrid>], [<cType>] )
#xcommand ROW <oForm> => <oForm>:Row()
#xcommand HTML <oForm> => #pragma __cstream| <oForm>:Html( %s )
#xcommand HTML <oForm> INLINE <cHtml> => <oForm>:Html( <cHtml> )
#xcommand HTML <oForm> [ PARAMS [<v1>] [,<vn>] ] ;
=> ;
	#pragma __cstream |<oForm>:Html( InlinePrg( ReplaceBlocks( %s, '<$', "$>" [,<(v1)>][+","+<(vn)>] [, @<v1>][, @<vn>] ) ) )
#xcommand CAPTION <oForm> LABEL <cLabel> [ GRID <nGrid> ] => <oForm>:Caption( <cLabel>, <nGrid> )
#xcommand SEPARATOR <oForm> LABEL <cLabel> => <oForm>:Separator( <cLabel> )
#xcommand SMALL <oForm> [ ID <cId> ] [ LABEL <cLabel> ] [ GRID <nGrid> ] => <oForm>:Small( <cId>, <cLabel>, <nGrid> )

#xcommand ROWGROUP <oForm> => <oForm>:RowGroup()
#xcommand ENDROW <oForm> => <oForm>:End()
#xcommand ENDCOL <oForm> => <oForm>:End()
#xcommand END <oForm> => <oForm>:End()


#xcommand GET [<oGet>] [ ID <cId> ] [ VALUE <uValue> ] [ LABEL <cLabel> ] [ ALIGN <cAlign> ] [GRID <nGrid>] ;
	[ <ro: READONLY> ] [TYPE <cType>] [ PLACEHOLDER <cPlaceHolder>] ;
	[ BUTTON <cBtnLabel> [ ACTION  <cAction> ]] [ <rq: REQUIRED> ] ;
	[ AUTOCOMPLETE <uSource> [ SELECT <cSelect>] ] ;
	OF <oForm> ;
=> ;
	[<oGet> := ] TWebGet():New( <oForm>, [<cId>], [<uValue>], [<nGrid>], [<cLabel>], [<cAlign>], [<.ro.>], [<cType>], [<cPlaceHolder>], [<cBtnLabel>], [<cAction>], [<.rq.>], [<uSource>], [<cSelect>] )
	
#xcommand GET [<oGetMemo>] MEMO [ ID <cId> ] [ VALUE <uValue> ] [ LABEL <cLabel> ] [ ALIGN <cAlign> ] [GRID <nGrid>] ;
	[ <ro: READONLY> ] [ ROWS <nRows> ] ;	
	OF <oForm> ;
=> ;
	[<oGetMemo> := ] TWebGetMemo():New( <oForm>, [<cId>], [<uValue>], [<nGrid>], [<cLabel>], [<cAlign>], [<.ro.>], [<nRows>] )
	
	
#xcommand BUTTON [<oBtn>] [ ID <cId> ] [ LABEL <cLabel> ] [ ACTION <cAction> ] [ GRID <nGrid> ] [ ICON <cIcon> ] ;
	[ CLASS <cClass> ] [ <ds: DISABLED> ] [ <sb: SUBMIT> ] [ LINK <cLink> ] ;
	OF <oForm> ;
=> ;
	[ <oBtn> := ] TWebButton():New( <oForm>, [<cId>], <cLabel>, <cAction>, <nGrid>, <cIcon>, <cClass>, [<.ds.>], [<.sb.>], [<cLink>] )	
	
	
#xcommand SWITCH [<oSwitch>] [ ID <cId> ] [ <lValue: ON> ] [ VALUE <lValue> ] [ LABEL <cLabel> ] [GRID <nGrid>] [ <act:ACTION,ONCHANGE> <cAction> ] OF <oForm> ;
=> ;
	[ <oSwitch> := ] TWebSwitch():New( <oForm>, [<cId>], [<lValue>], [<cLabel>], [<nGrid>], [<cAction>] ) 	
	

#xcommand CHECKBOX [<oCheckbox>] [ ID <cId> ] [ <lValue: ON> ] [ LABEL <cLabel> ] [GRID <nGrid>] [ ACTION  <cAction> ] OF <oForm> ;
=> ;
	[ <oCheckbox> := ] TWebCheckbox():New( <oForm>, [<cId>], [<.lValue.>], [<cLabel>], [<nGrid>], [<cAction>] ) 	
	
	
#xcommand RADIO [<oRadio>] [ ID <cId> ]  ;
		[ <prm: PROMPT, PROMPTS, ITEMS> <cPrompt,...> ] ;
		[ <tabs: VALUES> <cValue,...> ] ;		
		[ GRID <nGrid> ] ;
		[ ONCHANGE  <cAction> ] ;
		[ <inline: INLINE> ] ;		
		OF <oForm> ;
=> ;
	[ <oRadio> := ] TWebRadio():New( <oForm>, [<cId>], [\{<cPrompt>\}], [\{<cValue>\}], [<nGrid>], [<cAction>], [<.inline.>] )
		 
		 
#xcommand SELECT [<oSelect>] [ ID <cId> ] [ VALUE <uValue> ] [ LABEL <cLabel> ]  ;
		[ <prm: PROMPT, PROMPTS, ITEMS> <cPrompt,...> ] ;
		[ <tabs: VALUES> <cValue,...> ] ;		
		[ GRID <nGrid> ] ;
		[ ONCHANGE  <cAction> ] ;			
		OF <oForm> ;
=> ;
	[ <oSelect> := ] TWebSelect():New( <oForm>, [<cId>], [<uValue>], [\{<cPrompt>\}], [\{<cValue>\}], [<nGrid>], [<cAction>], [<cLabel>] )
	


		 
#xcommand FOLDER [<oFolder>] [ ID <cId> ] ;
		[ <tabs: TABS> <cTab,...> ] ;		
		[ <prm: PROMPT, PROMPTS, ITEMS> <cPrompt,...> ] ;		
		[ GRID <nGrid> ] ;
		[ OPTION <cOption> ] ;
		[ <lAdjust: ADJUST> ] ;
		OF <oForm> ;
=> ;
	[ <oFolder> := ] TWebFolder():New( <oForm>, [<cId>], [\{<cTab>\}], [\{<cPrompt>\}], [<nGrid>], [<cOption>], [<.lAdjust.>] ) 

#xcommand DEFINE TAB <cId> [ <lFocus: FOCUS> ] OF <oFld> => <oFld>:AddTab( <cId>, [<.lFocus.>] )
#xcommand ENDTAB <oFld> => <oFld>:End()
#xcommand ENDFOLDER <oFld> => <oFld>:Activate()
	
//	------------------------------------------------------------------------	//

#xcommand DEFINE BROWSE [<oBrw>] [ ID <cId> ] [HEIGHT <nHeight>] [ <s: SELECT> ] [ <ms: MULTISELECT> ];
	[<click: CLICKSELECT>] [<lPrint: PRINT>] [<lExport: EXPORT>] [<lSearch: SEARCH>] [<lTools: TOOLS>] ;
	[ ONCHANGE <cAction>  ] ;
	[ DBLCLICK <cDblClick> ] ;
	[ OF <oForm> ] ;
=> ;
	[ <oBrw> := ] TWebBrowse():New( <oForm>, [<cId>], <nHeight>, <.s.>, <.ms.>, <.click.>, <.lPrint.>, <.lExport.>, <.lSearch.>, <.lTools.>, [<cAction>], [<cDblClick>] )
	
#xcommand ADD <oCol> TO <oBrw> ID <cId> ;
		[ HEADER <cHeader> ] ;		
		[ WIDTH <nWidth> ] ;
		[ ALIGN <cAlign> ] ;
		[ FORMATTER <cFormatter> ] ;
		[ <lSort: SORT> ];		
	=> ;		
		<oCol> := <oBrw>:AddCol( <cId>, nil, [<cHeader>], [<nWidth>], [<.lSort.>], [<cAlign>], [<cFormatter>] )

#xcommand INIT BROWSE <oBrw> [ JAVASCRIPT <cVar> ] [ DATA <aRows> ] ;
	=> ;
		<oBrw>:Init( [<cVar>], [<aRows>] )
		
		
//#xcommand END BROWSE <oBrw> => <oBrw>:Activate()


