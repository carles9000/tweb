//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o

	DEFINE WEB oWeb TITLE 'Button Upload' INIT

    DEFINE FORM o ID 'demo'	
		o:lDessign := .F.
		
		HTML o FILE 'html-title.tpl' PARAMS '<i class="far fa-share-square"></i>', 'Form example'


    INIT FORM o  		
		
		ROWGROUP o								
			HTML o INLINE '<input type="file" id="_mybtn"  style="display:none;" multiple " />'
			
			HTML o INLINE '<input type="file" id="_mybtn2" multiple  />'
			
			BUTTON ID 'mybtn'	LABEL 'File to Upload' ICON '<i class="fas fa-upload"></i> ' ACTION 'Upload()' GRID 4 OF o        
		END o								

		HTML o
			<div >
				<small id="log"></small>
			</div>
		ENDTEXT				
		
		HTML o 
		
			<script>			
	
				
				
				function Upload() {
				
					var o = new TWebButtonUpload( '_mybtn', 'btnupload-server.prg', Post_Import, MyError )
						o.onprogress 		= Imp_OnProgress
						o.onloadstart		= Imp_OnLoadStart
						o.onloadend		= Imp_OnLoadEnd
						o.onreading		= Imp_OnReading					
					o.Init()	
					
					return false;										
				}
				
				function Post_Import( dat ) {
				
					console.log( 'POST_IMPORT', dat )				
				}
				
				function MyError( dat, cFile ) {
				
					switch (dat.status) {
				   
						case 404:
							Log( '<b>Error ! File not found: </b>' + cFile)
							break;
							
						default:
							Log( data.responseText )							
					}												
				}
				
				function Imp_OnLoadEnd( e ) {
						
					console.log( 'ONLOADEND', e )
					Log( 'OnLoad end! Init Upload')
				}
				
				function Imp_OnProgress( e, n ) {
				
					console.log( 'ONPROGRESS', n )
					
					Log( 'Progress ' + n + ' %' )					
					
					if ( n >= 100 ) {
						console.log( 'COMMIT FILE - WORKING...' )		
						Log( 'Commit file - Working...' )
					}
				}

				function Imp_OnReading( e, n ) {
				
					console.log( 'ONREADING', e.loaded + '/' + e.total )
					console.log( 'ONREADING', n )	
					Log( 'onreading: ' + e.loaded + '/' + e.total )
				}	
				
				function Imp_OnLoadStart(e) {
				
					//$('#log').html( 'Done!' )				
					
					Log( 'Start !' )
				
					console.log( 'ONLOADSTART', e )
				}
				
				function Log( cText ) {
					var c = $('#log').html() 
					
					c += '<br>' + cText 
					
					$('#log').html( c )
					
				}
				
				//	--------------------------------------------------
				
				function NewUpload( o ) {
				
					console.log( o.files )
				
				}
				
				

				$(document).ready(function () {
					console.log( 'TWeb Init Btn' )	
					
							
					$('#_mybtn2').change( function () 	{
					
						for (var i = 0; i < this.files.length; i++) {							
														
							var i = 0, len = this.files.length, img, reader, file;
							console.log( len)
							
							formdata = new FormData();

							for (i=0; i < len; i++) {
							
								file = this.files[i];
								
								console.log( 'FILE', file )

								
									reader = new FileReader();
									reader.onloadend = function(e) {
										//showUploadedItem(e.target.result, file.fileName);
										var blob = new Blob( [e.target.result], {type: "application/octet-stream"} );
										formdata.append( file.name, blob )
									};
									reader.readAsDataURL(file);
									console.log( 'reader', reader )
								
								
								//formdata.append("file", file);								
							}
							
							console.log( 'FORMADATA', formdata )
							
							$.ajax({
								url: "btnupload-server.prg",
								type: "POST",
								data: formdata,
								processData: false,
								contentType: false,
								success: function(res) {
									console.log( 'success', res )
								},       
								error: function(res) {
									console.log( 'error', res )
								}       
							});
							
													
							
							
							
						}
					});					
					
					
				})				
			
			</script>		
		
		ENDTEXT		
		
    END FORM o	
	
retu nil