//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o, oWeb
	LOCAL cHtml := ''

	
	
	DEFINE WEB oWeb TITLE 'Test Html' 

		//	url("https://placeimg.com/1000/480/nature")
		
		HTML oWeb
			<style>
				.jumbotron{
					background: url("images/bg-head-02.jpg") no-repeat center center; 
					background-size: 100% 100%;
					border-radius: 0px;
				}
				
				.container h3, h5 {
					text-shadow: 2px 2px #ffffff;;				
				}				
			</style>			
		
		ENDTEXT 
		
	INIT WEB oWeb
	
	DEFINE FORM o 
		
		Banner(o)

	INIT FORM o  		
	
		HTML o 
			<div class="alert alert-success">				
				<img src="images/tweb.png"/><strong> Success!</strong> Indicates a successful or positive action.
			</div>
		ENDTEXT		
	
		HTML o INLINE '<h3>Test Html</h3><hr>'
		
	END FORM o
	
retu nil

function Banner( o )
	
	HTML o
		<div class="jumbotron">
			<div class="container">
				<h1><a href="">Friends of mod harbour</a></h1>
				<h3>modHarbour group project.</h3>
				<h5>Html code example</h5>
			</div>
		</div>
	ENDTEXT			

retu nil