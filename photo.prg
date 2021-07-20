//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}
//	Info webcamjs https://github.com/jhuckaby/webcamjs/blob/master/DOCS.md
//	https://github.com/jhuckaby/webcamjs/blob/master/DOCS.md#important-note-for-chrome-47

#include {% TWebInclude() %}

function main()

    LOCAL o

	DEFINE WEB oWeb TITLE 'Photo' 

		oWeb:AddJs( 'https://cdnjs.cloudflare.com/ajax/libs/webcamjs/1.0.25/webcam.min.js' )	
	
	INIT WEB oWeb
	
    DEFINE FORM o
		o:lDessign := .t.
	
	INIT FORM o
	
	
		ROW o HALIGN 'center'			
			HTML o INLINE '<div id="my_camera" style="overflow: hidden;"></div>'					
		ENDROW o 

		ROW o HALIGN 'center'
		
			BUTTON LABEL '<i class="fas fa-camera-retro"></i> Take' GRID 4 ALIGN 'center' ACTION 'Take_Snapshot()' OF o
			BUTTON LABEL 'Unfreeze' GRID 4 ALIGN 'center' ACTION 'UnFreeze()' OF o
			BUTTON LABEL 'Save' GRID 4 ALIGN 'center' ACTION 'Save()' OF o
		
		ENDROW o 			
		
		HTML o
			<script>

				Webcam.set({
					width: 320,			//520
					height: 280,		//	400				
					image_format: 'jpeg',
					jpeg_quality: 120
				});
				
				
				Webcam.set( 'constraints',{ facingMode:'environment' });	// 	Camera trasera. Siempre antes de .attach()

				Webcam.attach( '#my_camera' );	

				function Take_Snapshot() {
				
					// freeze camera so user can preview pic
						Webcam.freeze();
					
				}
				
				function UnFreeze() {
					Webcam.unfreeze();
				}
				
				function Save() {	
					
					Webcam.snap( function(data_uri) {						
						
						var oData = new Object()
							oData[ 'string' ] = '12345678'
							oData[ 'numeric' ] = 12345678
							oData[ 'logic' ] = true																		
							
						TWebUploadUri( data_uri, 'srv_upload_photo.prg', Post_UploadImage, oData )										
					});						
				}
				
				function Post_UploadImage( dat ) {
				
					console.log( dat )
					MsgInfo( dat.file )
				}
				
				/*
					For lastest version 1.0.26, set constraints like this:

					Webcam.set('constraints',{
									deviceId: { exact: deviceId }
								 });
					The deviceId get by navigator.mediaDevices.enumerateDevices(), so you can switch camera by device id to what you want.
					
					console.log( navigator.mediaDevices.enumerateDevices() )
				*/								
				
				Webcam.on( 'load', function() {
					console.log( 'library is loaded' )
				} );
				
				Webcam.on( 'live', function() {
					console.log( 'camera is live, showing preview image (and user has allowed access)' )
				} );
				
				Webcam.on( 'error', function(err) {
					console.log( 'an error occurred' )
				} );				
				
				
			</script>		
		ENDTEXT	
		
		HTML o 
		
		
		
		ENDTEXT
			
    END FORM o	
	
retu nil