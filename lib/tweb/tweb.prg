/*
**  tweb.prg -- TWeb library form mod harbour
**
** (c) Carles Aubia, 2019-2020
** Developed by Carles Aubia Floresvi carles9000@gmail.com
** MIT license https://github.com/carles9000/tweb/blob/master/LICENSE
*/


#define TWEB_VERSION 			'TWeb 0.7b'
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
	
return '<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>' + ;
		'<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>' + ;
		'<link href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.css" rel="stylesheet"/>' + ;
		'<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>' + ;
		'<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" rel="stylesheet">' + ;
		'<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>' + ;
		'<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css" integrity="sha384-oS3vJWv+0UjzBfQzYUhtDYW+Pj2yciDJxpsK1OYPAYjqT085Qq/1cq5FLXAZQ7Ay" crossorigin="anonymous">' + ;
		'<link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.2/animate.min.css" rel="stylesheet">' + ;		
		'<script src="' + cPathPluggin + 'notify/bootstrap-notify.min.js' + '"></script>' + ;
		'<script src="' + cPathPluggin + 'bootbox/bootbox.all.min.js"></script>' + ;
		'<link href="'  + cPathPluggin + 'modgui.css' + '" rel="stylesheet">' + ;		
		'<script src="' + cPathPluggin + 'modgui.js"></script>' + ;
		'<link href="'  + cPathPluggin + 'tweb.css' + '" rel="stylesheet">' + ;		
		'<script src="' + cPathPluggin + 'tweb.js' + '"></script>'
		
function TWebLibsTables( cPathPluggin ) 	

return '<link href="https://unpkg.com/bootstrap-table@1.15.5/dist/bootstrap-table.min.css" rel="stylesheet">' + ;
		'<script src="https://unpkg.com/bootstrap-table@1.15.5/dist/bootstrap-table.js"></script>' + ;
		'<script src="https://unpkg.com/bootstrap-table@1.15.5/dist/extensions/print/bootstrap-table-print.min.js"></script>' + ;
		'<script src="https://unpkg.com/tableexport.jquery.plugin/tableExport.min.js"></script>' + ;
		'<script src="https://unpkg.com/bootstrap-table@1.15.5/dist/extensions/export/bootstrap-table-export.min.js"></script>' + ;
		'<script src="https://unpkg.com/bootstrap-table@1.15.5/dist/bootstrap-table-locale-all.min.js"></script>'


function TWebCss( cPathPluggin ) 

	LOCAL cHtml := '<style>'
	
	DEFAULT cPathPluggin TO TWEB_PATH	
    
    cHtml += Memoread( AP_GetEnv( "PRGPATH" )  + cPathPluggin +  'tweb.css' )
       
    cHtml += '</style>'
   
retu cHtml

function TWebInclude( cPathPluggin )

	DEFAULT cPathPluggin TO TWEB_PATH

RETU '"' + HB_GetEnv( "PRGPATH" ) + '/' + cPathPluggin + 'tweb.ch' + '"'


CLASS TWeb

	DATA lTables					INIT .F.
	DATA cTitle		 			
	DATA cIcon 						
	DATA cCharset					INIT 'utf-8'
	DATA lActivated				INIT .F.

	METHOD New() 					CONSTRUCTOR
	METHOD Activate()

ENDCLASS 

METHOD New( cTitle, cIcon, lTables, lInit ) CLASS TWeb

	DEFAULT cTitle 	TO 'TWeb'
	DEFAULT cIcon 		TO 'images/tweb.png'
	DEFAULT lTables		TO .F.
	DEFAULT lInit 		TO .F.
	
	::cTitle 	:= cTitle
	::cIcon 	:= cIcon	
	::lTables	:= lTables
	
	IF lInit
		::Activate()		
	ENDIF

RETU SELF

METHOD Activate() CLASS TWeb

	local cHtml := ''
	
	IF ::lActivated
		retu nil
	ENDIF


	cHtml   := '<!DOCTYPE html>'
	cHtml 	+= '<html>'
	cHtml 	+= '<head>'
	cHtml 	+= '<title>' + ::cTitle + '</title>'
	cHtml	+= '<meta charset="' + ::cCharset + '">'			
	cHtml 	+= '<meta http-equiv="X-UA-Compatible" content="IE=edge">'
	cHtml 	+= '<meta name="viewport" content="width=device-width, initial-scale=1">'
	cHtml 	+= '<link rel="shortcut icon" type="image/png" href="' + ::cIcon + '"/>'
	
	?? cHtml
	
	IF ::lTables
		?? LoadTWebTables()
	ELSE
		?? LoadTWeb()	
	ENDIF	
	
	::lActivated := .T.

RETU NIL