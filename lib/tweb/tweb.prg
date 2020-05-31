/*
**  tweb.prg -- TWeb library form mod harbour
**
** (c) Carles Aubia, 2019-2020
** Developed by Carles Aubia Floresvi carles9000@gmail.com
** MIT license https://github.com/carles9000/tweb/blob/master/LICENSE
*/


#define TWEB_VERSION 			'TWeb 0.7d'
#define TWEB_PATH 				'lib/tweb/'

#xcommand ?? <cText> => AP_RPuts( <cText> )

#include 'hbclass.ch'
#include 'common.ch'

#include 'TWebControl.prg'
#include 'TWebForm.prg'
#include 'TWebGet.prg'
#include 'TWebGetMemo.prg'
#include 'TWebButton.prg'
#include 'TWebSwitch.prg'
#include 'TWebBrowse.prg'
#include 'TWebFolder.prg'
#include 'TWebCheckbox.prg'
#include 'TWebRadio.prg'
#include 'TWebSelect.prg'
#include 'TWebCommon.prg'


function TWebVersion() ; RETU TWEB_VERSION

function LoadTWeb( cPathPluggin )

	LOCAL cHtml
	
	DEFAULT cPathPluggin TO TWEB_PATH
	
	cHtml := TWebLibs( cPathPluggin )	
	
retu cHtml

function LoadTWebTables( cPathPluggin )

	LOCAL cHtml
	
	DEFAULT cPathPluggin TO TWEB_PATH
	
	cHtml := TWebLibs( cPathPluggin )
	cHtml += TWebLibsTables( cPathPluggin )	
	
retu cHtml

function TWebLibs( cPathPluggin ) 	

	DEFAULT cPathPluggin TO TWEB_PATH
	
return '<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>' + CRLF + ;
		'<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>' + CRLF + ;
		'<link href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.css" rel="stylesheet"/>' + CRLF + ;
		'<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>' + CRLF + ;
		'<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" rel="stylesheet">' + CRLF + ;
		'<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>' + CRLF + ;
		'<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css" integrity="sha384-oS3vJWv+0UjzBfQzYUhtDYW+Pj2yciDJxpsK1OYPAYjqT085Qq/1cq5FLXAZQ7Ay" crossorigin="anonymous">' + CRLF + ;
		'<link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.2/animate.min.css" rel="stylesheet">' + CRLF + ;		
		'<script src="' + cPathPluggin + 'notify/bootstrap-notify.min.js' + '"></script>' + CRLF + ;
		'<script src="' + cPathPluggin + 'bootbox/bootbox.all.min.js"></script>' + CRLF + ;
		'<link href="'  + cPathPluggin + 'tweb.css' + '" rel="stylesheet">' + CRLF + ;		
		'<script src="' + cPathPluggin + 'tweb.js' + '"></script>' + CRLF  
		
function TWebLibsTables( cPathPluggin ) 	

return '<link href="https://unpkg.com/bootstrap-table@1.15.5/dist/bootstrap-table.min.css" rel="stylesheet">' + CRLF + ;
		'<script src="https://unpkg.com/bootstrap-table@1.15.5/dist/bootstrap-table.js"></script>' + CRLF + ;
		'<script src="https://unpkg.com/bootstrap-table@1.15.5/dist/extensions/print/bootstrap-table-print.min.js"></script>' + CRLF + ;
		'<script src="https://unpkg.com/tableexport.jquery.plugin/tableExport.min.js"></script>' + CRLF + ;
		'<script src="https://unpkg.com/bootstrap-table@1.15.5/dist/extensions/export/bootstrap-table-export.min.js"></script>' + CRLF + ;
		'<script src="https://unpkg.com/bootstrap-table@1.15.5/dist/bootstrap-table-locale-all.min.js"></script>' + CRLF 


function TWebCss( cPathPluggin ) 

	LOCAL cHtml := '<style>'
	
	DEFAULT cPathPluggin TO TWEB_PATH	
    
    cHtml += Memoread( AP_GetEnv( "PRGPATH" )  + cPathPluggin +  'tweb.css' )
       
    cHtml += '</style>'
   
retu cHtml

function TWebInclude( cPathPluggin )

	local cFile, oError

	DEFAULT cPathPluggin TO TWEB_PATH
	
	cFile := HB_GetEnv( "PRGPATH" ) + '/' + cPathPluggin + 'tweb.ch'
	
	if ! File( cFile )
		oError := ErrorNew()
		oError:Subsystem   := "System"
		oError:Severity    := 2	//	ES_ERROR
		oError:Description := "TWebInclude() File not found: " + cFile 
		Eval( ErrorBlock(), oError)
   endif

RETU '"' + cFile + '"'

function TWebHtmlInline( cFile, aParam )

	local oError
	local cTxt := ''	
	
	DEFAULT cFile TO ''
		
	cFile := HB_GetEnv( "PRGPATH" ) + '/' + cFile
	
	if ! File( cFile )
		oError := ErrorNew()
		oError:Subsystem   := "System"
		oError:Severity    := 2	//	ES_ERROR
		oError:Description := "TWebhtmlInline() File not found: " + cFile 
		Eval( ErrorBlock(), oError)
		
		retu nil
		
	endif
	
	cTxt := Memoread( cFile )
	
	Parameter( aParam )
	
	cTxt := ReplaceBlocks( cTxt, '<$', "$>", nil, aParam )			
	
RETU cTxt

function Parameter( uValue )

	local cType := valtype( uValue )
	
	static aParam 
	
	DO CASE
	
		CASE cType == 'A'
			aParam := uValue 
			
		CASE cType == 'N'
		
			if valtype( aParam ) == 'A'
			
				if uValue > 0  .and. uValue <= len( aParam )
					retu aParam[ uValue ]
				else
					retu '*** Index error ' + ltrim(str(uValue)) + ' ***'
				endif
			
			endif			
			
	endcase
	
retu ''

function TWebHtmlPrg( cFile, cFunc, ... )

	local oError
	local cTxt := ''
	local bFunc	
	local cHBheaders := "c:\harbour\include"
	local oHrb
	
	DEFAULT cFile TO ''
	DEFAULT cFunc TO ''
		
	cFile := HB_GetEnv( "PRGPATH" ) + '/' + cFile
	
	if ! File( cFile )
		oError := ErrorNew()
		oError:Subsystem   := "System"
		oError:Severity    := 2	//	ES_ERROR
		oError:Description := "TWebHtmlProg() File not found: " + cFile 
		Eval( ErrorBlock(), oError)
		
		retu nil
		
	endif
	
	
	AP_RPuts( pcount() )
	AP_RPuts( pvalue(1) )
	AP_RPuts( pvalue(2) )
	AP_RPuts( pvalue(3) )
	AP_RPuts( pvalue(4) )
	
	AP_RPuts( '<br>FUNC' )
	AP_RPuts( cFunc )
	AP_RPuts( '<br>' )
	
	cTxt := Memoread( cFile )
	
	oHrb := hb_compileFromBuf( cTxt, .T., "-n", "-I" + cHBheaders ) 
	
	
	

	IF !empty( cFunc )
		bFunc 	:= &( '{|...| ' + cFunc + '()}' )
		cTxt 	:= Eval( bFunc, ...  )
	ELSE	
		cTxt 	:= Execute( cTxt )			
	ENDIF

	
RETU cTxt




CLASS TWeb

	DATA lTables					INIT .F.
	DATA cTitle		 			
	DATA cIcon 						
	DATA cLang						INIT 'en' 						
	DATA cCharset					INIT 'ISO-8859-1'			//	'utf-8'
	DATA lActivated				INIT .F.

	METHOD New() 					CONSTRUCTOR
	METHOD Activate()

ENDCLASS 

METHOD New( cTitle, cIcon, lTables, cCharset, lInit ) CLASS TWeb

	DEFAULT cTitle 		TO 'TWeb'
	DEFAULT cIcon 			TO TWEB_PATH + 'images/tweb.png'
	DEFAULT lTables		TO .F.
	DEFAULT cCharSet		TO 'ISO-8859-1'
	DEFAULT lInit 			TO .F.
	
	::cTitle 	:= cTitle
	::cIcon 	:= cIcon	
	::lTables	:= lTables
	::cCharSet	:= cCharset 
	
	IF lInit
		::Activate()		
	ENDIF

RETU SELF

METHOD Activate() CLASS TWeb

	local cHtml := ''
	
	IF ::lActivated
		retu nil
	ENDIF


	cHtml   := '<!DOCTYPE html>' + CRLF
	cHtml 	+= '<html lang="' + ::cLang + '">' + CRLF
	cHtml 	+= '<head>' + CRLF
	cHtml 	+= '<title>' + ::cTitle + '</title>' + CRLF
	cHtml	+= '<meta charset="' + ::cCharset + '">' + CRLF			
	cHtml 	+= '<meta http-equiv="X-UA-Compatible" content="IE=edge">' + CRLF
	cHtml 	+= '<meta name="viewport" content="width=device-width, initial-scale=1">' + CRLF
	cHtml 	+= '<link rel="shortcut icon" type="image/png" href="' + ::cIcon + '"/>' + CRLF
	
	
	IF ::lTables
		cHtml += LoadTWebTables()
	ELSE
		cHtml += LoadTWeb()	
	ENDIF	
	
	?? cHtml
	
	::lActivated := .T.

RETU NIL



/*
       oHrb = HB_CompileFromBuf( cCode, .T., "-n", "-Ic:\fwh\include", "-Ic:\harbour\include" )

       if ! Empty( oHrb )
          BEGIN SEQUENCE
          bOldError = ErrorBlock( { | o | DoBreak( o ) } )
          hb_HrbRun( oHrb )
          END SEQUENCE
          ErrorBlock( bOldError )
       endif
	   
    FUNCTION DoBreak( oError )

       local cInfo := oError:operation, n

       if ValType( oError:Args ) == "A"
          cInfo += "   Args:" + CRLF
          for n = 1 to Len( oError:Args )
             MsgInfo( oError:Args[ n ] )
             cInfo += "[" + Str( n, 4 ) + "] = " + ValType( oError:Args[ n ] ) + ;
                       "   " + cValToChar( oError:Args[ n ] ) + CRLF
          next
       endif

       MsgStop( oError:Description + CRLF + cInfo,;
                "Script error at line: " + AllTrim( Str( ProcLine( 2 ) ) ) )

       BREAK

    return nil	   


*/