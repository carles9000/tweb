//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o

	DEFINE WEB oWeb TITLE 'MsgNotify()' INIT

    DEFINE FORM o
	
		HTML o FILE 'templates/title_test.tpl' PARAMS 'Test MsgNotify()'	

	INIT FORM o  
	
		ROWGROUP o
			SAY VALUE "MsgNotify()" GRID 6 ALIGN 'right' OF o
			BUTTON LABEL 'Test' GRID 4 ACTION "MsgNotify( 'Hello! I\'m a notify' )"  OF o        			
		ENDROW o
		
		ROWGROUP o
			SAY VALUE "Test all types" GRID 6 ALIGN 'right' OF o
			BUTTON LABEL 'Test' GRID 4 ACTION "TestTypes()"  OF o        			
		ENDROW o		
		
		ROWGROUP o
			SAY VALUE "Example native function $.notify()" GRID 6 ALIGN 'right' OF o
			BUTTON LABEL 'Test' GRID 4 ACTION "TestNative()"  OF o        			
		ENDROW o	
		
		ROWGROUP o
			SAY VALUE "Page from author" GRID 6 ALIGN 'right' OF o
			BUTTON LABEL 'Test' GRID 4 ACTION "TestUrl()"  OF o        			
		ENDROW o			
		
		
		HTML o
			<script>
			
				function TestTypes() {
				
					MsgNotify( '<b>success</b> Test MsgNotify()', 'success' )
					MsgNotify( '<b>danger</b> Test MsgNotify()', 'danger' )
					MsgNotify( '<b>info</b> Test MsgNotify()', 'info' )
					MsgNotify( '<b>warning</b> Test MsgNotify()', 'warning' )
				
				}			
			 

				function TestNative() {
				
					$.notify({
						icon: "images/tweb.png",
						title: " <b>I am using TWeb</b><br>",
						message: " Click me & check out Compass page. The <b>modHarbour</b> help page !",
						url: "https://modharbour.app/compass/search/tweb"											
					},{
						icon_type: 'image',
						type: 'success',
						animate: {
								enter: 'animated fadeInRight',
								exit: 'animated fadeOutRight'
							}	
					});
					
				}	

				function TestUrl() {
				
					$.notify({
						title: "<b>Bootstrap Notify</b><br>",
						message: "Click me & check out examples",
						url: "http://bootstrap-growl.remabledesigns.com/",
						target: "_self"
					});				
				}			
				
				
			</script>		
		ENDTEXT	
			
    END FORM o	
	
	
retu nil