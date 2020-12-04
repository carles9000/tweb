//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    local o, oCol, oBrw
	local aRows 	:= {}
	local hCars 	:= {=>}
	
	Aadd( aRows, { 'id' => 'A1', 'name' => 'Charly Aubia' 	})
	Aadd( aRows, { 'id' => 'A2', 'name' => 'Maria de la O'	})
	Aadd( aRows, { 'id' => 'A3', 'name' => 'John Kocinsky'	})
	Aadd( aRows, { 'id' => 'A4', 'name' => 'Anne Clark'  	})	
	Aadd( aRows, { 'id' => 'A5', 'name' => 'Daniel Clark'	})	
	Aadd( aRows, { 'id' => 'A6', 'name' => 'Rod Steward'  	})	
	

	DEFINE WEB oWeb TITLE 'Browse - Btn' TABLES INIT
	
	DEFINE FORM o

		HTML o INLINE '<h3>Basic Browse</h3><hr>'			
		
	INIT FORM o 

		DEFINE BROWSE oBrw ID 'ringo' HEIGHT 400  OF o

			ADD oCol TO oBrw ID 'id' 		HEADER 'Id.' 		ALIGN 'center' 
			ADD oCol TO oBrw ID 'name'		HEADER 'Name' 
			ADD oCol TO oBrw ID 'test'		HEADER 'Test' 		ALIGN 'center' FORMATTER 'MyBtnClick' WIDTH 100			

		INIT BROWSE oBrw DATA aRows	
		
		
		HTML o 
		
			<script>
				
				function MyBtnClick( value, row, index ) {				
					return '<button class="btn btn-primary like" pageName="' + row.name + '" pageDetails="' + row.qty + '"  >Show</button> ';					
					//return '<a class="like" href="javascript:void(0)" title="Like"><i class="fa fa-heart"></i></a>'
				}
				
				function MyAction( e, value, row, index ) {
					alert('You click like action, row: ' + JSON.stringify(row))
				}
				
				//window.TWebOperateEvents = { 'click .like': MyAction } 
				
				/*
				$(".mybtnclick2").click(function(e){
					var pageDetails = $(this).attr('pageDetails');
					var pageName = $(this).attr('pageName');
					console.log('mybtnclick' )
					MsgInfo( pageName + ' ' + pageDetails )
					e.stopPropagation();

				});
				*/
				
				/*
				window.operateEvents = {
					'click .like': function (e, value, row, index) {
					  alert('You click like action, row: ' + JSON.stringify(row))
					}
				}
				*/
				

			</script>
		
		ENDTEXT		

	
	END FORM o	
	
retu nil