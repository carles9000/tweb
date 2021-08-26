//	-------------------------------------------------------------

#include "FileIO.ch"


//	------------------------------------------------------------
//	FUNCTION from Mindaugas code -> esshop
//	------------------------------------------------------------

FUNCTION UHtmlEncode(cString)

   local cChar, cRet := "" 

   for each cChar in cString
		do case
			case cChar == "<"	; cChar := "&lt;"
			case cChar == '>'	; cChar := "&gt;"     				
			case cChar == "&"	; cChar := "&amp;"     
			case cChar == '"'	; cChar := "&quot;" 
			case cChar == "'"	; cChar := "&apos;"   			          
		endcase
		
		cRet += cChar 
   next
	
RETURN cRet

FUNCTION UHtmlQuotes( cString ) 

	cString := StrTran( cString , '"', '\"')		
	cString := StrTran( cString , "'", "&apos;" )

RETU cString 

//	----------------------------------------------------------------
//	Recupera la variable enviada con MsgServer() en su tipo original
//	----------------------------------------------------------------

function GetMsgServer()

	local hParam 	:= AP_PostPairs()
	local uValue 
	

	if HB_HHasKey( hParam, 'type' ) 
	
		do case
			case hParam[ 'type' ] == 'C'; 	uValue := hParam[ 'value' ]
			case hParam[ 'type' ] == 'H'; 	uValue := hb_jsonDecode( hParam[ 'value' ] ) 
			case hParam[ 'type' ] == 'N'; 	uValue := Val( hParam[ 'value' ] )
			case hParam[ 'type' ] == 'L';   uValue := if( hParam[ 'value' ] == 'true', .t., .f.  )
			otherwise
				uValue := hParam[ 'value' ]
		endcase	
		
	else 
	
		uValue := hParam
	
	endif

retu uValue


/*	---------------------------------------------------------------------------
	GetMsgUpload() devuelve la informacion de subida de un fichero en un hash:
	blob - Fichero decodificado
	file - (opcional) hash con info de fichero: name, type, size, ext
	data - (opcional) hash con variables adicionales que se han enviado junto al fichero
	--------------------------------------------------------------------------- */
	
function GetMsgUpload()

	local hParam 	:= ZAP_BodyPairs()	
	local h 		:= {=>}
	
	h[ 'blob' ] 	:= Hb_Base64Decode( hParam[ 'blob' ] )
	
	if HB_HHasKey( hParam, 'file' )
		h[ 'file' ] 			:= hb_jsonDecode( hParam[ 'file' ] ) 	
		h[ 'file' ][ 'ext' ] 	:= lower( cFileExt( h[ 'file' ][ 'name' ]  ) )
	else
		h[ 'file' ]				:= nil
	endif
	
	if HB_HHasKey( hParam, 'data' )
		h[ 'data' ] 	:= hb_jsonDecode( hParam[ 'data' ] ) 
	else
		h[ 'data' ] 	:= nil
	endif
		
	
retu h

//	-----------------------------------------------------------
//	Transforma una variable harbour al mismo tipo en Javascript
//	-----------------------------------------------------------

function SetDataJS( u )

	local uValue 	:= ''
	local cType 	:= valtype( u )

	do case
		case cType == 'C'  ; uValue := "'" + u + "'"
		case cType == 'N'  ; uValue := u 
		case cType == 'L'  ; uValue := if( u, 'true', 'false' )
		case cType == 'D'  ; uValue := "'" + DToC( u ) + "'"
		case cType == 'H'  ; uValue := "JSON.parse( '" +  hb_jsonencode( u )	+ "'); " 
		case cType == 'A'  ; uValue := "JSON.parse( '" +  hb_jsonencode( u )	+ "'); "
		otherwise
			uValue := "'" + valtochar(u) + "'"
	endcase

retu uValue

//	-----------------------------------------------------------
//	Include de una file
//	-----------------------------------------------------------

FUNCTION LoadFile( cFile ) 

	local cPath 		:= AP_GetEnv( "DOCUMENT_ROOT" ) 	
	local oError, cPathFile
   
	hb_default( @cFile, '' )
	
	if empty( AP_GetEnv( "PATH_APP" )  )
		cPath := HB_GetEnv( "PRGPATH" ) 
	else
		cPath := AP_GetEnv( "DOCUMENT_ROOT" ) +  AP_GetEnv( "PATH_APP" )
	endif
	
	if right( cPath ) != '\' .or. right( cPath ) != '/'
		cPath += '/'
	endif	

	cPathFile = cPath + cFile   
   
	if "Linux" $ OS()
		cPathFile = StrTran( cPathFile, '\', '/' )     
	endif   
    
	if File( cPathFile )
		return MemoRead( cPathFile )
	else

		oError := ErrorNew()
		oError:Subsystem   := "System"
		oError:Severity    := 2	//	ES_ERROR
		oError:Description := "LoadFile() File not found: " + cPathFile
		Eval( ErrorBlock(), oError)
   endif

RETU ''

//	-----------------------------------------------------------
//	Log 
//	-----------------------------------------------------------
function TWeblogfile() ; retu TWebGlobal( 'path_log' ) + '/log' + dtos(date()) + '.txt'

function _l( uValue )

	local cFile 	:= TWeblogfile()
	local cInfo   	:= time() + ' ' + procname(1) + '(' +  ltrim(str(procline( 1 ))) + ')'	
	LOCAL cLine, hFile	

	//	Si no hay parámetros borramos el fichero 
	
		if PCount() == 0
			if  fErase( cFile ) == -1
				//	? 'Error eliminando ' + cFilename, fError()
			endif
			retu nil 
		endif
		
	//	Abrimos fichero log
	
		if ! File( cFile )
			fClose( FCreate( cFile ) )	
		endif

		if ( ( hFile := FOpen( cFile, FO_WRITE ) ) == -1 )
			retu nil
		endif
		
	//	Log	

		cLine  	:=  cInfo + ' [' + valtype(uValue) + '] : ' + valtolog( uValue ) + Chr(13) + Chr(10)
			
		fSeek( hFile, 0, FS_END )
		fWrite( hFile, cLine, Len( cLine ) )		
	
	//	Close file log

		fClose( hFile )
   
RETU nil 

//----------------------------------------------------------------//

function ObjToHash( o )

   local hObj := {=>}, aDatas := __objGetMsgList( o, .T. )
   local hPairs := {=>}, aParents := __ClsGetAncestors( o:ClassH )

   AEval( aParents, { | h, n | aParents[ n ] := __ClassName( h ) } ) 

   hObj[ "CLASS" ] = o:ClassName()
   hObj[ "FROM" ]  = aParents 

   AEval( aDatas, { | cData | hPairs[ cData ] := __ObjSendMsg( o, cData ) } )
   hObj[ "DATAs" ]   = hPairs
   hObj[ "METHODs" ] = __objGetMsgList( o, .F. )

retu hObj

//----------------------------------------------------------------//

function ValToLog( u )

   local cType := ValType( u )
   local cResult

   do case
      case cType == "C" .or. cType == "M"
           cResult = u

      case cType == "D"		; cResult = DToC( u )
      case cType == "L" 	; cResult = If( u, ".T.", ".F." )
      case cType == "N"		; cResult = AllTrim( Str( u ) )
      case cType == "A"		; cResult = hb_ValToExp( u )
      case cType == "O"		; cResult = hb_JsonEncode( ObjToHash(u), .t. )
      case cType == "P"   	; cResult = "(P)" 
      case cType == "S"		; cResult = "(Symbol)"  
      case cType == "H"	
	  
			cResult := hb_JsonEncode( u, .t. )

           if Left( cResult, 2 ) == "{}"
              cResult = StrTran( cResult, "{}", "{=>}" )
           endif   		 

      case cType == "U"		; cResult = "nil"
      otherwise
           cResult = "type not supported yet in function ValToLog()"
   endcase

retu cResult 



//	--------------------------------------------------------------------------------
// 	Fivewin Functions
//	--------------------------------------------------------------------------------

function NewAlias( cPrefix ) 

   local cAlias
   local nAliasNo := 0

   DEFAULT cPrefix   	TO "tmp"
   
   cPrefix := Left( cPrefix, 3 )

   do while Select( cAlias := cPrefix + StrZero( ++nAliasNo, 5 ) ) > 0
   enddo
   
return cAlias

//----------------------------------------------------------------------------//

function cFileExt( cPathMask ) // returns the ext of a filename

   local cExt := AllTrim( cFileNoPath( cPathMask ) )
   local n    := RAt( ".", cExt )

return AllTrim( If( n > 0 .and. Len( cExt ) > n,;
                    Right( cExt, Len( cExt ) - n ), "" ) )
					
//----------------------------------------------------------------------------//

function cTempFile( cPath, cExtension )        // returns a temporary filename

   local cFileName

   static cOldName

   DEFAULT cPath 		TO	""
   DEFAULT cExtension 	TO  ""

   if ! Empty( cExtension ) .and. ! "." $ cExtension
      cExtension = "." + cExtension
   endif

   //while File( cFileName := ( cPath + LTrim( Str( GetTickCount() ) ) + cExtension ) ) .or. ;
   while File( cFileName := ( cPath + LTrim( Str( hb_milliseconds() ) ) + cExtension ) ) .or. ;
      cFileName == cOldName
   end

   cOldName = cFileName

return cFileName

//---------------------------------------------------------------------------//

function cFilePath( cPathMask )   // returns path of a filename

   local lUNC := "/" $ cPathMask
   local cSep := If( lUNC, "/", "\" )
   local n := RAt( cSep, cPathMask ), cDisk

return If( n > 0, Upper( Left( cPathMask, n ) ),;
           ( cDisk := cFileDisc( cPathMask ) ) + If( ! Empty( cDisk ), cSep, "" ) )
	

//---------------------------------------------------------------------------//

function cFileDisc( cPathMask )  // returns drive of the path

return If( At( ":", cPathMask ) == 2, ;
           Upper( Left( cPathMask, 2 ) ), "" )
		   
//---------------------------------------------------------------------------//

function cFileNoPath( cPathMask )  // returns just the filename no path

    local n := RAt( "/", cPathMask )

return If( n > 0 .and. n < Len( cPathMask ),;
           Right( cPathMask, Len( cPathMask ) - n ),;
           If( ( n := At( ":", cPathMask ) ) > 0,;
           Right( cPathMask, Len( cPathMask ) - n ),;
           cPathMask ) )		   
	


