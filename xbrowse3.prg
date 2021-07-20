//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    local o, oCol, oBrw
	local aRows 	:= LoadData()	//	Registers + id (recno)

	DEFINE WEB oWeb TITLE 'xBrowse III' TABLES INIT
	
	DEFINE FORM o

		HTML o INLINE '<h3>Basic xBrowse III</h3><hr>'	

		HTML o
		
			<style>
			
				.mybtnbar {
					border-radius:0px;
				}				

				.mycustombar {			
					background-color: lightgray;
					padding: 5px;
					border-bottom: 1px solid black;
					border-right: 1px solid black;
					border-radius:0px;						
				}
				
			</style>
		
		ENDTEXT 		
		
	INIT FORM o
		
		DEFINE BROWSE ID 'ringo' DATA aRows UNIQUEID 'id' OF o
		
	
		ROW o	TOP '50px' CLASS 'mycustombar' 
			BUTTON LABEL 'Changes' 			ACTION 'Changes()'  		CLASS 'btn-secondary mybtnbar' GRID 0 OF o			
			BUTTON LABEL 'Reset Changes' 	ACTION 'ResetChanges()' 	CLASS 'btn-secondary mybtnbar' GRID 0 OF o			
			BUTTON LABEL 'GetRow' 			ACTION 'GetRow()'  			CLASS 'btn-secondary mybtnbar' GRID 0 OF o			
			BUTTON LABEL 'GetAll'			ACTION 'GetAll()'  			CLASS 'btn-secondary mybtnbar' GRID 0 OF o								
		ENDROW o						
		
		HTML o 
		
			<script>
	
				var oBrw 	= new TWebBrowse( 'ringo' )			
				
				function Changes() 	{ 
					MsgNotify( 'Check console...');					
					console.log( 'Changes', oBrw.GetDataChanges() );					
				}
				
				function ResetChanges() { 
					oBrw.ResetChanges(); 
					Changes();  
				}

				function GetRow() {
					MsgNotify( 'Check console...');	
					console.log( 'GetRow', oBrw.GetRow() )
				}
				
				function GetAll() {
					MsgNotify( 'Check console...');	
					console.log( 'GetAll', oBrw.GetData() )
				}
				
			</script>
		
		ENDTEXT				
	
	END FORM o	
	
retu nil

{% LoadFile( 'loaddata.prg' ) %} 