var _TWebWndLoading = null
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

function MsgLoading( cMessage, cTitle, cIcon ) {

	cMessage 	= (typeof cMessage ) == 'string' ? cMessage : 'Loading...' ;
	cTitle 		= (typeof cTitle ) == 'string' ? cTitle : 'System' ;
	cIcon 		= (typeof cIcon ) == 'string' ? cIcon : '<i class="fas fa-sync fa-spin"></i>' ;

	var dialog = bootbox.dialog({
			title: cTitle,
			message: '<p>' + cIcon + '&nbsp;&nbsp;'  + cMessage + '</p>',
			animate: false,							
			//closeButton: false
		}); 

	dialog.addClass("loading_center");
	dialog.find("div.modal-content").addClass("loading_content");																
	dialog.find("div.modal-header").addClass("loading_header");																
	dialog.find("div.modal-body").addClass("loading_body");																
		
	return dialog
}



//	MsgNotify --------------------------------------------------------------------------------------	
//	cType = 	success, info, error, warning
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

function TWebBrowse( cId, aData ) {

	this.cId    	= cId
	this.bClick 	= null
	this.bDblClick 	= null

    var oBrowse 
	
	this.SetData = function( rows ) {		
		rows 	= (typeof rows ) == 'object' ? rows : [] ;	   
		oBrowse.bootstrapTable( 'load', rows ) 
	}
	
	this.Clean = function() {	
	  oBrowse.bootstrapTable( 'load', [] )
	}	
	
	this.Select = function() {
	    return oBrowse.bootstrapTable('getSelections')
	}
	
	this.Loading = function( lOnOff ) {
	
		lOnOff = ( typeof( lOnOff ) === 'boolean') ? lOnOff : true;
		
		if ( lOnOff )
			oBrowse.bootstrapTable('showLoading')	
		else
			oBrowse.bootstrapTable('hideLoading')		
	}

	
	this.Init = function( aData ) {	    
	    
	    oBrowse = $('#' + this.cId )
	    
	    if ( typeof this.bClick == 'function' ){
	        oBrowse.on('click-row.bs.table', this.bClick )
	    }
		
	    if ( typeof this.bDblClick == 'function' ){
	        oBrowse.on('dbl-click-row.bs.table', this.bDblClick )
	    }
		
		if ( $.type(aData) == 'array' )	    
			oBrowse.bootstrapTable( {data: aData } ) 
		else
			oBrowse.bootstrapTable()    	    
	}	
	
	this.Init( aData )
	
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

function TWebBrwSearch( cUrl, aHeaders, fCallback, cSearch, cTitle ) {

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
		
		oBrw.Loading( true )
		
		MsgServer( cUrl, oParam, _PostSearch )					
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
