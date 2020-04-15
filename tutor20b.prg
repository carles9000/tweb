//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#define PATH_DATA 		HB_GetEnv( "PRGPATH" ) + '/data/'

#include {% TWebInclude() %}

function main()

    local o, oCol, oWeb, oBrw, cAlias
	local aRows := {}
	local cStyle := ''
	
	//	Open dbf and data load
	
		USE ( PATH_DATA + 'contacts.dbf' ) SHARED NEW VIA 'DBFCDX'
		SET INDEX TO ( PATH_DATA + 'contacts.cdx' )	
		
		cAlias := Alias()
		
		while !Eof() 
		
			Aadd( aRows,  { 'alias' 	=> UHtmlEncode( (cAlias)->alias  )	,;
							 'name' 	=> UHtmlEncode( (cAlias)->name 	)	,;						
							 'mail' 	=> UHtmlEncode( (cAlias)->mail 	)	,;						
							 'date' 	=> DToC( (cAlias)->date 	)			,;						
							 'type' 	=> UHtmlEncode( (cAlias)->type 	)	,;						
							 'accept'	=> (cAlias)->accept 		})
			
			(cAlias)->( dbskip() )
		end
	
	//	Definie Web 

		DEFINE WEB oWeb TITLE 'Form example' TABLES INIT
		
		TEXT TO cStyle ECHO
			<style>
				.jumbotron{
					background: url("images/bg-head-02.jpg") no-repeat center center; 
					background-size: 100% 100%;
				}
			</style>	
		ENDTEXT

		Banner()	

	DEFINE FORM o ID 'demo'
	
	INIT FORM o  			

		DEFINE BROWSE oBrw ID 'ringo' HEIGHT 400 OF o

			ADD oCol TO oBrw ID 'alias' 	HEADER 'Alias' 
			ADD oCol TO oBrw ID 'name' 	HEADER 'Name' 
			ADD oCol TO oBrw ID 'mail' 	HEADER 'Mail' 
			ADD oCol TO oBrw ID 'date' 	HEADER 'Date' 
			ADD oCol TO oBrw ID 'type' 	HEADER 'Type' 		ALIGN 'center' FORMATTER 'typeFormatter'
			ADD oCol TO oBrw ID 'accept'	HEADER 'Accept' 	WIDTH 70 ALIGN 'center' FORMATTER 'acceptFormatter'	

		INIT BROWSE oBrw DATA aRows	

        ROWGROUP o

            BUTTON ID 'btn' LABEL 'Back' GRID 6 ;
				ICON '<i class="fas fa-arrow-alt-circle-left"></i> ' ;
				CLASS 'btn-outline-primary' ;
				LINK 'tutor20.prg' ;
				OF o        

        END o 		

		HTML o 
		
			<script>	

				function typeFormatter( value ) {
				
					switch ( value ) {
					
						case 'N':	
							return 'Normal';
							break;
							
						case 'P':	
							return 'Premium';
							break;
							
						case 'E':	
							return 'Excelent';
							break;					
					}									
				}
				
				
				function acceptFormatter(value, row) {
						
					if ( value )
						return '<img src="images/ball_green.png"> Ok'					
					else
						return ''
				}						
				
			</script>
			
		ENDTEXT

	END FORM o	
	
retu nil

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