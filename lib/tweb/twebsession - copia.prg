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

#define SESSION_PREFIX  		'session_'
#define SESSION_EXPIRED 		3600

function InitSession( cName )

	local o := TWebSession():New()
	
	o:InitSession( cName )

retu nil

function Session( cKey, uValue )

	local o := TWebSession():New()
	
	if cKey == NIL .and. uValue == NIL 
	
		retu o:Is_Session()
		
	endif 
	
retu o:Session( cKey, uValue )

function EndSession()

	local o := TWebSession():New()
	
	o:EndSession()

retu nil

CLASS TWebSession 

	CLASSDATA lInit						INIT .F.
	CLASSDATA cSessionName				INIT 'HRBSESSID'
	CLASSDATA hSession 					INIT NIL
	CLASSDATA cSID 						INIT ''
	CLASSDATA lIs_Session				INIT .F.
			
	CLASSDATA cDirTmp					INIT ''
			
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

METHOD New() CLASS TWebSession

	if  !empty( AP_GetEnv( 'SESSION_PATH' ) ) .and. IsDirectory( AP_GETENV( 'DOCUMENT_ROOT' ) + AP_GetEnv( 'SESSION_PATH' ) )	
		::cDirTmp := AP_GETENV( 'DOCUMENT_ROOT' ) + AP_GetEnv( 'SESSION_PATH' ) + '/'	
	else 	
		::cDirTmp := HB_DirTemp()
	endif


	if !::lInit 

		::lInit := .T.

		::Get_Session()
		
	endif
	
retu Self

METHOD InitSession( cName ) CLASS TWebSession

	local cSession, cFile
	
	DEFAULT cName TO ''
	
	if !empty( cName )
		::cSessionName := cName
	else
		::cSessionName := 'HRBSESSID' // SESSION_PREFIX
	endif
	
	if ::lIs_Session
	
		//	Recuperar contenido del fichero de session...
		
			cFile 		:= ::cDirTmp + SESSION_PREFIX + ::cSID 		
		
		if File( cFile )

			cSession := Memoread( cFile )		
		
			//	Si hay contenido Deserializaremos...
			
				if ( !empty( cSession ) )

					::hSession := hb_Deserialize( cSession )

					if Valtype( ::hSession ) == 'H' 
					
						//	Validaremos si esta Session es del solicitante, fecha de caducidad...					
					
					endif
					
				else	//	Incializamos Session

					::StrSession()
					
				endif
				
		else 	//	Si NO existe el fichero, creamos la estructura de una Session

			::StrSession()							

		endif
		
	else
	
		//	Si no existe una Session la iniciamos...
		
			::SetSession() 
		
			::StrSession()
	
		//	Salvo la nueva session 
		
			cSession 	:= hb_Serialize( ::hSession )
			
			cFile 		:= ::cDirTmp + SESSION_PREFIX + ::cSID 

		//	Pondremos la 'data' de la session accesible por el usuario
		//	Tenemos definida un __hGet, podriamos definir de momento un __hSession	

		::lIs_Session := .T.
	
	endif
	
	//	Renovamos la cookie, cada vez que ejecutamos con el tiempo renovado...

		SetCookie( ::cSessionName, ::cSID, SESSION_EXPIRED )		

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

	local cSession, cFile, lSave

	if !::lIs_Session
		retu ''
	endif
	
	if ( Valtype( ::hSession ) == 'H' )
	
		//	Si estructura es correcta, procederemos a salvaremos
		
		if ( 	hb_HHasKey( ::hSession, 'ip'   ) .and. ;
				hb_HHasKey( ::hSession, 'sid'  ) .and. ;
				hb_HHasKey( ::hSession, 'data' ) )

			cSession 	:= hb_Serialize( ::hSession )		
			cFile 	 	:= ::cDirTmp + SESSION_PREFIX + ::cSID 							
			lSave 		:= memowrit( cFile, cSession )		
	
		endif

	endif		

retu NIL 

//	------------------------------------------------------------------------------

METHOD SetSession()  CLASS TWebSession
    
    ::cSID := hb_MD5( DToS( Date() ) + Time() + Str( hb_Random(), 15, 12 ) )    

retu nil

//	------------------------------------------------------------------------------

METHOD Get_Session() CLASS TWebSession

	local hGet 		:= AP_GetPairs()
	local lCookie 		:= .F.

	::lIs_Session := .F.

	::cSID := hb_HGetDef( hGet, ::cSessionName, '' )
	
	if ! empty( ::cSID ) 	//	GET
	
		lCookie := .t.		
			
	else
		
		::cSID := hb_HGetDef( getCookies(), ::cSessionName, '' )
		
		lCookie := !empty( ::cSID )				
		
	endif
	
	if lCookie 
	
		::lIs_Session := .T.		//	Temporal
		
		//	Validar si cookie es buena
		
		
		
		
	
	
	endif
	
	
	
	
	
	
	
	
	
	
retu ::lIs_Session 

//	------------------------------------------------------------------------------

METHOD StrSession() CLASS TWebSession

	::hSession := { => }
	
	::hSession[ 'ip'     ] := AP_USERIP()			//	La Ip no es fiable. Pueden usar proxy
	::hSession[ 'sid'    ] := ::cSID
	::hSession[ 'expired'] := hb_milliseconds() + SESSION_EXPIRED
	::hSession[ 'data'   ] := { => }

retu nil

//	------------------------------------------------------------------------------
//	Delete files <= dMaxDate. Default 1 day ago

METHOD Garbage( dMaxDate ) CLASS TWebSession

	local aFiles 	:= Directory( ::cDirTmp + '/*.*' )
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

	local aFiles 	:= Directory( ::cDirTmp + '/*.*' )
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
