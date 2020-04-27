
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

	this.cId    	= cId
	this.bClick 	= null
	this.bDblClick 	= null

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

//	-------------------------------------------------------------------------------------//

function TWebButtonUpload( cId, cUrl, callback, fError ) {
 
 	this.cId 		= ( typeof( cId ) === 'string') ? cId : '';
	this.cUrl 		= ( typeof( cUrl ) === 'string') ? cUrl : '';
	this.callback	= ( typeof( callback ) === 'function') ? callback : null;
	this.fError		= ( typeof( fError ) === 'function') ? fError : null;
	this.onprogress	 
	this.onloadstart
	this.onloadend
	this.onreading
 
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
			console.log('File read cancelled');
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

			//console.log( 'onload' 	)
			
			var formData = new FormData();
			var blob = new Blob( [e.target.result], {type: "application/octet-stream"} );
			formData.append( evt.target.files[0].name, blob );	 			

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
				   //process error msg
				   /*
				   console.log( 'Error0', data);
				   console.log( 'Error1', data.status);
				   console.log( 'Error1', data.responseText);
				   console.log( 'Error2', textStatus);
				   console.log( 'Error3', jqXHR);
				   */
				   
					if ( typeof Self.fError === "function") {	
						
						Self.fError.apply(null, [data, Self.cUrl] );
						
					} else { 				   
				   
						switch (data.status) {
					   
							case 404:
								MsgError( 'File not found: ' + Self.cUrl )
								break;
								
							default:
								MsgError( data.responseText )							
						}
					
					}
				   
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
	}	 
}



//	-------------------------------------------------------------------------------------//

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
