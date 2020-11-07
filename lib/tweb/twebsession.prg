//	------------------------------------------------------------------------------
//	Title......: Session
//	Description: Módulo de sesiones
//	Date.......: 16/06/2019
//	Last Upd...: 21/10/2020
//	------------------------------------------------------------------------------
//	InitSession()	- Creacion de una Session. Una vez creada la session puedes 
//					  almacenar/recuperar variables 
//
//	Session() 		- Setter/Getter . Almacena/recupera los valores de las variables
//					  Session( <NameVar>, [<uValue>] )	 
//					  Si no pasamos paràmetros devolvemos si existe session -> .t./.f.
//
//  EndSession()  - Eliminar una session del servidor
//
//	------------------------------------------------------------------------------
//	Ejemplos por orden de ejecucion:
//
//	test_session.prg			- Crear session y salvar variables
//	test_session_read.prg		- Crear session y recuperar variables almacenadas
//	test_session_end.prg		- Crear session y eliminar session
//	------------------------------------------------------------------------------

#include 'hbclass.ch'
#include 'hboo.ch'

#define SESSION_NAME 	 		'HRBSESSID'
#define SESSION_PREFIX  		'sess_'
#define SESSION_EXPIRED 		3600


function Redirect( cUrl )

	DEFAULT cUrl TO ''

	?? "<script>window.location.replace( '" + cUrl + "');</script>"
	
retu nil


function InitSession( cName, nExpired )

	local o := TWebSession():New( cName, nExpired )
	
	o:InitSession()

retu nil

function Session( cKey, uValue )

	local o := TWebSession():New()
	
retu o:Session( cKey, uValue )

function Is_Session( cName )

	local o := TWebSession():New( cName )
	
retu o:Is_Session()


function EndSession( cName )

	local o := TWebSession():New( cName )
	
	o:EndSession()
	
retu nil

CLASS TWebSession 

	CLASSDATA lInit						INIT .F.
	CLASSDATA cSessionName				INIT SESSION_NAME
	CLASSDATA hSession 				INIT NIL
	CLASSDATA cSID 						INIT ''
	CLASSDATA lIs_Session				INIT .F.
	CLASSDATA nExpired					INIT SESSION_EXPIRED
			
	CLASSDATA cDirTmp					INIT ''
	DATA 	  cSeed						INIT 'MySesSiOn'

			
	METHOD  New() 						CONSTRUCTOR
	
	METHOD  InitSession()
	METHOD  Session( cKey, uValue )	
	METHOD  EndSession()
	METHOD  SaveSession()
	METHOD  Get_Session()
	METHOD  StrSession()
	METHOD  SetSession()	
	METHOD  Is_Session()				INLINE ::lIs_Session 
	METHOD  Garbage()			
	METHOD  Info()			

ENDCLASS 

METHOD New( cName, nExpired ) CLASS TWebSession

	DEFAULT cName 		TO ''
	DEFAULT nExpired 	TO SESSION_EXPIRED
	
	::cDirTmp 		:= TWebGlobal( 'session_path' ) + if( "Linux" $ OS(), '\', '/' )
	::cSeed 		:= if( !empty( TWebGlobal( 'session_key' ) ), TWebGlobal( 'session_key' ), ::cSeed )
	::cSessionName := if( !empty( cName ), cName , SESSION_NAME )
	::nExpired 	:= nExpired	

	if !::lInit 

		::lInit := .T.

		::Get_Session()
		
	endif
	
retu Self


METHOD InitSession() CLASS TWebSession

	local cSession, cFile
	
	if ::lIs_Session
	
		//	Actualizamos tiempo de la sesion. Tambien esta a nivel cookie...
	
			::hSession[ 'expired' ] := seconds() + SESSION_EXPIRED		
		
	else
	
		//	Si no existe una Session la iniciamos...
		
			::SetSession() 
		
			::StrSession()
			
			::lIs_Session := .T.
	
	endif
	
	//	Renovamos la cookie, cada vez que ejecutamos con el tiempo renovado...

		SetCookie( ::cSessionName, ::cSID, ::nExpired )		

retu nil

//	------------------------------------------------------------------------------

METHOD Session( cKey, uValue )  CLASS TWebSession

	if !::lIs_Session
		retu ''
	endif

	if ValType( uValue ) <> 'U' 		//	SETTER
	
		if !empty( cKey ) 
		
			::hSession[ 'data' ][ cKey ] := uValue		
		
		endif
	
	else								// GETTER

		if ( hb_HHasKey( ::hSession[ 'data' ], cKey  ) )
			retu ::hSession[ 'data' ][ cKey ] 
		else
			retu ''
		endif
		
	endif

retu nil

//	------------------------------------------------------------------------------

METHOD EndSession() CLASS TWebSession

	local cFile 	
	
	if !::lIs_Session
		retu nil 
	endif	

	if ( Valtype( ::hSession ) == 'H'  )
	
		//	Enviaremos la cookie con tiempo expirado. Esto la eliminara y no se volverá a enviar...
		
			setcookie( ::cSessionName, ::cSID, -1 )
		
		//	Eliminamos Session de disco
	
			cFile := ::cDirTmp + SESSION_PREFIX + ::cSID 
			
			fErase( cFile )
			
	endif
	
	//	Eliminamos variable GLOBAL de Session
	
		::hSession  	:= NIL
		::cSID			:= ''
		::lIs_Session	:= .F.
	
retu nil

//	------------------------------------------------------------------------------

METHOD SaveSession() CLASS TWebSession

	local cSession, cFile, lSave, cKey, cData

	if !::lIs_Session
		retu ''
	endif	
		
	cSession 	:= hb_jsonencode( ::hSession )

	cKey 		:= hb_blowfishKey( ::cSeed )	
	cData 		:= hb_blowfishEncrypt( cKey, cSession )
	
	//	Podriem aqui encryptar la session (Pendent)
	
	cFile 	 	:= ::cDirTmp + SESSION_PREFIX + ::cSID 	
	lSave 		:= hb_memowrit( cFile, cData )		

retu NIL 

//	------------------------------------------------------------------------------

METHOD SetSession()  CLASS TWebSession
    
    ::cSID := hb_MD5( DToS( Date() ) + Time() + Str( hb_Random(), 15, 12 ) )    

retu nil

//	------------------------------------------------------------------------------

METHOD Get_Session() CLASS TWebSession

	local hGet 		:= AP_GetPairs()
	local lCookie 		:= .F.
	local cFile, cSession, cData

	::lIs_Session := .F.

	::cSID := hb_HGetDef( hGet, ::cSessionName, '' )
	
	if ! empty( ::cSID ) 	//	GET
	
		lCookie := .t.		
			
	else
		
		::cSID := hb_HGetDef( getCookies(), ::cSessionName, '' )
		
		lCookie := !empty( ::cSID )				
		
	endif
	
	if lCookie 
		
		//	Recuperar contenido del fichero de session...
		
		cFile 		:= ::cDirTmp + SESSION_PREFIX + ::cSID 	
		
		
		if File( cFile )

			cSession := hb_Memoread( cFile )							
		
			//	Si hay contenido Deserializaremos...
			
			if ( !empty( cSession ) )
			
				cData := hb_blowfishDecrypt( hb_blowfishKey( ::cSeed ), cSession )
			
				//	Aui podriem desencryptar cSession... (pendent)

				::hSession := hb_jsondecode( cData )							

				if Valtype( ::hSession ) == 'H' 										
				
					//	Validaremos estructura
					
					if ( 	hb_HHasKey( ::hSession, 'ip'   	) .and. ;
							hb_HHasKey( ::hSession, 'sid'  	) .and. ;
							hb_HHasKey( ::hSession, 'expired' ) .and. ;
							hb_HHasKey( ::hSession, 'data' 	) )												
							
						if  ::hSession[ 'expired' ] >= seconds()  .and. ;
							::hSession[ 'ip' ] == AP_USERIP() 
						
							::lIs_Session := .t.
							
						endif							

					endif	
				
				endif
				
			endif
				
		endif 									
	
	endif
	
retu ::lIs_Session 

//	------------------------------------------------------------------------------

METHOD StrSession() CLASS TWebSession

	::hSession := { => }
	
	::hSession[ 'ip'     ] := AP_USERIP()			//	La Ip no es fiable. Pueden usar proxy
	::hSession[ 'sid'    ] := ::cSID
	::hSession[ 'expired'] := seconds() + ::nExpired
	::hSession[ 'data'   ] := { => }

retu nil

//	------------------------------------------------------------------------------
//	Delete files <= dMaxDate. Default 1 day ago

METHOD Garbage( dMaxDate ) CLASS TWebSession

	local aFiles 	:= Directory( ::cDirTmp + '*.*' )
	local nFiles 	:= len( aFiles )
	local nI 
	
	DEFAULT dMaxDate TO Date()-1
	
	for nI := 1 to nFiles 
	
		if aFiles[nI][3] <= dMaxDate 				
			fErase( ::cDirTmp + aFiles[nI][1] )
		endif
	next	
	
retu nil
//	------------------------------------------------------------------------------
//	Delete files <= dMaxDate. Default 1 day ago

METHOD Info() CLASS TWebSession

	local aFiles 	:= Directory( ::cDirTmp + '*.*' )
	local nFiles 	:= len( aFiles )
	local nBytes 	:= 0 
	local nI
	local hInfo 	:= {=>}
	
	for nI := 1 to nFiles
	
		nBytes += aFiles[nI][2]

	next
	
	hInfo[ 'files' ] 	:= nFiles
	hInfo[ 'bytes' ] 	:= nBytes

retu hInfo


//	------------------------------------------------------------------------------
//	Creamos Instancia TWebSession() y Salvamos si es que tenemos session abierta

EXIT PROCEDURE __ExitSession()

	local o		:= TWebSession():New()

	o:SaveSession()		
	
retu 
