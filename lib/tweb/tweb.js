
//----------------------------------------------------------------------------//

function MsgInfo( cMsg, cTitle, cIcon, fCallback ) {

	cTitle 	= (typeof cTitle ) == 'string' ? cTitle : 'Information' ;
	cIcon 	= (typeof cIcon ) == 'string' ? cIcon : '<i class="fas fa-info-circle"></i>' ;
	
	if ( typeof cMsg !== 'string' ||( typeof cMsg == 'string' && cMsg.length == 0 ))
		cMsg = '&nbsp;'
	
	//	Check animations -> https://codepen.io/ghimawan/pen/vXYYOz?editors=0010#0
	
	var dialog = bootbox.dialog({
		title: cIcon + '&nbsp;' + cTitle,
		message: cMsg,
		size: 'medium',
		backdrop: false,
		onEscape: true, 
		className: 'bounce fadeOut',
		buttons: {
			cancel: {
				label: '<i class="fa fa-check"></i> Accept',
				className: 'btn-outline-success',
				callback: function(result) {
					if ( typeof fCallback === "function") {					
						fCallback.apply(null, [result] );
					}
				}
			}
		}
	});
}

//----------------------------------------------------------------------------//

function TWebBrowse( cId ) {

	this.cId    = cId
	this.bClick = null
	this.bDblClick = null

    var oBrowse 
	
	console.log( this )
	
	this.SetData = function( rows ) {	
	   //$table.bootstrapTable( 'load', rows ) 
	   oBrowse.bootstrapTable( 'load', rows ) 
	}
	
	this.Clean = function() {	
	  oBrowse.bootstrapTable( 'load', [] )
	}	
	
	this.Select = function() {
	    return oBrowse.bootstrapTable('getSelections')
	}

	
	this.Init = function() {	    
	    
	    console.log( 'Init')
	    console.log( typeof this.bClick )
	    
	    oBrowse = $('#' + this.cId )
	    
	    if ( typeof this.bClick == 'function' ){
	        oBrowse.on('click-row.bs.table', this.bClick )
	    }
		
	    if ( typeof this.bDblClick == 'function' ){
	        oBrowse.on('dbl-click-row.bs.table', this.bDblClick )
	    }		
		
		
	    
	    oBrowse.bootstrapTable( {data: [] } )
	    
	    console.log( this )
	}	
}

function TWebGetAutocomplete( cId, uSource, cSelect ) {

	var DatasetUrl = function ( request, response ) {
	
		$.ajax({
			url: uSource,
			data: { query: request.term },
			success: function(data){ 
				response(data);
			},
			error: function(jqXHR, textStatus, errorThrown){
				MsgError( jqXHR.responseText )
			},
			dataType: 'json',
			type: 'post'
		});		
	}	
	
	
	var oPar = new Object()			
		
		if  ( $.type( uSource ) == 'array' ) {
			oPar[ 'delay' ] = 10
			oPar[ 'source' ] = uSource
		} else {
			oPar[ 'delay' ] = 200
			oPar[ 'minLength' ] = 2
			oPar[ 'source' ] = DatasetUrl	
		}
		
	var fn = window[cSelect];

		if (typeof fn === "function") {	
			oPar[ 'select' ] = fn 
		}
		

	$( "#" + cId  ).autocomplete( oPar )
}

/*	Inizialitation event system TWeb	*/

var _dsg_background, _dsg_outline

$(document).ready( function() {

console.log( 'Init TWeb system...' )

	//	Dessign event system

		$(".tweb_dessign").mouseover(function(){
		console.log( 'over')

			_dsg_background = $(this).css("background-color")
			_dsg_outline 	= $(this).css("outline")
			
			$(this).css("background-color", "#fffede");
			$(this).css("outline", "1px dashed black");
		});

		$(".tweb_dessign").mouseout(function(){
			$(this).css("background-color",_dsg_background );
			$(this).css("outline", _dsg_outline );
		});  

});
