//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o

	DEFINE WEB oWeb TITLE 'Button Upload' INIT

    DEFINE FORM o ID 'demo'	
		o:lDessign := .F.
		
		//HTML o FILE 'html-title.tpl' PARAMS '<i class="far fa-share-square"></i>', 'Form example'
		
		//HTML o PRG 'html-title.prg'  PARAMS '<i class="far fa-share-square"></i>', 'Form example'
		
		HTML o PRG 'html-title.prg' FUNC 'Test1' PARAMS 'abc', '123'

    INIT FORM o  		
		
		ROWGROUP o								
			HTML o INLINE '<input type="file" id="_mybtn" style="display:none;" />'
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

					//$('#log').html( 'Progress ' + n + ' %' )
					
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

				$(document).ready(function () {
					console.log( 'TWeb Init Btn' )					
				})				
			
			</script>		
		
		ENDTEXT
		
		
    END FORM o	
	
retu nil