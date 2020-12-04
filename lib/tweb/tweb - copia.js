var _TWebWndLoading = null
//----------------------------------------------------------------------------//


function MsgInfo( cMsg, cTitle, cIcon, fCallback ) {

	cTitle 	= (typeof cTitle ) == 'string' ? cTitle : 'Information' ;
	cIcon 	= (typeof cIcon ) == 'string' ? cIcon : '<i class="fas fa-info-circle"></i>' ;
	
	if ( typeof cMsg !== 'string' ||( typeof cMsg == 'string' && cMsg.length == 0 ))
		cMsg = String(cMsg)
	
	//	Check animations -> https://codepen.io/ghimawan/pen/vXYYOz?editors=0010#0
	
	var dialog = bootbox.dialog({
		title: cIcon + '&nbsp;' + cTitle,
		message: cMsg,
		size: 'medium',
		backdrop: false,
		onEscape: true, 
		className: 'bounce fadeOut',
		buttons: {
			confirm: {
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

function MsgError( cMsg, cTitle, cIcon, fCallback  ) {

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
				callback: function( result ){
				
					if ( typeof fCallback === "function") {					
						fCallback.apply(null, [result] );
					}				
				}
			}
		}
	});
}

//----------------------------------------------------------------------------//

function MsgYesNo( cMsg, cTitle, cIcon, fCallback ) {

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
			
			if ( result && ( typeof fCallback === "function" )) {					
				fCallback.apply(null, [result] );
			}
		}
	});	

}


//----------------------------------------------------------------------------//

function MsgServer( cUrl, oValues, fCallback, cFormat ) {

	cFormat	= (typeof cFormat ) == 'string' ? cFormat : 'json' ;

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
	
	$.post( cUrl, oPar )		
		.done( function( data ) { 					

			if ( typeof fCallback === "function") {	
			
				if ( cFormat == 'json' ) {			

					if ( jQuery.type( data ) == 'object' )	{																
						fCallback.apply(null, [data] );	
					} else
						MsgError( data, 'Error MsgServer()' )
					
				} else {
					fCallback.apply(null, [data] );				
				}							
			} 
		})
		.fail( function(data){ 
			console.log( 'FAIL', data )
			MsgError( data.responseText ) 
		})
}

//----------------------------------------------------------------------------//
/*	Icons Animated
  "fas fa-spinner fa-spin"
  "fas fa-circle-notch fa-spin"
  "fas fa-sync fa-spin"
  "fas fa-cog fa-spin"
  "fas fa-spinner fa-pulse"
  "fas fa-stroopwafel fa-spin"
*/

function MsgLoading( cMessage, cTitle, cIcon, lHeader ) {

	cMessage 	= (typeof cMessage ) == 'string' ? cMessage : 'Loading...' ;
	cTitle 		= (typeof cTitle ) == 'string' ? cTitle : 'System' ;
	cIcon 		= (typeof cIcon ) == 'string' ? cIcon : '<i class="fas fa-sync fa-spin"></i>' ;
	lHeader		= (typeof lHeader ) == 'boolean' ? lHeader : false ;

	var dialog = bootbox.dialog({
			title: cTitle,
			message: '<p>' + cIcon + '&nbsp;&nbsp;'  + cMessage + '</p>',
			animate: false,							
			//closeButton: false
		}); 

	dialog.addClass("loading_center");
	dialog.find("div.modal-content").addClass("loading_content");
	dialog.find("div.modal-body").addClass("loading_body");																
	
	if ( ! lHeader )
		dialog.find("div.modal-header").addClass("loading_header");																
		
	return dialog
}



//	MsgNotify --------------------------------------------------------------------------------------	
//	cType = 	success, info, danger, warning
//	Examples -> http://bootstrap-growl.remabledesigns.com/

function MsgNotify( cMsg, cType, lSound ) {

	cType  = (typeof cType == 'undefined' ) ? 'success' : cType;
	lSound = (typeof lSound == 'boolean' ) ? lSound : false;
	
//	$.notify.defaults( { style: 'metro' );
/*
	if ( lSound ) {
	
		switch ( cType ) {
		
			case 'success':
				TSound( _( '_sound_success' ) )
				break;		
		
			case 'warn':
				TSound( _( '_sound_warn' ) )
				break;
				
			case 'error':
				TSound( _( '_sound_error' ) )
				break;				
				
			case 'info':
				TSound( _( '_sound_info' ) )
				break;									
		}		
	}
	*/
	
	
	
	$.notify( { icon: "images/tweb.png", message: cMsg }, { type: cType, icon_type: 'image' } );

}	

//----------------------------------------------------------------------------//

function MsgSound( cFile ) {

	var audioElement = document.createElement('audio');
	audioElement.setAttribute('src', cFile );
	audioElement.setAttribute('autoplay', 'autoplay');
}

//----------------------------------------------------------------------------//
function MsgLog( cMessage, cTitle ) {

	cMessage 	= (typeof cMessage ) == 'string' ? cMessage : ' ' ;
	cTitle 		= (typeof cTitle ) == 'string' ? cTitle : '<i class="far fa-file-alt"></i>&nbsp;System Log' ;
	
	var cFile = "{{ TwebGlobal( 'path_log' ) }}"
	
	bootbox.dialog({							
		size: 'large',
		title: cTitle,																										
		message: cFile,
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


//----------------------------------------------------------------------------//


function TWebIntro( cId, fFunction ) {

	$("#" + cId ).on('keyup', function (e) {
		if (e.key === 'Enter' || e.keyCode === 13) {
			if ( typeof fFunction === "function") {					
				fFunction.apply(null);
			}		
		}
	});
}

//----------------------------------------------------------------------------//


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


//----------------------------------------------------------------------------//
/*
	// TODOS LOS EVENTOS -> $table.on('all.bs.table', function (e, name, args) {
	//	https://bootstrap-table.com/docs/api/events/
    //  COMO ADD ROW ? -> https://stackoverflow.com/questions/28503985/bootstraptable-dynamically-add-and-delete-row
*/

function TWebBrowse( cId, aData, lInit ) {

	this.cId    	= cId
	//this.bClick 	= null
	//this.bDblClick 	= null
	//this.lEdit 		= false
	//this.bEditor  	= ''				//	Pending....
	//this.bPostEdit  = ''	
	this.cUniqueId	= ''	
	this.nLastIndex = -1 	
	//this.cTitle 	= null 
	
	//	https://stackoverflow.com/questions/1098040/checking-if-a-key-exists-in-a-javascript-object
	if (typeof TWebBrowse.aCfgCols === 'undefined') 
		TWebBrowse.aCfgCols = new Object();	
		
	if (typeof TWebBrowse.aChanges === 'undefined') 
		TWebBrowse.aChanges = [];

	if (typeof TWebBrowse.aUniqueId === 'undefined') 
		TWebBrowse.aUniqueId = [];			

	if (typeof TWebBrowse.nCounter === 'undefined') 
		TWebBrowse.nCounter = 0;
		
	if (typeof TWebBrowse.aCfg === 'undefined') 
		TWebBrowse.aCfg = new Object();	


	lInit	= (typeof lInit ) == 'boolean' ? lInit : false ;		

    var oBrowse 
	var oSelf 		= this;
	
	this.Info = function() { MsgInfo( this.cId, 'TWebBrowse' ) }

	this.Set = function( cKey, uValue ) {		
		TWebBrowse.aCfg[ cId ][ cKey ] = uValue
	}
	
	this.Get = function( cKey ) {		
	
		if ( cKey in  TWebBrowse.aCfg[ cId ] ) 
			return TWebBrowse.aCfg[ cId ][ cKey ]
		else
			return null
	}	
	
	this.SetData = function( rows ) {		
		rows 	= (typeof rows ) == 'object' ? rows : [] ;	   
		oBrowse.bootstrapTable(  { formatLoadingMessage:  function() { return '<b>This is a custom loading message...</b>' } } ) 
		oBrowse.bootstrapTable( 'load', rows ) 
		this.ResetChanges()
	}
	
	this.SetEdit = function( lOnOff ) {
	
		var lOldValue = this.Get( 'edit' )
		
		if ( typeof lOnOff != 'boolean' )
			return lOldValue
	
		if ( lOnOff )
			this.Set( lOnOff )
			
		return lOldValue	
	}
	
	this.SetCfgCols = function( cols ) {		
		
		if ( typeof TWebBrowse.aCfgCols[ cId ] == 'undefined' )
			TWebBrowse.aCfgCols[ cId ] = null		
	
		TWebBrowse.aCfgCols[ cId ] = cols			
    }

	this.SetClick = function( bFunction ) {
	
		if ( typeof bFunction == 'function' ){	
			oBrowse.off('click-row.bs.table' )
			oBrowse.on('click-row.bs.table', bFunction )
		}
	}		
	
	this.UpdateChanges = function( cIdRow, cAction, row  ) {

		if ( !( cId in TWebBrowse.aChanges ) ) {		
			return null
		}
		
		if ( cIdRow in TWebBrowse.aChanges[cId] ) {
		
			var oRow = TWebBrowse.aChanges[cId][cIdRow]

			if ( cAction == 'D' ) {
			
				if ( oRow[ 'action' ] == 'A' ) {			
				
					delete TWebBrowse.aChanges[cId][cIdRow] 					
					
				} else if ( oRow[ 'action' ] == 'U' ) { 
				
					TWebBrowse.aChanges[cId][cIdRow][ 'action' ] = 'D'
				}
				
			} else {
			
				TWebBrowse.aChanges[cId][cIdRow][ 'row' ] = row	
			}			
			
		} else {	
		
			TWebBrowse.aChanges[ cId ][ cIdRow ] = { 'action' : cAction, 'id' : cIdRow, 'row' : row } 		
		}

	}
	
	this.GetDataChanges = function() {
		
		var a = TWebBrowse.aChanges[ cId ]
		var aChanges = []
		
		for ( var key in a ) {
		
			aChanges.push( a[key] )
		}			
		
		return aChanges
	}
	
	this.ResetChanges = function() {
		TWebBrowse.aChanges[ cId ] = new Object()
	}
	
	
	this.GetCfgCols = function() {
		return TWebBrowse.aCols
	}
	
	
	this.Clean = function() {	
	  this.Reset()
	}

	this.Reset = function() {	
		oBrowse.bootstrapTable( 'load', [] )
		this.ResetChanges()
	}
	
	this.Select = function() {
	
	    return oBrowse.bootstrapTable('getSelections')				
	}
	
	/*
		this.SelectIndex = function() {
	
		var aIndex = []
		  
		$('input[name="btSelectItem"]:checked').each(function () {
			aIndex.push( $(this).data('index') );
		})

		return aIndex 
		}
	*/
	
	
	this.SelectIndex = function() {		
		
		var aIds = []
		
		$('#' + cId + ' input[name="btSelectItem"]:checked').each(function () {
			aIds.push( $(this).data('index') );			
		})		
		
		return aIds			
	}
	
	
	this.Refresh = function() {
		oBrowse.bootstrapTable( 'refresh' )
	}

	this.UpdateRow = function( index, row ) {
	
		//$table.bootstrapTable('updateByUniqueId', {id: 3, row: row}).	
	
		oBrowse.bootstrapTable('updateRow', { 'index' : index, 'row': row } )		
	
		var cUniqueId = TWebBrowse.aUniqueId[ cId ]		

		if ( cUniqueId in row ) {
		
			var cIdRow = row[ cUniqueId ]		
		
			this.UpdateChanges( cIdRow, 'U', row  )			
		}
	}
	
	this.UpdateRowById = function( cUniqueId, row ) {
	
		oBrowse.bootstrapTable('updateByUniqueId', { 'id' : cUniqueId, 'row': row } )		
		
		this.UpdateChanges( cUniqueId, 'U', row  )			
		
	}	

	this.UpdateCell = function( uId, cField, uValue ) {		
	
		var aDat = { 'index' : uId, 'field': cField, 'value' : uValue }
		
		console.log( 'UpdateCell', aDat )
	
		oBrowse.bootstrapTable('updateCell', aDat )
	}

	/*
		cMode == 'id' 		// UniqueId default
		cMode == 'index'
	*/
		
	this.DeleteRow = function( aIds, cMode ) {
	

		cMode = ( typeof cMode == 'string' ) ? cMode.toLowerCase() : 'id'; 
	
		var cUniqueId = TWebBrowse.aUniqueId[ cId ] 

		
		if ( typeof aIds == 'number' && cMode == 'index' ) {
			aIds = [ aIds ]
		} else 	if ( typeof aIds != 'array' ) {
	
		
			switch ( cMode ) {
			
				case 'id':		
			
					var aSel = this.Select()	
					var aIds = []
					
					for (i = 0; i < aSel.length; i++) {	
						aIds.push( aSel[i][ cUniqueId ] )
					}
					
					var row 
					
					for (i = 0; i < aIds.length; i++) {	

						row = oBrowse.bootstrapTable('getRowByUniqueId', aIds[i] );

						this.UpdateChanges( aIds[i], 'D', row  )	
					}					

					break;
					
				case 'index':
		
					var aIds = this.SelectIndex()	
				
					break;					
			}					
		}


		if ( aIds.length == 0)
			return null										
		
		switch ( cMode ) {
		
			case 'id':
				oBrowse.bootstrapTable('remove', {
						field: cUniqueId,
						values: aIds
					  })		
				break;
				
			case 'index':
	
				oBrowse.bootstrapTable('remove', {
						field: '$index',
						values: aIds
					  })			
			
				break;				
		}
	}	

		
	this.GetData = function() {
		return oBrowse.bootstrapTable('getData')
	}	
	
	this.GetRow = function( index ) {
	
		var uValue = null
		
		if ( typeof index == 'number' )	
			uValue = oBrowse.bootstrapTable('getData')[index]
		else {
			uValue = this.Select()
		}
		
		return uValue
	}
	
	this.AddRow = function( oItem, nIndex ) {
	
		if ( typeof nIndex != 'number' ) {
			var aData = oBrowse.bootstrapTable('getData')
			nIndex		= aData.length 
		}
	
		if ( typeof oItem != 'object' ) {
			oItem = this.GetItemEmpty() 
		}		
		
		var cUniqueId = TWebBrowse.aUniqueId[ cId ]
		
		TWebBrowse.nCounter++
		
		oItem[cUniqueId] = '$' + TWebBrowse.nCounter

		oBrowse.bootstrapTable('insertRow', {
				index: nIndex,
				row:  oItem 
			  })

		oBrowse.bootstrapTable('scrollTo', 'bottom')			  
		
		this.UpdateChanges( oItem [cUniqueId], 'A', oItem  )
	}
	
	this.GetItemEmpty = function() {
	
		var oItem = new Object()
	
		var aCfgCols 	= TWebBrowse.aCfgCols[ cId ];

		for ( var key in aCfgCols ) {			
		
			var oCol 	= aCfgCols[ key ] 			
			var uValue 	= ''
			
			switch ( oCol.edit_type ) {
			
				case 'COMBOBOX':
				case 'M':
				case 'C':
					uValue = ''
					break;
				case 'L':
					uValue = false
					break;						
				case 'N':
					uValue = 0
					break;
				default:
					uValue =''				
			}				
	
			oItem[ key ] = uValue						
		}	

		return oItem	
	}	
	
	this.Loading = function( lOnOff ) {
	
		lOnOff = ( typeof( lOnOff ) === 'boolean') ? lOnOff : true;
		
		if ( lOnOff )
			oBrowse.bootstrapTable('showLoading')	
		else
			oBrowse.bootstrapTable('hideLoading')		
	}

	//	Disparador de Edit --------------------------------------
	
		this.InitEdit = function( index ) {
		
			var aCfgCols 	= TWebBrowse.aCfgCols[ cId ];
			var row 		= this.GetRow( index )
			
			var o = new TWebBrowseForm( TWebBrowsePostEdit , index, oSelf, aCfgCols  );
			
			for (var key in aCfgCols ) {

				var oCol = aCfgCols[ key ]			
				
				if ( oCol.edit && oCol.id != this.cIdRow ) {			
					
					oCol.value = row[ key ]
					o.DefineCol( oCol )			
				}						
			}		
			
			o.Init()			
		}
	
	//	a) Via DblClick
	
		this.ClickEdit = function( e, row, element, cField ) {	
		
			var index 		= element.index()
			
			oSelf.InitEdit( index )
		}	
	
	//	Via Func. Checkbox
	
		this.Edit = function() {
		
			var index = -1 
			var nCount = 0

			$('#' + cId + ' input[name="btSelectItem"]:checked').each(function () {
				index = $(this).data('index');
				nCount++;
			})

			if ( index == -1 ) 
				return null		
				
			if ( nCount > 1 ) {
				console.info( 'Select only one' )
				return null
			}
			
			var row = this.GetRow( index )	
			
			oSelf.InitEdit( index )
		}	
	
	//	-------------------------------------------------------------


	
	this.Init = function( aData ) {	    	    		

	    oBrowse = $('#' + this.cId )		
		
		TWebBrowse.aChanges[ this.cId ] = new Object();
		TWebBrowse.aUniqueId[ this.cId ] = this.cUniqueId;
		
	    
        oBrowse.off('click-row.bs.table' ) 

	    //if ( typeof this.bClick == 'string' ){
	    if ( typeof this.Get( 'click' ) == 'string' ){
		
			var fn =  window[ this.Get( 'click' ) ]
			
			if (typeof fn === "function") {
				oBrowse.on('click-row.bs.table', fn )				
			}
		}
		/*
	    if ( typeof this.bClick == 'function' ){
	        oBrowse.on('click-row.bs.table', this.bClick )
	    }
		*/
		
        oBrowse.off('dbl-click-row.bs.table' )
		
		if ( this.Get( 'edit' ) ) {

			if ( this.Get( 'edit' ) == 'string' ) {			

				var fn =  window[ this.Get( 'editor' ) ]					

				if (typeof fn === "function") {
					oBrowse.on('dbl-click-row.bs.table', fn )	//	Not Yet!
				} else {
					oBrowse.on('dbl-click-row.bs.table', this.ClickEdit )				
				}
					
			} else {
				oBrowse.on('dbl-click-row.bs.table', this.ClickEdit )				
			}		
		
	    } else if ( typeof this.Get( 'dblclick' ) == 'string' ){
		
			var fn =  window[ this.Get( 'dblclick' ) ]
			
			if (typeof fn === "function") {			
				oBrowse.on('dbl-click-row.bs.table', fn )
			}
	    }
		
		if ( $.type(aData) == 'array' )	    
			oBrowse.bootstrapTable( {data: aData } ) 
		else {
			oBrowse.bootstrapTable()			
		}

	}	
	
	if ( !( this.cId in TWebBrowse.aCfg ) )
		TWebBrowse.aCfg[ this.cId ] = new Object()
		
		
	console.log( 'Abans Init...', TWebBrowse.aCfg )

	console.trace()
	
	if ( lInit ) {	
		this.Init( aData )
	} else {	//	Instancia
		console.log( 'Init!' )
		oBrowse = $('#' + this.cId )
		oBrowse.bootstrapTable()		
	}
	
}


function TWebBrowsePostEdit( row, index, oBrw, aCfgCols ) {
	
	var oItem 	= oBrw.GetRow( index )
	var lUpdate	= false
	
	for (var key in row ) {	
	
		if ( oItem[ key ] != row[ key ] ) {
			lUpdate = true 
			oItem[ key ] = row[ key ]
		}			
	}

	if ( lUpdate ) {
		var cId = oBrw.cId 
		var cUniqueId = TWebBrowse.aUniqueId[ cId ]
		
		var cUniqueId = oItem[cUniqueId]
			
		//oBrw.UpdateRow( index, oItem );					
		oBrw.UpdateRowById( cUniqueId, oItem );					
	}

	//if ( oBrw.bPostEdit != "" ) {
	if ( oBrw.Get( 'postedit') != "" ) {
	
		var fn =  window[ oBrw.Get( 'postedit') ]			
	
		if ( typeof fn == "function") {																			
			fn.apply(null, [ oItem, lUpdate ] );										
		}	
	}	
}



//	-------------------------------------------------------------------------------------//

/*	List rows in table and select one of them	*/

function TWebBrwSelect( headers, rows, fCallback, cTitle ) {

	cTitle 	= (typeof cTitle ) == 'string' ? cTitle : '<i class="far fa-check-square"></i> Select' ;
	
	var nBrwHeight 	= 400
	var cMsg 		= '<table id="_twebbrwselect" class="table-sm table-striped" ' + 
						'data-single-select="true" data-click-to-select="true" ' + 
						'data-height=' + nBrwHeight + ' data-toggle="table" data-search="true" data-locale="en-US">' + 
						'<thead class="thead-dark"><tr>' + 
						'<th data-field="c" data-checkbox="true"></th>' 
					
		for (var key in headers ) {															
			cMsg += '<th data-field="' + key + '">' + headers[key] + '</th>' 
		}

		cMsg += '</tr></thead></table>'

	var dialog = bootbox.dialog({
		title: cTitle,
		message: cMsg,
		size: 'large',
		backdrop: false,
		onEscape: true, 
		className: 'bounce fadeOut',
		buttons: {
			confirm: {
				label: '<i class="fa fa-check"></i> Accept',
				className: 'btn-outline-success',
				callback: function(result) {	

					if ( typeof fCallback === "function") {

						var row_num = oBrw.Select()
						
						if ( row_num.length > 0 ) {
							var row = row_num[0]											
							fCallback.apply(null, [row] );
						}																			
					}							
				}
			}
		}
	});

	dialog.init(function(){ 
		oBrw = new TWebBrowse( '_twebbrwselect' )
		oBrw.Init()						
		oBrw.SetData( rows ) 
	})				
}	

//	-------------------------------------------------------------------------------------//

function TWebBrwSearch( cUrl, aHeaders, fCallback, cSearch, cTitle, oValues ) {

	cSearch = (typeof cSearch ) == 'string' ? cSearch : '' ;
	cTitle 	= (typeof cTitle ) == 'string' ? cTitle : '<i class="fas fa-search"></i> Buscar' ;


	
	var nBrwHeight 	= 400
	var cMsg 		=   '<div class="form-group">' +
						' <div class="col-12">' +
						'  <div class="input-group">' +
						'   <input type="text" class="form-control" id="_search" value="' + cSearch + '">' +
						'   <div class="input-group-append">' +
						'    <button class="btn btn-outline-secondary " type="button" onclick="_Search()">' +
						' 	  <i class="fas fa-search"></i> Search' +
						'    </button>' +
						'    <span id="_total" class="input-group-text">0</span>' +
						'   </div>' +
						'  </div>' +
						' </div>' + 
						'</div>' + 
						'<table id="_twebbrwsearch" class="table-sm table-striped" ' + 
						'data-single-select="true" data-click-to-select="true" ' + 
						'data-locale="es-ES" ' + 
						'data-height=' + nBrwHeight + ' data-toggle="table">' + 
						'<thead class="thead-dark"><tr>' + 
						'<th data-field="c" data-checkbox="true"></th>' 
					
		for (var key in aHeaders ) {							
			cMsg += '<th data-field="' + key + '">' + aHeaders[key] + '</th>' 
		}

		cMsg += '</tr></thead></table>'

	var dialog = bootbox.dialog({
		title: cTitle,
		message: cMsg,
		size: 'large',
		backdrop: false,
		onEscape: true, 
		className: 'bounce fadeOut',
		buttons: {
			confirm: {
				label: '<i class="fa fa-check"></i> Accept',
				className: 'btn-outline-success',
				callback: function(result) {	

					if ( typeof fCallback === "function") {

						var row_num = oBrw.Select()
						
						if ( row_num.length > 0 ) {
							var row = row_num[0]											
							fCallback.apply(null, [row] );
						}																			
					}							
				}
			}
		}
	});
	
	var oBrw

	dialog.init(function(){ 
		oBrw = new TWebBrowse( '_twebbrwsearch' )
		oBrw.Init()		

		dialog.bind('shown.bs.modal', function(){
			$('#_search').focus()			
			
			$('#_search').keypress(function(event){
				var keycode = (event.keyCode ? event.keyCode : event.which);
				if(keycode == '13'){
					_Search()
				}
			})						
		});								
	})				
	
	this._Search = function() {					
		
		var cSearch = $('#_search').val()						
		
		var oParam = new Object()
			oParam[ 'search' ] = cSearch
			
		if ( $.type( oValues ) == 'object' ) {
		
			for (var key in oValues ) {						
				oParam[key] = oValues[key]			
			}				
		}
		
		oBrw.Loading( true )
		
		MsgServer( cUrl, oParam, _PostSearch, oValues )					
	}
	
	this._PostSearch = function( dat ) {

		oBrw.Loading( false )		
		oBrw.SetData( dat.rows )
		$('#_total').html( dat.rows.length )		
	}									
	
	
}

//	-------------------------------------------------------------------------------------//

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


//	-------------------------------------------------------------------------------------//

function TWebUpload( cId, cUrl, callback, oData ) {
 
 	this.cId 		= ( typeof( cId ) === 'string') ? cId : '';
	this.cUrl 		= ( typeof( cUrl ) === 'string') ? cUrl : '';
	this.callback	= ( typeof( callback ) === 'function') ? callback : null;
	this.onprogress	 
	this.onloadstart
	this.onloadend
	this.onreading
	this.oData		= oData
 
	var Self 	= this 
	var reader  = null 
	
	this.Init = function() {			
		
		//	Solo crearemos una vez el evento al id del DOM, sino dispararia una pila
		//	del evento tantas veces como ejecutemos
		
		if (document.getElementById( this.cId ).getAttribute('listener') !== 'true') {			
			document.getElementById( this.cId ).addEventListener('change',this.handleFileSelect, false);
			document.getElementById( this.cId ).setAttribute('listener', 'true');			
		}
		
		$( '#' + this.cId ).trigger('click')		
	}
	
	this.errorHandle = function(evt) {
		 switch(evt.target.error.code) {
		   case evt.target.error.NOT_FOUND_ERR:
			 console.log('File Not Found!');
			 break;
		   case evt.target.error.NOT_READABLE_ERR:
			 console.log('File is not readable');
			 break;
		   case evt.target.error.ABORT_ERR:
			 break; // noop
		   default:
			 console.log('An error occurred reading this file.');
		 };
	}	


	this.handleFileSelect = function(evt) {		

		reader = new FileReader();
	 
		reader.onerror 		= this.errorHandle;
		
		reader.onprogress 	= function(e) {
		
			if ( typeof Self.onreading === "function") {
				var n100 = Math.floor(e.loaded / e.total * 100); 
				Self.onreading.apply(null, [e, n100] );							
			}
		};
		
		reader.onabort 		= function(e) {
			//console.log('File read cancelled');
		};
		
		reader.onloadend = function(e) {
		
			if ( typeof Self.onloadend === "function") {
				Self.onloadend.apply(null, [e] );							
			}
		};
		
		reader.onloadstart = function(e) {			
			
			if ( typeof Self.onloadstart === "function") {
				Self.onloadstart.apply(null, [e] );							
			}									
		};
		
		reader.onload = function(e) {	
			
			var file 	= evt.target.files[0]			
			
			console.log( 'oData', $.type( Self.oData ) )
			
			var formData = new FormData();	

			/*
			if ( $.type( Self.oData ) == 'object' ) {						
				$.each(Self.oData, function (key, val) {			
					formData.append( key, val )				 
				})						
			}			
			*/
			
			var blob = new Blob( [e.target.result], {type: "application/octet-stream"} );			
			
				var y = new Object()					
					y[ 'name' ] = file.name
					y[ 'size' ] = file.size
					y[ 'type' ] = file.type

				var z = new Object()
					z[ 'var1' ] = 1234
					z[ 'var2' ] = 'Maria de la O'
				
			formData.append( 'blob', blob );
			formData.append( 'file', JSON.stringify(y) );	

			if ( $.type( oData ) == 'object' )			
				formData.append( 'data', JSON.stringify(oData) );	 

			$.ajax({
				url: Self.cUrl,
				data: formData,
				processData: false,
				// This will override the content type header, 
				// regardless of whether content is actually sent.
				// Defaults to 'application/x-www-form-urlencoded'
				contentType: 'multipart/form-data',
				beforeSend: function(xhr) { 
					xhr.setRequestHeader('Content-Type', 'multipart/form-data');
				},			
				type: 'POST',
				success: function ( dat ) {					
					
					if ( typeof Self.callback === "function") {	
						
						Self.callback.apply(null, [dat] );
						
					} else { 
					   
						if ( typeof dat == 'object' )
							if ( dat.success )
								MsgInfo(dat.html, 'My Message')
							else
								MsgError(dat.error)
						else
							MsgError(dat)						
					}									
					
				},
				error: function(data, textStatus, jqXHR) {
			
				   console.log( 'Error data', data);			
				   console.log( 'Error textStatus', textStatus);
				   console.log( 'Error XHR', jqXHR);
				},				
				xhr: function() {
					var xhr = $.ajaxSettings.xhr();
					
					xhr.upload.onprogress = function(e) {
					
						//	Sending file...
						
						var n100 = Math.floor(e.loaded / e.total *100); 
						
						if ( typeof Self.onprogress === "function") {
							Self.onprogress.apply(null, [e, n100] );							
						}						
					}
					
					return xhr;
				}								
		
			});	   
		}

		// Read in the image file as a binary string.
			reader.readAsDataURL( evt.target.files[0] )		
			
		/*
		for (i = 0; i < evt.target.files.length; i++) {
			reader.readAsDataURL( evt.target.files[i] )		
		}
		*/

	} 
}

/*	-------------------------------------------------------------------------------------
	TWebUploadImage() se usara para subir imagenes que tengamos en pantalla dentro de 
	un div. La diferencia con TWebUpload es que esa sirve para controlar el boton que 
	seleccionara un fichero de un dialogo y subira posteriormente el fichero.

	fCallback = nombre de funcion que se ejecutara cuando termine la subida
	oData = Object que se usa para pasar parametros
		var oData = new Object()
		oData[ 'string' ] = '12345678'
		oData[ 'numeric' ] = 12345678
		oData[ 'logic' ] = true	
	-------------------------------------------------------------------------------------*/
	
function TWebUploadImage( cId_Img, cUrl, fCallback, oData, lIsUri ) {

	lIsUri	= (typeof lIsUri ) == 'boolean' ? lIsUri : false

	var formData 	= new FormData();	
	
	if ( lIsUri ) {
		formData.append( 'blob', cId_Img);	// 	cId_img == URI
	} else {
		var file 		=  document.getElementById( cId_Img ).src;			
		formData.append( 'blob', file);
	}
		
	if ( $.type( oData ) == 'object' )						
		formData.append( 'data', JSON.stringify(oData) );
		
	$.ajax({
		url: cUrl,
		data: formData,
		processData: false,
		contentType: 'multipart/form-data',
		beforeSend: function(xhr) { 
			xhr.setRequestHeader('Content-Type', 'multipart/form-data');
		},			
		type: 'POST',
		success: function ( dat ) {												
			if ( typeof fCallback === "function") {									
				fCallback.apply(null, [dat] );								
			} else { 
				console.log( 'success', dat )								  						
			}							
		},
		error: function(data, textStatus, jqXHR) {
	
		   console.log( 'Error Url', cUrl);			
		   console.log( 'Error data', data);			
		   console.log( 'Error textStatus', textStatus);
		   console.log( 'Error XHR', jqXHR);
		}																		
	});					
}

function TWebUploadUri( cId_Img, cUrl, fCallback, oData ) { TWebUploadImage( cId_Img, cUrl, fCallback, oData, true ) }








//	-------------------------------------------------------------------------------------//

/*	Inizialitation event system TWeb	*/

var _dsg_background, _dsg_outline

$(document).ready( function() {

	console.info( 'Init TWeb system...' )

	//	Dessign event system

		$(".tweb_dessign").mouseover(function(){
		
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

//	-------------------------------------------------------------------------------------//


function TWebBrowseForm( bFunc, index, oBrw, aCfgCols) {

	this.cHtml = '';
	this.aCtrl = [];		
	
	var oSelf = this;

	this.Init = function() {
	
		var cTitle = oBrw.Get( 'title' )
	
		//title: ( ( typeof oBrw.cTitle == 'string' && oBrw.cTitle.length > 0 ) ? oBrw.cTitle : null ),
		
		var dialog = bootbox.dialog({
			title: cTitle ,
			message: this.cHtml,
			size: 'large',
			backdrop: false,
			onEscape: true, 
			className: 'bounce fadeOut',
			buttons: {										
					cancel: {
							label: '<i class="fas fa-ban"></i> Cancel',
							className: 'btn-outline-danger'
						},
					confirm: {
							label: '<i class="fa fa-check"></i> Accept',
							className: 'btn-outline-success',
							callback: function(result) { 
							
								var rows = oSelf.GetValues()
								
								if ( typeof bFunc == "function") {																			
									bFunc.apply(null, [rows, index, oBrw, aCfgCols]);																		
								}
							}														
						}
			}
		});
		

		//dialog.addClass("loading_center");
		
		if ( ! ( typeof cTitle == 'string' && cTitle.length > 0 ) )
			dialog.find("div.modal-header").addClass("loading_header");																
		//dialog.find("div.modal-content").addClass("store_content");																
		//dialog.find("div.modal-body").addClass("store_body");		
					
	}	
	
	this.GetValues = function() {
		
		var i 		
		var oItem = new Object()
		
		for (i = 0; i < this.aCtrl.length; i++) {		
		
			var cId 	= this.aCtrl[i][ 'id' ]			
			var oCol 	= aCfgCols[ cId ]
			
			if ( oCol.edit_type == 'L' ) {							
				oItem[ cId ] = $('#' + cId ).is(":checked")
			} else {				
				oItem[ cId ] = $('#' + cId ).val()
			}												
		}		

		return oItem 
	}
	
	this.DefineCol = function( o ) {
	
		var cWidth = 8
		var cOffset = ''	
		
		console.log( 'DefineCol()', o )

		this.cHtml += '<div class="row">'
		
		if (o.head)
			this.cHtml += '	<label class="col-4 col-form-label text-right" for="' + o.id + '"><b>' + o.head + '</b></label>'			
		else if (o.label)
			this.cHtml += '	<label class="col-4 col-form-label text-right" for="' + o.id + '"><b>' + o.label + '</b></label>'			
					
		
		if (o.value == null)
			o.value = ''
		
		if ( o.col_input )
			cWidth = o.col_input 
			
		if (o.offset)
			cOffset = 'offset-sm-' + o.offset 
			
		this.aCtrl.push( { 'id': o.id, 'type': o.input, 'value' : o.value } )	

		switch ( o.edit_type.toUpperCase() ) {
		
			case 'C':
			case 'GET':

				if (o.edit_escape ) {
									
					var uValue = o.value 

					uValue = uValue.replace(/"/g, '&quot;')
					uValue = uValue.replace(/'/g, '&apos;')
					//uValue = uValue.replace(/</g, '&lt;')
					//uValue = uValue.replace(/>/g, '&gt;')
					//uValue = uValue.replace(/&/g, '&amp;')
					
				} else {
					var uValue = o.value 
				}
					
				console.log( 'uValue', uValue )
					
				this.cHtml += '<div class="col-' + cWidth + ' ' + cOffset + ' pt-1">'
				this.cHtml += '<input type="text" class="form-control form-control-sm" id="' + o.id + '" name="' + o.id + '" value="' + uValue + '"/>'
				this.cHtml += '</div>'
				break;
				
			case 'S':
			case 'COMBOBOX':
				
				this.cHtml += '<div class="col-' + cWidth + ' ' + cOffset + ' pt-1">'
				this.cHtml += '<select class="form-control form-control-sm" id="' + o.id + '" name="' + o.id + '">'
				
				var aOptions 	= o.edit_with 
				var oDataCombo 	= o.edit_with 
				var value 
				
				for (var key in oDataCombo) {	
				
					value = oDataCombo[key];
					
					this.cHtml += '<option value="' + key + '" '

					if ( o.value == key ) {
						this.cHtml += ' selected="selected" '
					}

					this.cHtml += ' >' + value + '</option>'													
				}				

				this.cHtml += '</select>'
				this.cHtml += '	</div>'
				
				break;		

			case 'L':
			case 'CHECKBOX':
			

				this.cHtml += '<div class="col-4 pt-1">'
				this.cHtml += '<input type="checkbox" class="form-control-sm " id="' + o.id + '" name="' + o.id + '" '
				if ( o.value )
					this.cHtml += '  checked="checked" '
					
				this.cHtml += '/>'
				this.cHtml += '</div>'
				
				break;	

			case 'M':
			case 'GETMEMO':

				this.cHtml += '<div class="col-' + cWidth + ' ' + cOffset + ' pt-1" style="margin-bottom:0.5rem;">'
				this.cHtml += '<textarea class="form-control form-control-sm" rows="5" id="' + o.id + '" name="' + o.id + '" >' + o.value + '</textarea>'
				this.cHtml += '	</div>'
				break;				
			
			case 'BUTTON':						
			
				this.cHtml += '<div class="col-' + cWidth + ' ' + cOffset + '">'
				this.cHtml += '<button type="button" class="btn btn-primary" id="' + o.id + '" name="' + o.id + '" value="' + o.prompt + '" onclick="' + o.action  + '">' + o.prompt + '</button>'
				this.cHtml += '	</div>'
				break;
				
			case 'N':		

				this.cHtml += '<div class="col-' + cWidth + ' ' + cOffset + ' pt-1">'
				this.cHtml += '<input type="number" class="form-control form-control-sm" id="' + o.id + '" name="' + o.id + '" value="' + o.value + '"/>'
				this.cHtml += '</div>'
				break;	

			case 'D':	

				this.cHtml += '<div class="col-' + cWidth + ' ' + cOffset + ' pt-1">'
				this.cHtml += '<input type="date" class="form-control form-control-sm" id="' + o.id + '" name="' + o.id + '" value="' + o.value + '" pattern="[0-9]{4}-[0-9]{2}-[0-9]{2}"/>'
				this.cHtml += '</div>'
				break;				
		}		
		
		this.cHtml += '</div>'			
	}
}



/*	Rutines...	*/
//	Len Object	

Object.size = function(obj) {
	var size = 0, key;
	for (key in obj) {
		if (obj.hasOwnProperty(key)) size++;
	}
	return size;
};



/*	---------------------------------------------------------------------	
	TWebControl().- Gestion de los controles del DOM. Not Yet !
	--------------------------------------------------------------------- */

function TWebControl() {

	this.Set 	= function ( cId, uValue, cargo ) {

		var o 	= $( '#' + cId );
	
		if ( o == null )
			return null
			
		var cControl 	= o.attr( 'data-control' ) ;
		var cType 		= $.type( uValue );
		
		console.log( 'ID', cId )
		console.log( 'control', cControl )
		console.log( 'type', cType )

		switch ( cControl ) {
		
			case 'tget':
			
				if ( o ) {				
					o.val( uValue );			
				}
				
				break;			
		
			case 'tcombobox':
			
				if ( typeof cargo == 'string' && cargo == 'data' ) {

					o.find('option').remove().end()
					
					$.each( uValue, function (i, item) {
						o.append($('<option>', { 
							value: item.value,
							text : item.text 
						}));
					});
				} else {

					o.val( uValue )	
				}				
				
				break;			
		}
		
	}

	this.Get	= function ( cId, cargo ) {
		
		var uValue 		= null;
		var o 			= $( '#' + cId );

		if ( o == null )
			return null
			
		var cControl 	= o.attr( 'data-control' ) ;
		
//console.log( cId, cControl )		
	
		switch ( cControl ) {
		
			case 'tcombobox':
			
				uValue = o.val();
				break;
		}

		return uValue;				
		
	}

	this.Group 	= function ( cGroup, cAction ) {		
	
	
		console.log( cGroup, cAction )
		
		var o 		= this.GetGroup( cGroup )
		var oObj	= null
		var cId 
		
		console.log( 'o', o )
		
		switch ( cAction ) {
		
		
			case 'default':
			
				for ( i=0; i < o.length; i++ ) {
				
					cId =  o[i].id
					console.log( 'ID', cId )
					
					uValue = $(o[i]).data( 'default')
					uValue = ( typeof uValue == 'undefined' ) ? '' : uValue;					
					
					console.log( 'ID ' + cId, uValue )
					this.Set( cId, uValue )																			
				}						
				break;						
		}				
	}
	
	
	this.GetGroup 	= function ( cGroup ) {		
	
		var aIds 	= []
		
		if ( typeof cGroup == 'string' ) {
		
			var aIds = $('[data-group="' + cGroup + '"]' )
			
			/*
			$.each( aList, function(index, object) {			   
				aIds.push( aList[index].id );	   
			});
			*/
		} 
		
		return aIds
		
	}
	
	this.Enable 	= function ( cId, cGroup ) {

		if ( typeof cGroup == 'string' ) {	
			var aIds = $('[data-group="' + cGroup + '"]' )
		} else {
			var aIds = [ $( '#' + cId ) ]
		}
	
			
		console.log( 'IDS', aIds )	

		for (i = 0; i < aIds.length; i++) {
		
			var o 	= $(aIds[i]);									

			if ( o == null )
				continue; 								
				
			var cControl 	= o.attr( 'data-control' ) ;	
			
			switch ( cControl ) {
			
				case 'tget':
		
					o.prop( 'disabled', false ); 
					
					var aBtn = o.parent().children().find( 'button' ) 
					
					for (j = 0; j < aBtn.length; j++) {
					
						$(aBtn[j]).prop( 'disabled', false )					
					}																				
				
					break;	
					
				case 'tcombobox':				
				
					o.prop( "disabled", false )					

					break;					

			}				
		}			
	}
}