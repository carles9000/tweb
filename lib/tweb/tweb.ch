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

#xcommand DEFINE WEB <oWeb> [ TITLE <cTitle>] [ ICON <cIcon>] [<lTables: TABLES>] [ CHARSET <cCharSet>] [<lInit: INIT>] ;
	=> ;
		<oWeb> := TWeb():New( [<cTitle>], [<cIcon>], [<.lTables.>], [<cCharSet>], [<.lInit.>] )
		
#xcommand INIT WEB <oWeb>  => <oWeb>:Activate()



#xcommand DEFINE FORM <oForm> [ID <cId> ] [ACTION <cAction>] [METHOD <cMethod>] => <oForm> := TWebForm():New([<cId>], [<cAction>], [<cMethod>] )
#xcommand INIT FORM <oForm> => <oForm>:InitForm()
#xcommand END FORM <oForm> [ START <fOnInit> ]=> ?? <oForm>:Activate( <fOnInit> )
#xcommand END FORM <oForm> RETURN =>  return <oForm>:Activate()
#xcommand CSS <oForm> => #pragma __cstream| <oForm>:Html( '<style>' + %s + '</style>' )


#xcommand HTML <o> => #pragma __cstream| <o>:Html( %s )
#xcommand HTML <o> INLINE <cHtml> => <o>:Html( <cHtml> )
#xcommand HTML <o> [ PARAMS [<v1>] [,<vn>] ] ;
=> ;
	#pragma __cstream |<o>:Html( InlinePrg( ReplaceBlocks( %s, '<$', "$>" [,<(v1)>][+","+<(vn)>] [, @<v1>][, @<vn>] ) ) )
								
//#xcommand HTML <oForm> FILE <cFile> [ <prm: PARAMS, VARS> <cValues,...> ]  => AP_RPuts( TWebHtmlInline( <cFile>, [\{<cValues>\}]  ) )
#xcommand HTML <oForm> FILE <cFile> [ <prm: PARAMS, VARS> <cValues,...> ]  => <oForm>:Html( TWebHtmlInline( <cFile>, [\{<cValues>\}]  ) )

#xcommand HTML <oForm> PRG  <cFile> [FUNC <cFunc> ] [PARAMS <explist,...>]  => AP_RPuts( TWebHtmlPrg( <cFile>, [<cFunc>] [,<explist>] ) )



	
#xcommand CAPTION <oForm> LABEL <cLabel> [ GRID <nGrid> ] => <oForm>:Caption( <cLabel>, <nGrid> )
#xcommand SEPARATOR <oForm>  [ ID <cId> ] LABEL <cLabel> [ CLASS <cClass> ] => <oForm>:Separator( [<cId>], <cLabel>, [<cClass>] )
#xcommand SMALL <oForm> [ ID <cId> ] [ LABEL <cLabel> ] [ GRID <nGrid> ] => <oForm>:Small( <cId>, <cLabel>, <nGrid> )

#xcommand ROW <oForm> [ ID <cId> ] [ VALIGN <cVAlign> ] [ HALIGN <cHAlign> ] [ CLASS <cClass> ] [ TOP <cTop> ] [ BOTTOM <cBottom>] ;
=> ;
	<oForm>:Row( [<cId>], [<cVAlign>], [<cHAlign>], [<cClass>], [<cTop>], [<cBottom>] )
	
#xcommand ROWGROUP <oForm> [ VALIGN <cVAlign> ] [ HALIGN <cHAlign> ] [ CLASS <cClass> ] => <oForm>:RowGroup( <cVAlign>, <cHAlign>, <cClass> )

#xcommand DIV <oForm> [ ID <cId> ] [ CLASS <cClass> ] => <oForm>:Div( [<cId>], [<cClass>] )
	

#xcommand COL <oForm> [GRID <nGrid>] [TYPE <cType>]  [ CLASS <cClass> ] => <oForm>:Col( [<nGrid>], [<cType>], [<cClass>] )
#xcommand ENDROW <oForm> => <oForm>:End()
#xcommand ENDCOL <oForm> => <oForm>:End()
#xcommand END <oForm> => <oForm>:End()


#xcommand DEFINE FONT [<oFont>] NAME <cId> ;
	[ COLOR <cColor> ] [ BACKGROUND <cBackGround> ] [ SIZE <nSize> ] ;
	[ <bold: BOLD> ] [ <italic: ITALIC> ] [ FAMILY <cFamily> ] ;
	OF <oForm> ;
=> ;
	[<oFont> := ] TWebFont():New( <oForm>, <cId>, <cColor>, <cBackGround>, <nSize>, [<.bold.>], [<.italic.>], [<cFamily>] )
	

#xcommand SAY [<oSay>] [ ID <cId> ] [ <prm: VALUE,PROMPT,LABEL> <uValue> ] [ ALIGN <cAlign> ] ;
	[GRID <nGrid>] [ CLASS <cClass> ] [ FONT <cFont> ] [ LINK <cLink> ] OF <oForm> ;
=> ;
	[<oSay> := ] TWebSay():New( <oForm>, [<cId>], [<uValue>], [<nGrid>], [<cAlign>], [<cClass>], [<cFont>], [<cLink>] )
	
#xcommand IMAGE [<oImg>] [ ID <cId> ] [ FILE <cFile> ] [ BIGFILE <cBigFile> ] [ ALIGN <cAlign> ] ;
	[GRID <nGrid>] [ CLASS <cClass> ] [ WIDTH <nWidth>] [ GALLERY <cGallery> ] ;
	[ <nozoom: NOZOOM> ] OF <oForm> ;
=> ;
	[<oImg> := ] TWebImage():New( <oForm>, [<cId>], [<cFile>], [<cBigFile>], [<nGrid>], [<cAlign>], [<cClass>], [<nWidth>], [<cGallery>], [<.nozoom.>] )
	
	
	
#xcommand GET [<oGet>] [ ID <cId> ] [ VALUE <uValue> ] [ <prm: PROMPT,LABEL> <cLabel> ] [ ALIGN <cAlign> ] [ <col:GRID, COL> <nGrid>] ;
	[ <ro: READONLY> ] [TYPE <cType>] [ PLACEHOLDER <cPlaceHolder>] ;
	[ <btn: BUTTON, BUTTONS> <cButton,...> ] [ <act: ACTION, ACTIONS> <cAction,...> ] [ <bid: BTNID, BTNIDS> <cBtnId,...> ] ;
	[ <rq: REQUIRED> ] [ AUTOCOMPLETE <uSource> [ SELECT <cSelect>] ] ;
	[ <chg: ONCHANGE,VALID> <cChange> ];
	[ CLASS <cClass> ] [ FONT <cFont> ] [ FONTLABEL <cFontLabel> ] ;
	[ LINK <cLink> ] [ GROUP <cGroup> ] [ DEFAULT <cDefault>] ;
	OF <oForm> ;
=> ;
	[<oGet> := ] TWebGet():New( <oForm>, [<cId>], [<uValue>], [<nGrid>], [<cLabel>], [<cAlign>], [<.ro.>], [<cType>], [<cPlaceHolder>], [\{<cButton>\}], [\{<cAction>\}], [\{<cBtnId>\}], [<.rq.>], [<uSource>], [<cSelect>], [<cChange>], [<cClass>], [<cFont>], [<cFontLabel>],[<cLink>], [<cGroup>], [<cDefault>] )
	
#xcommand GET [<oGetMemo>] MEMO [ ID <cId> ] [ VALUE <uValue> ] [ LABEL <cLabel> ] [ ALIGN <cAlign> ] [GRID <nGrid>] ;
	[ <ro: READONLY> ] [ ROWS <nRows> ] ;	
	[ CLASS <cClass> ] [ FONT <cFont> ] ;
	OF <oForm> ;
=> ;
	[<oGetMemo> := ] TWebGetMemo():New( <oForm>, [<cId>], [<uValue>], [<nGrid>], [<cLabel>], [<cAlign>], [<.ro.>], [<nRows>], [<cClass>], [<cFont>] )
	
#xcommand GETNUMBER [<oGet>] [ ID <cId> ] [ VALUE <uValue> ] [ LABEL <cLabel> ] [ ALIGN <cAlign> ] [ <col:GRID, COL> <nGrid>] ;
	[ <ro: READONLY> ] [ PLACEHOLDER <cPlaceHolder>] ;	
	[ <rq: REQUIRED> ]  ;
	[ <chg: ONCHANGE,VALID> <cChange> ];
	[ CLASS <cClass> ] [ FONT <cFont> ] ;	
	OF <oForm> ;
=> ;
	[<oGet> := ] TWebGetNumber():New( <oForm>, [<cId>], [<uValue>], [<nGrid>], [<cLabel>], [<cAlign>], [<.ro.>], [<cPlaceHolder>], [<.rq.>], [<cChange>], [<cClass>], [<cFont>] )

	
#xcommand BUTTON [<oBtn>] [ ID <cId> ] [ LABEL <cLabel> ] [ ACTION <cAction> ] [ NAME <cName> ] [ VALUE <cValue> ] ;
    [ GRID <nGrid> ] [ ALIGN <cAlign> ]  ;
	[ ICON <cIcon> ] [ <ds: DISABLED> ] [ <sb: SUBMIT> ] [ LINK <cLink> ] ;
	[ CLASS <cClass> ] [ FONT <cFont> ] ;
	[ <files: FILES> ] ;
	OF <oForm> ;
=> ;
	[ <oBtn> := ] TWebButton():New( <oForm>, [<cId>], <cLabel>, <cAction>, <cName>, <cValue>, <nGrid>, <cAlign>, <cIcon>, [<.ds.>], [<.sb.>], [<cLink>], [<cClass>], [<cFont>], [<.files.>]  )	
	
	
#xcommand BOX [<oBox>] [ ID <cId> ]  ;
	[GRID <nGrid>] [ HEIGHT <nHeight> ] [ CLASS <cClass> ] OF <oContainer> ;
=> ;
	[<oBox> := ] TWebBox():New( <oContainer>, [<cId>], [<nGrid>], [<nHeight>], [<cClass>] )
	
#xcommand ENDBOX <oBox> => <oBox>:End()	
	
#xcommand SWITCH [<oSwitch>] [ ID <cId> ] [ <lValue: ON> ] [ VALUE <lValue> ] [ LABEL <cLabel> ] [GRID <nGrid>] [ <act:ACTION,ONCHANGE> <cAction> ] OF <oForm> ;
=> ;
	[ <oSwitch> := ] TWebSwitch():New( <oForm>, [<cId>], [<lValue>], [<cLabel>], [<nGrid>], [<cAction>] ) 	
	

#xcommand CHECKBOX [<oCheckbox>] [ ID <cId> ] [ <lValue: ON> ] [ LABEL <cLabel> ] [GRID <nGrid>] [ ACTION  <cAction> ] ;
	[ CLASS <cClass> ] [ FONT <cFont> ] ;
	OF <oForm> ;
=> ;
	[ <oCheckbox> := ] TWebCheckbox():New( <oForm>, [<cId>], [<.lValue.>], [<cLabel>], [<nGrid>], [<cAction>], [<cClass>], [<cFont>]  ) 	
	
	
#xcommand RADIO [<oRadio>] [ ID <cId> ]  [ <chk: VALUE, CHECKED> <uValue> ] ;
		[ <prm: PROMPT, PROMPTS, ITEMS> <cPrompt,...> ] ;
		[ <tabs: VALUES, KEYS> <cValue,...> ] ;			
		[ GRID <nGrid> ] ;
		[ ONCHANGE  <cAction> ] ;
		[ <inline: INLINE> ] ;
		[ CLASS <cClass> ] [ FONT <cFont> ] ;		
		OF <oForm> ;
=> ;
	[ <oRadio> := ] TWebRadio():New( <oForm>, [<cId>], [<uValue>], [\{<cPrompt>\}], [\{<cValue>\}], [<nGrid>], [<cAction>], [<.inline.>], [<cClass>], [<cFont>] )
		 
		 
#xcommand SELECT [<oSelect>] [ ID <cId> ] [ VALUE <uValue> ] [ LABEL <cLabel> ] [ KEYVALUE <aKeyValue> ] ;
		[ <prm: PROMPT, PROMPTS, ITEMS> <cPrompt,...> ] ;
		[ <tabs: VALUES> <cValue,...> ] ;		
		[ GRID <nGrid> ] ;
		[ ONCHANGE  <cAction> ] ;
		[ CLASS <cClass> ] [ FONT <cFont> ]  [ GROUP <cGroup> ];			
		OF <oForm> ;
=> ;
	[ <oSelect> := ] TWebSelect():New( <oForm>, [<cId>], [<uValue>], [\{<cPrompt>\}], [\{<cValue>\}], [<aKeyValue>], [<nGrid>], [<cAction>], [<cLabel>], [<cClass>], [<cFont>], <cGroup>  )
	


		 
#xcommand FOLDER [<oFolder>] [ ID <cId> ] ;
		[ <tabs: TABS> <cTab,...> ] ;		
		[ <prm: PROMPT, PROMPTS, ITEMS> <cPrompt,...> ] ;		
		[ GRID <nGrid> ] ;
		[ OPTION <cOption> ] ;
		[ <lAdjust: ADJUST> ] ;
		[ CLASS <cClass> ] [ FONT <cFont> ] ;	
		OF <oForm> ;
=> ;
	[ <oFolder> := ] TWebFolder():New( <oForm>, [<cId>], [\{<cTab>\}], [\{<cPrompt>\}], [<nGrid>], [<cOption>], [<.lAdjust.>] , [<cClass>], [<cFont>]) 

#xcommand DEFINE TAB <cId> [ <lFocus: FOCUS> ] [ CLASS <cClass> ] OF <oFld> => <oFld>:AddTab( <cId>, [<.lFocus.>], [<cClass>] )
#xcommand ENDTAB <oFld> => <oFld>:End()
#xcommand ENDFOLDER <oFld> => <oFld>:Activate()
	
//	------------------------------------------------------------------------	//

#xcommand DEFINE BROWSE [<oBrw>] [ ID <cId> ] [HEIGHT <nHeight>] [ <s: SELECT> ] [ <ms: MULTISELECT> ];
	[<click: CLICKSELECT>] [<lPrint: PRINT>] [<lExport: EXPORT>] [<lSearch: SEARCH>] [<lTools: TOOLS>] ;
	[ ONCHANGE <cAction>  ] ;
	[ DBLCLICK <cDblClick> ] ;
	[ <edit: EDIT> [ WITH <cEditor>] [ TITLE <cTitle> ] [ POSTEDIT <cPostEdit> ] [ UNIQUEID <cKey>] ] ;
	[ ROWSTYLE <cRowStyle> ] ;
	[ TOOLBAR <cToolbar> ] ;
	[ OF <oForm> ] ;
=> ;
	[ <oBrw> := ] TWebBrowse():New( <oForm>, [<cId>], <nHeight>, <.s.>, <.ms.>, <.click.>, <.lPrint.>, <.lExport.>, <.lSearch.>, <.lTools.>, [<cAction>], [<cDblClick>], [<.edit.>], [<cKey>], [<cEditor>], [<cTitle>], [<cPostEdit>], [<cRowStyle>], [<cToolbar>] )
	
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

#xcommand INIT BROWSE <oBrw> [ JAVASCRIPT <cVar> ] [ DATA <aRows> ] ;
	=> ;
		<oBrw>:Init( [<cVar>], [<aRows>] )
		
		
//#xcommand END BROWSE <oBrw> => <oBrw>:Activate()

#xcommand DEFINE BROWSE DATASET <o> ALIAS <cAlias> => <o> := TBrwDataset():New( <cAlias> )
#xcommand FIELD <cField> [ <lUpdate: UPDATE,UPDATED> ] [ VALID <bValid> ] [ <lNoEscape: NOESCAPE> ] OF <o> => <o>:Field( <cField>, [<.lUpdate.>], [<bValid>], [!<.lNoEscape.>]  )






