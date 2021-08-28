function main()

	local hGet := Ap_getpairs()

	if valtype( hGet ) == 'H' .and. HB_HHasKey( hGet, 'prg' )
	
		if lower( hGet[ 'prg' ] ) == 'view.prg'
			retu
		endif
			

		if file( hb_getenv( 'PRGPATH') + '/' +  hGet[ 'prg' ]  )
			ShowFile( hGet[ 'prg' ] )			
		endif
	else
	
		retu 
		
	endif
	

retu nil

function ShowFile( cFile )

	local cHtml := ''

	BLOCKS PARAMS cFile
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">	
	<meta name="description" content="TWeb es el primer framework para modHarbour que sirve para crear pantallas web"> 
	<meta name="description" content="TWeb is the first framework for modHarbour used to create web screens"> 
	<meta name="keywords" content="tweb, mercury, harbour, modharbour, clipper, fivewin, web, framework">
	<meta name="Author" content="Carles Aubia Floresvi">
	<meta name="Generator" content="TWeb from iTarraco">
	
	<link rel="icon" href="images/tweb.png" type="image/x-icon" >
	<link rel="shortcut icon" href="images/tweb.png" type="image/x-icon">	
	
    <title>TWeb para mod Harbour</title>
 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="ace/src-noconflict/ace.js" type="text/javascript" charset="utf-8"></script>

	
	<style>
		#mycode {
			position: absolute;
			top: 0;
			left: 0;
			bottom: 0;
			right: 0;
			background-color: #141414;
			display: none;
		}
		#mycodebar {
			background-color: gray;
			color: white;
			font-family: cursive;
			padding-left: 10px;
		}
		#code {
			position: relative;
			top: 0px;			
			height: 95%;
		}
		
		.btn {
			cursor:pointer;
			float: right;
			margin-top: 4px;
			margin-right: 5px;
		}
		
		#load {
			position: absolute;
			top: 45%;
			left: 50%;
			transform: translate(-50%,-50%);		
		}
	
		#load img {
			width:100%;
		}		
		
		
		
		
	</style>

  </head>
  <body>	

	<div id="load">
		<img src="images/loading.gif"> 		
	</div>
	
	<div id="mycode">
		<div id="mycodebar">	
			<img src="images/run.png" class="btn" onclick="Go()"> 		
			<img src="images/save.png" class="btn" onclick="Download()">
			<small id='filename'></small>		
		</div>
		<div id="code"></div>
	</div>

	<script>

		var editor 		= ace.edit("code");
		editor.session.setMode("ace/mode/javascript");
		editor.setTheme("ace/theme/twilight");
		editor.getSession().setUseWorker(false);
		editor.setOptions( { 
			fontSize: "12pt",
			readOnly: true,
			selectionStyle: "text", 	//	"line"|"text"
			highlightActiveLine: true,
			showPrintMargin: true, 
			printMarginColumn: 80,
			showLineNumbers: true,
			showGutter: true,
			displayIndentGuides: false,
			tooltipFollowsMouse: false,
			enableBasicAutocompletion:true,					
		})					

		$.get( 'read.prg', '{{ cFile }}', function(data, status){			
			editor.setValue(data,1)
			$('#filename').html( 'Source: ' + '{{ cFile }}' )
			//$('#mycode').show()						
			$('#mycode').fadeIn("slow")						
			$('#load').fadeOut("slow", function(){ $('#load').remove() } )					
		})		
		
		function Go() {
		
			if ( !confirm( 'Execute code?' ) )
				return null
				
			window.location.href = '{{ cFile }}'		
			
		}
		
		//	https://attacomsian.com/blog/javascript-download-file
		function Download() {			
			
			const anchor = document.createElement('a');
			anchor.href = "download?prg={{ cFile }}";
			anchor.download = "{{ cFile }}";			

			// Append to the DOM
			document.body.appendChild(anchor);

			// Trigger `click` event
			anchor.click();

			// Remove element from DOM
			document.body.removeChild(anchor);	
		}						
		
	</script>
  </body>
</html>	
	
	
	ENDTEXT 

retu 