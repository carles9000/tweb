//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o

	DEFINE WEB oWeb TITLE 'Button Upload' INIT

    DEFINE FORM o
	
		HTML o FILE 'templates/title_test.tpl' PARAMS 'Test Button Upload'	

	INIT FORM o  	
	
		BUTTON ID 'myupload' LABEL ' Upload' GRID 6 FILES ACTION 'UploadFile()' OF o 		
		
		HTML o
			<script>
			
				function UploadFile() {				
				
					var o = new TWebUpload( 'myupload', 'srv_upload.prg', Post_UploadFile )
		
					o.Init()					
				}

				function Post_UploadFile( dat ) {
				
					console.log( 'Post_UploadFile', dat )
					
					MsgInfo( 'File uploaded' )
				}
				
			</script>		
		ENDTEXT	
			
    END FORM o		
	
retu nil