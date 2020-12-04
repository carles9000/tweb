//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    local o, oCol, oBrw
	local aRows 	:= {}

	Aadd( aRows, { 'id' => 'A1', 'name' => 'Cooler Master Hyper 212 Black Edition' 	, 'image' => 'cooler.jpg' 	, 'pvp' => 38.99, 'qty' => 1 } )
	Aadd( aRows, { 'id' => 'A2', 'name' => 'NOX Modus Blue Edition USB 3.0' 		, 'image' => 'nox.jpg' 		, 'pvp' => 38.50, 'qty' => 1 } )
	Aadd( aRows, { 'id' => 'A3', 'name' => 'MSI B450 Gaming Plus MAX' 				, 'image' => 'nox.jpg' 		, 'pvp' => 97.85, 'qty' => 1 } )
	Aadd( aRows, { 'id' => 'A4', 'name' => 'Samsung 860 EVO Basic SSD 500GB SATA3' 	, 'image' => 'ddr.jpg' 		, 'pvp' => 68.99, 'qty' => 1 } )
	Aadd( aRows, { 'id' => 'A5', 'name' => 'Asus GeForce GT 710 2GB GDDR5 ' 		, 'image' => 'video.jpg' 	, 'pvp' => 49.99, 'qty' => 1 } )
	

	DEFINE WEB oWeb TITLE 'Browse - TIC' TABLES INIT
	
	DEFINE FORM o

		HTML o INLINE '<h3>Shop List</h3><hr>'
		
		HTML o
		
			<style>
			
				.myimg {
					float:left;
				}
				
				.myimg  img {
					height:40px;
				}
				
				.mydata {
					float: left;
					margin-left: 10px;
					font-size: small;
				}
				
				.myname {
					font-style: italic;
				}
				
				.mypvp {
					font-weight: bold;
					color: #2196F3;					
				}
				
			</style>
		
		ENDTEXT 
		
	INIT FORM o 
	
		DEFINE BROWSE oBrw ID 'ringo' MULTISELECT CLICKSELECT HEIGHT 400 OF o
		
			//oBrw:lDark = .t.
			oBrw:lStripped := .t.			
			
			ADD oCol TO oBrw ID 'dummy' 		HEADER 'Cesta' 	FORMATTER 'MyId'	

		INIT BROWSE oBrw DATA aRows			
		
		HTML o 
		
			<script>

				function MyId( value, row ) {
					
					var cHtml  = '<div>'									
					    cHtml += '  <div class="myimg">'
					    cHtml += '    <img src="images/tic/' + row.image + '"></img>'
					    cHtml += '  </div>'
					    cHtml += '  <div class="mydata">'
					    cHtml += '    <div class="myname">' + row.name + '</div>'
					    cHtml += '    <div class="mypvp">' + row.pvp + '€</div>'					    
					    cHtml += '  </div>'
					    cHtml += '</div>'										
						
					return cHtml
				}
				
			</script>
		
		ENDTEXT
	
	END FORM o	
	
retu nil