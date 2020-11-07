//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

function main()

	local hRow := {=>}
	local cI	:= ''
	
    AEval( rddList(), {| X | cI += iif( Empty( cI ), '', ', ' ) + X } )

	hRow[ 'os' ] 						:= OS()
	hRow[ 'harbour' ] 					:= Version()
	hRow[ 'build' ] 					:= hb_BuildDate()
	hRow[ 'modbuild' ] 					:= modBuildDate()
	hRow[ 'compiler' ] 					:= hb_Compiler()
					
	hRow[ 'rdd' ] 						:= cI
	
	hRow[ 'hb_version_harbour' ] 		:= hb_Version( 0 )
	hRow[ 'hb_version_compiler' ] 		:= hb_Version( 1 )
	hRow[ 'hb_version_build_date' ] 	:= hb_Version( 11)
	hRow[ 'hb_version_mt' ]				:= hb_Version( 21)
	hRow[ 'hb_version_shared' ]			:= hb_Version( 22)
	hRow[ 'hb_version_platform' ]	 	:= hb_Version( 24)

	
	hRow[ 'tweb_version' ]		 		:= TWebVersion()

	//hRow[ 'mercury' ]				 	:= App():Version()
	//hRow[ 'wdo' ]				 		:= WDO():Version()				
	
	
BLOCKS PARAMS hRow

<style>
		.myhead {			
			padding: 5px;
			background-color: white;
			margin-bottom: 20px;
		}

		.myhead > span {				
			font-family: times, Times New Roman, times-roman, georgia, serif;
			font-size: 28px;
			line-height: 40px;	
			color: #15385a;	
			font-family: Tahoma, Verdana, Segoe, sans-serif;			
		}


		#mylogo {			
			margin-right: 10px;
			vertical-align: middle;
			margin-top: -15px;
		}
		
		#content {
			margin: 20px;
			text-align: center;
		}		

	.table {
		width:100%;
		border: 1px solid black;
		cellspacing: 2;
		box-shadow: 4px 4px 3px #9E9E9E;		
	}
	
	.thead {
	
		background-color:#15385a;
		color:white;
		font-weight: bold;
		font-family: Tahoma, Verdana, Segoe, sans-serif;
	}

	.description {
		text-align: right;
		font-weight: bold;
		width: 200px;
		padding-right: 10px;
		font-family: Tahoma, Verdana, Segoe, sans-serif;
	}
	
	.data {						
		padding-left: 10px;
		font-family: Tahoma, Verdana, Segoe, sans-serif;
		/*
        color: #424242;
	color: #424242; 
    font-family: "Adobe Caslon Pro", "Hoefler Text", Georgia, Garamond, Times, serif;
    font-size: 14px; 
    font-variant: small-caps;		*/
	}	

</style>

		<div class="myhead">			
			<img id="mylogo" src="images/harbour_mini.png">
			<span>TWeb Information System</span>			
			<hr>
		</div>
		
		<div id="content">

			<table class='table'>
				<thead class='thead'>
					<tr><td class="description">Description</td><td class="data">Value</td></tr>
				</thead>
				<tbody>
					<tr><td class="description">OS</td><td class="data">{{ hRow[ 'os' ] }}</td></tr>
					<tr><td class="description">Harbour</td><td class="data">{{ hRow[ 'harbour' ] }}</td></tr>
					<tr><td class="description">Build Date Harbour</td><td class="data">{{ hRow[ 'build' ] }}</td></tr>
					<tr><td class="description">Build Date modHarbour</td><td class="data">{{ hRow[ 'modbuild' ] }}</td></tr>
					<tr><td class="description">Compiler</td><td class="data">{{ hRow[ 'compiler' ] }}</td></tr>
					<tr><td class="description">RDD</td><td class="data">{{ hRow[ 'rdd' ] }}</td></tr>

					<tr><td class="description">Version MT</td><td class="data">{{ hRow[ 'hb_version_mt' ] }}</td></tr>					
					<tr><td class="description">Version Platform</td><td class="data">{{ hRow[ 'hb_version_platform' ] }}</td></tr>							
					<tr><td class="description">Version TWeb</td><td class="data">{{ hRow[ 'tweb_version' ] }}</td></tr>							
				</tbody>
			</table>
		</div>
ENDTEXT

retu nil