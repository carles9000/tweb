//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

#define PATH_DATA 		HB_GetEnv( "PRGPATH" ) + '/data/'


function main()

    LOCAL o, oWeb, oSelect
	LOCAL hParameters
	local hData 	:= {=>}
	local lError 	:= .F.
	local lSave 	:= .F.
	local cError 	:= ''
	local cStyle 	:= ''
	local cLoren 	:= ''
	
	//	Inicio Variables
	
		hParameters := AP_PostPairs()
	
		hData[ 'alias'  ] := HB_UrlDecode( HB_HGetDef( hParameters, 'alias', '' ) )
		hData[ 'name'   ] := HB_UrlDecode( HB_HGetDef( hParameters, 'name', '' ) )
		hData[ 'mail'   ] := HB_UrlDecode( HB_HGetDef( hParameters, 'mail', '' ) )
		hData[ 'date'   ] := HB_UrlDecode( HB_HGetDef( hParameters, 'date', '' ) )
		hData[ 'class'  ] := HB_UrlDecode( HB_HGetDef( hParameters, 'class', '' ) )
		hData[ 'accept' ] := IF( HB_HGetDef( hParameters, 'accept', '' )  == 'on', .T., .F. )


	DEFINE WEB oWeb TITLE 'Form example' INIT
	
	TEXT TO cStyle 
		<style>
			.jumbotron{
				background: url("images/bg-head-02.jpg") no-repeat center center; 
				background-size: 100% 100%;
			}
		</style>	
	ENDTEXT
	
	?? cStyle

	//	Chequeamos si entran parámetros

		IF len( hParameters ) > 0 
	
			IF Save( hData, @cError )
			
				//	Reset values...
			
				hData[ 'alias'  ]	:= ''
				hData[ 'name'   ]	:= ''
				hData[ 'mail'   ]	:= ''
				hData[ 'date'   ]	:= ''
				hData[ 'class'  ]	:= ''
				hData[ 'accept' ]	:= .F.	
				
				lSave 	:= .T.
				
			ELSE
				lError 	:= .T.
			ENDIF
			
		ENDIF
		
	//	--------------------------------------------------------------------------------------
	
	//	Inicio Diseño...

		Banner()
		
		IF lError
			MessageError( cError )
		ELSE
			IF lSave
				MessageSave()
			ELSE
				MessageContactUs()
			ENDIF
		ENDIF

    DEFINE FORM o ID 'demo' ACTION 'tutor20.prg'
        o:lDessign  := .F.
        o:cSizing   := '' //'sm'       //  SM/LG				

    INIT FORM o        		
        
        ROWGROUP o
           
            GET ID 'alias'  VALUE hData[ 'alias'] GRID 4 PLACEHOLDER 'Entra tu alias...'  LABEL 'Alias'   REQUIRED  OF o
            GET ID 'name'   VALUE hData[ 'name' ] GRID 8 PLACEHOLDER 'Entra tu nombre...' LABEL 'Nombre'  REQUIRED  OF o
			
        END o
        
        ROWGROUP o
		
			GET ID 'date'   VALUE hData[ 'date' ] GRID 4 PLACEHOLDER 'Entra tu nombre...' LABEL 'Fecha de Nacimiento'  TYPE 'date' OF o
			GET ID 'mail'   VALUE hData[ 'mail' ] GRID 4 PLACEHOLDER 'Entra tu mail...'   LABEL 'Mail de contacto'     TYPE 'email' REQUIRED OF o
			SELECT oSelect  ID 'class'  VALUE  hData[ 'class' ] LABEL 'Clase de Bono' PROMPT 'Normal', 'Premium', 'Excelent' VALUES  'N', 'P', 'E'  GRID 4  OF o            

        END o          
        
        cLoren := "En la indústria editorial i en disseny gràfic, lorem ipsum és un text de farciment que s'usa habitualment per a mostrar els elements gràfics d'un document, com ara la tipografia o la composició."
		
        ROWGROUP o	
			
			SMALL o ID 'chofer_data' Label cLoren  GRID 6
            SWITCH ID 'accept' VALUE hData[ 'accept' ] LABEL 'Acepto condiciones' OF o

        END o          
        
        ROWGROUP o

            BUTTON ID 'btn'  LABEL 'Enviar' GRID 0 ICON '<i class="far fa-paper-plane"></i> ' 	CLASS 'btn-outline-primary' SUBMIT OF o
            BUTTON ID 'btn2' LABEL 'List'   GRID 3 ICON '<i class="fas fa-th-list"></i> ' 		CLASS 'btn-outline-primary' LINK 'tutor20b.prg' OF o
			

        END o           
		
    END FORM o	

	
RETU NIL

function Banner()

	LOCAL cHtml := ''

	TEXT TO cHtml ECHO
	
		<div class="jumbotron">
			<div class="container">
				<h1><a href="">Friends of mod harbour</a></h1>
				<p>Slack group project.<br>Spagetti code example... All in one !</p>
			</div>
		</div>

	ENDTEXT		

retu nil

function MessageContactUs()

	LOCAL cHtml := ''

	TEXT TO cHtml ECHO
	
		<div class="alert alert-dark" style="border-radius: 0px;" >
			<h5 style="margin:0px;">
				<i class="fas fa-info-circle"></i>
				Contact Us
			</h5>
		</div>
	ENDTEXT
		
RETU NIL

function MessageError( cError )

	LOCAL cHtml := ''

	TEXT TO cHtml PARAMS cError ECHO
	
		<div class="alert alert-danger" style="border-radius: 0px;" >
			<h5 style="margin:0px;">
				<i class="fas fa-exclamation-circle"></i>
				<strong>Error </strong><$ cError $>
			</h5>
		</div>
	ENDTEXT
		
RETU NIL

function MessageSave()

	LOCAL cHtml := ''

	TEXT TO cHtml ECHO 
	
		<div class="alert alert-success" style="border-radius: 0px;" >
			<h5 style="margin:0px;">
				<i class="far fa-thumbs-up"></i>
				<strong>Success ! </strong>Sus datos se han actualizado correctamente...
			</h5>
		</div>
	ENDTEXT
		
RETU NIL

function Save( hData, cError )

	local cAlias
	local dDate 
	
	//	Chequear error en parametro...
	
		if empty( hData[ 'alias' ] ) 
			cError := 'Campo Alias vacio'
			retu .f.
		endif	
	
		if empty( hData[ 'date' ] ) 
			cError := 'Campo fecha vacio'
			retu .f.
		endif
		
		if ! hData[ 'accept' ] 
			cError := 'Debe aceptar nuestras condiciones'
			retu .f.
		endif		
	
	//	Config entorno ---------------	
	
		SET EPOCH TO 1950
		SET DATE TO ITALIAN
	
	//	Abrimos Tabla ----------------

		USE ( PATH_DATA + 'contacts.dbf' ) SHARED NEW VIA 'DBFCDX'
		SET INDEX TO ( PATH_DATA + 'contacts.cdx' )
		
		cAlias := Alias()	
	
	
	//	Nuestro sistema es simple. Solo daremos de alta un ALIAS que no exista en nuestra tabla...
	
		IF (cAlias)->( DbSeek(  hData[ 'alias' ] ) ) .AND. Alltrim((cAlias)->alias) == hData[ 'alias' ]
			cError := 'Alias ya existe. Intentelo con otro'
			retu .F.
		ENDIF
		
	//	Convertimos variable fecha a date

		dDate 	:= CTod( Substr( hData[ 'date' ], 9, 2) + '/' + ;
						 Substr( hData[ 'date' ], 6, 2) + '/' + ;
						 Substr( hData[ 'date' ], 3, 2) ;
						)	
						
	//	Salvamos los datos

		(cAlias)->( DbAppend() )
		
		(cAlias)->alias	:= hData[ 'alias'  ]
		(cAlias)->name		:= hData[ 'name'   ]
		(cAlias)->mail		:= hData[ 'mail'   ]
		(cAlias)->date		:= dDate
		(cAlias)->type		:= hData[ 'class'  ]
		(cAlias)->accept	:= hData[ 'accept' ]

retu .t.
