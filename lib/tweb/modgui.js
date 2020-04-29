/*	-------------------------------------------------------------------------
	Rutines Genériques
	------------------------------------------------------------------------*/
	
function MsgNotify( cMsg, cType, cTitle, cImage ) {

	cType 	= (typeof cType ) == 'string' ? cType : 'success' ;
	cTitle 	= (typeof cTitle ) == 'string' ? cTitle : 'Information' ;
	
	if ( cMsg.length == 0 )
		cMsg = '&nbsp;'	
	
	switch (cType){
		case 'success':
			cType 	= 'success'
			break;
			
		case 'alert':
			cType 	= 'danger'
			break;			
	
	}
	
	$.notify({
		icon: cImage,
		message: '&nbsp;<strong>' + cTitle + '</strong>&nbsp;' + cMsg
	},{
		type: cType,		
		icon_type: 'image',
		animate: {
			enter: 'animated fadeInRight',
			exit: 'animated fadeOutRight'
		}		
	});	
	
	
}

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
				className: 'btn-success',
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

function MsgError( cMsg, cTitle, cIcon ) {

	cTitle 	= (typeof cTitle ) == 'string' ? cTitle : 'System Error' ;
	cIcon 	= (typeof cIcon ) == 'string' ? cIcon : '<i class="fas fa-bug"></i>' ;
	
	if ( typeof cMsg !== 'string' ||( typeof cMsg == 'string' && cMsg.length == 0 ))
		cMsg = '&nbsp;'
	
	var dialog = bootbox.dialog({
		title: cIcon + '&nbsp;' + cTitle,
		message: cMsg,
		size: 'large',
		backdrop: false,
		onEscape: true, 		
		className: 'rubberBand animated',
		buttons: {
			cancel: {
				label: '<i class="fa fa-check"></i> Accept',
				className: 'btn-danger',
				callback: function(){}
			}
		}
	});
}

//----------------------------------------------------------------------------//

function MsgYesNo( cMsg, fCallback, cTitle, cIcon ) {

	cTitle 	= (typeof cTitle ) == 'string' ? cTitle : 'Information' ;
	cIcon 	= (typeof cIcon ) == 'string' ? cIcon : '<i class="fas fa-bug"></i>' ;
	
	if ( typeof cMsg !== 'string' ||( typeof cMsg == 'string' && cMsg.length == 0 ))
		cMsg = '&nbsp;'


	bootbox.confirm({
		title: cTitle,
		message: cMsg,
		buttons: {
			cancel: {
				label: '<i class="fa fa-times"></i> Cancel'
			},
			confirm: {
				label: '<i class="fa fa-check"></i> Confirm'
			}
		},
		callback: function (result) {
		
			if ( typeof fCallback === "function") {					
				fCallback.apply(null, [result] );
			}
		}
	});	

}


//----------------------------------------------------------------------------//

function MsgServer( cUrl, oValues, fCallback ) {

	var cType 	= $.type( oValues )
	var oPar 	= new Object()
		
	switch ( cType ) {
	
		case 'object':
			oPar[ 'type' ] = 'H'
			oPar[ 'value' ] = JSON.stringify( oValues ) 	
			break;
			
		case 'string':
				
			oPar[ 'type' ] = 'C'
			oPar[ 'value' ] = oValues	
			break;	
			
		case 'boolean':
				
			oPar[ 'type' ] = 'L'
			oPar[ 'value' ] = oValues	
			break;	

		case 'number':
				
			oPar[ 'type' ] = 'N'
			oPar[ 'value' ] = oValues	
			break;			
			
		default:
		
			oPar[ 'type' ] = 'U'
			oPar[ 'value' ] = oValues;				
	}
	
//----------------------------------------------------	

	console.log( 'MsgServer()', oValues )
	console.log( 'MsgServer() Send', oPar )
	
	$.post( cUrl, oPar )		
		.done( function( data ) { 
		
			console.log( 'DONE', data )

			if ( typeof fCallback === "function") {					
				fCallback.apply(null, [data] );				
			} 
		})
		.fail( function(data){ 
			console.log( 'FAIL', data )
			MsgError( data.responseText ) 
		})
}

//----------------------------------------------------------------------------//

function MsgLoading( cMessage, cTitle, cIcon ) {

	cMessage 	= (typeof cMessage ) == 'string' ? cMessage : 'Loading...' ;
	cTitle 		= (typeof cTitle ) == 'string' ? cTitle : 'System' ;
	cIcon 		= (typeof cIcon ) == 'string' ? cIcon : '<i class="fas fa-sync fa-spin"></i>' ;

	var dialog = bootbox.dialog({
            title: cTitle,
            message: '<p>' + cIcon + '&nbsp;'  + cMessage + '</p>',
			animate: false,
            //closeButton: false
        }); 

	return dialog
}

function MsgLog( cMessage, cTitle ) {

	cMessage 	= (typeof cMessage ) == 'string' ? cMessage : ' ' ;
	cTitle 		= (typeof cTitle ) == 'string' ? cTitle : '<i class="far fa-file-alt"></i>&nbsp;System Log' ;
	
	bootbox.dialog({							
		size: 'large',
		title: cTitle,																										
		message: cMessage,
		onEscape: true,
		buttons: {
			confirm: {
				label: '<i class="fa fa-check"></i> Accept'
			}
		}								
	})
	.find(".modal-dialog").addClass("msg_dialog_log")
	.find(".modal-content").addClass("msg_content");		
	
	return null
}




function IsMobile() {

	var isMobile = false; //initiate as false
	// device detection
	if(/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|ipad|iris|kindle|Android|Silk|lge |maemo|midp|mmp|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino/i.test(navigator.userAgent) 
		|| /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(navigator.userAgent.substr(0,4))) { 
		isMobile = true;
	}
	
	return isMobile
}

//----------------------------------------------------------------------------//

function loadCSS(href) {

	  var cssLink = $("<link>");
	  $("head").append(cssLink); //IE hack: append before setting href

	  cssLink.attr({
		rel:  "stylesheet",
		type: "text/css",
		href: href
	  });

};

/*
	// TODOS LOS EVENTOS -> $table.on('all.bs.table', function (e, name, args) {
	//	https://bootstrap-table.com/docs/api/events/
    //  COMO ADD ROW ? -> https://stackoverflow.com/questions/28503985/bootstraptable-dynamically-add-and-delete-row
*/

function Browse( cId ) {

	this.cId    = cId
	this.bClick = null
	this.bDblClick = null

    var oBrowse 
	
	console.log( this )
/*	
	if ( ! $.fn.bootstrapTable ) {
		console.log( 'Loading library bootstrapTable' )
		loadCSS( "https://unpkg.com/bootstrap-table@1.15.5/dist/bootstrap-table.min.css" );
		$.ajax({
			url: "https://unpkg.com/bootstrap-table@1.15.5/dist/bootstrap-table.min.js",
			dataType: 'script',
			async: true,
			success: function( script, textStatus ) {
				console.log( 'bootstrapTable loaded !' )				
			},
			error: function( a, b, c ) {
				console.error( 'Error loading bootstrapTable' );
			}
		});		

	} else {
		console.log( 'NOOOOO' )
	}
*/		
		
	
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
