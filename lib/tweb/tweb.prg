#define TWEB_VERSION 			'TWeb 0.7'
#define TWEB_PATH 				'lib/tweb/'

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

function TWebVersion() ; RETU TWEB_VERSION

function LoadTWeb( cPathPluggin )

	LOCAL cHtml
	
	DEFAULT cPathPluggin TO TWEB_PATH
	
	cHtml := TWebLibs( cPathPluggin )
	cHtml += TWebCss( cPathPluggin )
	
retu cHtml

function LoadTWebTables( cPathPluggin )

	LOCAL cHtml
	
	DEFAULT cPathPluggin TO TWEB_PATH
	
	cHtml := TWebLibs( cPathPluggin )
	cHtml += TWebLibsTables( cPathPluggin )
	//cHtml += TWebCss( cPathPluggin )
	
retu cHtml

function TWebLibs( cPathPluggin ) 	

	DEFAULT cPathPluggin TO TWEB_PATH
	
return '<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>' + ;
		'<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>' + ;
		'<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" rel="stylesheet">' + ;
		'<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>' + ;
		'<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css" integrity="sha384-oS3vJWv+0UjzBfQzYUhtDYW+Pj2yciDJxpsK1OYPAYjqT085Qq/1cq5FLXAZQ7Ay" crossorigin="anonymous">' + ;
		'<link href="//cdnjs.cloudflare.com/ajax/libs/animate.css/3.2.0/animate.min.css" rel="stylesheet">' + ;		
		'<script src="' + 'lib/notify/bootstrap-notify.min.js' + '"></script>' + ;
		'<script src="' + 'lib/bootbox/bootbox.all.min.js"></script>' + ;
		'<link href="' +  'lib/tweb/modgui.css' + '" rel="stylesheet">' + ;		
		'<script src="' + 'lib/tweb/modgui.js"></script>' + ;
		'<link href="' +  'lib/tweb/tweb.css' + '" rel="stylesheet">' + ;		
		'<script src="' + 'lib/tweb/tweb.js' + '"></script>'
		
function TWebLibsTables( cPathPluggin ) 	

return 	'<link href="https://unpkg.com/bootstrap-table@1.15.5/dist/bootstrap-table.min.css" rel="stylesheet">' + ;
		'<script src="https://unpkg.com/bootstrap-table@1.15.5/dist/bootstrap-table.js"></script>' + ;
		'<script src="https://unpkg.com/bootstrap-table@1.15.5/dist/extensions/print/bootstrap-table-print.min.js"></script>' + ;
		'<script src="https://unpkg.com/tableexport.jquery.plugin/tableExport.min.js"></script>' + ;
		'<script src="https://unpkg.com/bootstrap-table@1.15.5/dist/extensions/export/bootstrap-table-export.min.js"></script>' + ;
		'<script src="https://unpkg.com/bootstrap-table@1.15.5/dist/bootstrap-table-locale-all.min.js"></script>'


function TWebCss( cPathPluggin ) 

	LOCAL cHtml := '<style>'
	
	DEFAULT cPathPluggin TO TWEB_PATH
	
    //cHtml += Include( cPathPluggin + 'tweb.css' )
    cHtml += Memoread( AP_GetEnv( "PRGPATH" )  + cPathPluggin +  'tweb.css' )
       
    cHtml += '</style>'
   
retu cHtml

function TWebInclude( cPathPluggin )

	DEFAULT cPathPluggin TO TWEB_PATH

RETU '"' + HB_GetEnv( "PRGPATH" ) + '/' + cPathPluggin + 'tweb.ch' + '"'
