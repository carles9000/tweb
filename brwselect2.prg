//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o, oWeb

	DEFINE WEB oWeb TITLE 'Browse Select' TABLES INIT


    DEFINE FORM o 

	INIT FORM o  	

		HTML o INLINE '<h3>Test BrwSelect() 2</h3><hr>'	
			
		ROWGROUP o
			BUTTON LABEL 'Test TWebBrwSelect()' GRID 6 ACTION 'Test()' OF o      			
		ENDROW o
		
		HTML o
		
			<script>			
				
				function Test() {

					
					var headers = { 'id' : 'Id.' , 'name': 'Item Name', 'price': 'Precio' } 										
					
					var rows = [ { 'id' :1 , 'name' : 'Pepi', 'price' : 123  , 'dummy' : 1 } ,
								 { 'id' :2 , 'name' : 'Mari', 'price' : 345  , 'dummy' : 2 } ,
								 { 'id' :3 , 'name' : 'Runa', 'price' : 757  , 'dummy' : 3 } ,
								 { 'id' :4 , 'name' : 'Site', 'price' : 111  , 'dummy' : 4 } , 
								 { 'id' :5 , 'name' : 'Boyi', 'price' : 222  , 'dummy' : 5 } ,
								 { 'id' :6 , 'name' : 'John', 'price' : 757  , 'dummy' : 6 } ,
								 { 'id' :7 , 'name' : 'John', 'price' : 888  , 'dummy' : 7 }, 
								 { 'id' :8 , 'name' : 'John', 'price' : 777  , 'dummy' : 8 }, 
								 { 'id' :9 , 'name' : 'John', 'price' : 666  , 'dummy' : 9 }, 
								 { 'id' :10, 'name' : 'John', 'price' : 555  , 'dummy' : 6 } 
								]	

					var oOptions = new Object()
						oOptions[ 'search' ] = false 
						oOptions[ 'height' ] = 200 
						//oOptions[ 'select' ] = false
					
					TWebBrwSelect( headers, rows, myfunc, '<i class="fas fa-user-friends"></i> My Customers', oOptions )
				}
		
				function myfunc( row ) {

					if ( row ) {					
						MsgInfo( row.name + '<br>' + row.price )					
					}						
				}
			
			</script>			
		
		ENDTEXT
			
		
    END FORM o	
	
retu nil