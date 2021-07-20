//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o

	DEFINE WEB oWeb TITLE 'Button Upload' INIT

    DEFINE FORM o
	
		HTML o FILE 'templates/title_test.tpl' PARAMS 'Test Button Upload - Extended'	

	INIT FORM o  	

		ROWGROUP o
			BUTTON ID 'myupload' LABEL ' Upload' GRID 6 FILES ACTION 'UploadFile()' ICON '<i class="fas fa-cloud-upload-alt"></i>'  OF o 		
		ENDROW o
		
		ROWGROUP o
			SAY ID 'log' VALUE '<h5>Log</h5><hr>' BORDER GRID 12 OF o			
		ENDROW o			
		
		HTML o
			<script>
			
				function UploadFile() {
				
					var oPar = new Object()
						oPar[ 'age'  ] = 53
						oPar[ 'name' ] = 'James Brown'
						oPar[ 'married' ] = true 
						
				
					var o = new TWebUpload( 'myupload', 'srv_upload_ext.prg', Post_UploadFile, oPar )
						o.onprogress 	= Imp_OnProgress
						o.onloadstart	= Imp_OnLoadStart
						o.onloadend		= Imp_OnLoadEnd
						o.onreading		= Imp_OnReading	
		
					o.Init()					
				}

				function Post_UploadFile( dat ) {
				
					console.log( 'Post_UploadFile', dat )
				
					Log( 'End process' )
					
					if ( dat.success )
						MsgInfo( 'File uploaded!' )
					else
						MsgError( dat.msg )
				}
				
				function Imp_OnLoadStart(e) {

					$('#log').html( '<h5>Log</h5><hr>' )
					
					Log( 'OnLoadStart !' )
				}
				
				function Imp_OnLoadEnd( e ) {
				
					Log( 'OnLoad end! Init Upload')
				}
				
				function Imp_OnProgress( e, n ) {
					
					Log( 'OnProgress - Uploading... ' + n + ' %' )					
					
					if ( n >= 100 ) {
						Log( 'OnProgress - Commit file - Working...' )
					}
				}

				function Imp_OnReading( e, n ) {

					Log( 'OnReading: ' + e.loaded + '/' + e.total )
				}					

				function Log( cText ) {
	
					var cLog = $('#log').html() 	
					
					cLog +=  cText + '<br>' 
					
					$('#log').html( cLog )					
				}			
				
			</script>		
		ENDTEXT	
			
    END FORM o		
	
retu nil