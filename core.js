/* ---------------------------------------------------------------------------
Libreria   			: TWEB (FrameWork for Web)
Autor				: Carles Aubia
Versio				: 1.4
Data Inici  		: 24/12/2014
Ult. Modificacio	: 11/09/2018
Descripcio			: Framework para ayudar a contruir de manera rapida, facil 
					  y productiva una web de mantenimiento, diseñando incluso
					  pantallas con workshop acelerando asi su tiempo de diseño.
------------------------------------------------------------------------------*/

function TControl() {

	if (typeof TControl.aControls === 'undefined') 
		TControl.aControls = new Object();	
		
	if (typeof TControl.aEvents === 'undefined') {
		TControl.aEvents = new Object();		
		TControl.aEvents[ 'signal'  ] = null;		
		TControl.aEvents[ 'message' ] = null;		
	}	

	this.Get	= function ( cId, cargo ) {
		
		var uValue 		= null;
		var o 			= $( '#' + cId );

		if ( o == null )
			return null
			
		var cControl 	= o.attr( 'data-control' ) ;
	
		switch ( cControl ) {	

			case 'tsay':

				uValue =  o.html();					
				break;				
				
			case 'tget':

				uValue = o.val();
				break
				
			case 'tcheckbox':
			
				uValue = o.prop( 'checked' );
				break;
				
			case 'tcombobox':
			
				uValue = o.val();
				break;
				
			case 'tcombobox_ex':
			
				var cProp = o.prop( 'type' );

				if ( cProp == 'select-multiple' ) {		
		
					if ( cargo == 'text' ) {					
						uValue = o.multipleSelect("getSelects", "text");		
					} else {
						uValue = o.multipleSelect("getSelects");	
					}
					
					if ( o.attr( 'multiple' ) !== 'multiple' ){
						uValue = uValue[ 0 ];					
					}					
						
				} else {			
					
					if ( cargo == 'text' ) {					
						uValue = o.multipleSelect("getSelects", "text");
					} else {
						uValue = o.multipleSelect("getSelects");										
					}

					uValue = uValue[ 0 ]					
				}

		
			
				break;	
				
			case 'tradio':
			
				uValue = $( 'input[name=' + cId + ']:checked' ).val();		

				if ( typeof uValue === 'undefined' )
					uValue = 0;			
			
				break;
			
			case 'timage':
		
				uValue = o.find( 'img' ).attr( 'src' );
				
				break;
				
			case 'tprogressbar':											
				
				uValue = o.progressbar( "value" );
				
				break;
			
			case 'tgrid':
			
				cargo = ( typeof cargo == 'boolean' ) ? cargo : true ;			
			
				var oGrid 	= this.GetControl( cId )
				
				if ( cargo )
					uValue 	= oGrid.GetData() ;	
				else
					uValue 	= oGrid.GetChanges() ;	
				
				break;

			case 'tbuttonfiles':	
			
				var cNewId = '_buttonfiles_' + cId;
			
				uValue = $( "#" + cNewId )[0].files;				
				
				break;	

			case 'tframe':	

				uValue = o.find( 'iframe' ).attr( 'src' );			
								
				break;	

			case 'teditor':	

				var oEditor = new TEditor( cId );
		
				uValue = oEditor.Get();	
								
				break;

			case 'taccordion':
			
				uValue = $("#" + cId + '_content' ).accordion( "option", "active" );

				if ( uValue === false ) 
					uValue = 0
				else 
					uValue++				
					
				break; 	
				
			case 'ttree':
			
				var oTree = this.GetControl( cId )
				
				uValue = oTree.GetData();
				
				break;					

			case 'thidden':
			
				cValue = o.val();
				
				if ( cValue.length > 0 )
					uValue = JSON.parse(cValue)
				else
					uValue = '';
					
				break; 						
				
			default:
			
				uValue = $( "#" + cId ).val();					

				break;				
			
		}
		
		return uValue;		
	}
	
	this.Set	= function ( cId, uValue, cargo ) {

		var o 			= $( '#' + cId );

		if ( o == null )
			return null
			
		var cControl 	= o.attr( 'data-control' ) ;
		var cType 		= $.type( uValue );

		switch ( cControl ) {	

			case 'tsay':
				
				var cText = '';
				
				if ( $.type( cargo ) == 'string' ) 
					cText = '<i class="' + cargo + '"></i>';
					
				if ( cType == 'string' ) 
					cText += '&nbsp;' + uValue;

				
				o.html( cText );
				
				break;
				
			case 'tget':
			
				if ( o ) {				
					o.val( uValue );			
				}
				
				break;		

			case 'tgetmemo':
			
				if ( o ) {				
					o.val( uValue );
					setSelectionRange( $( '#' + cId )[0], 0, 0 );					
				}
				
				break;					
				
			case 'tradio':
		
				if ( uValue > 0 ) {
					uValue-- ;	
					$('input:radio[name=' + cId + ']')[ uValue ].checked = true;												
				} else  {				
					$('input:radio[name=' + cId + ']').attr('checked',false);								
				}
					
				break;	
				
			case 'tcombobox':
			
				o.val( uValue );
				break;			
				
			case 'tcombobox_ex':
			
				var cProp = o.prop( 'type' );				
		
				if ( ( cProp == 'select-multiple' ) || ( cProp == 'select-one' )) {	

					//	Si cargo es un array de datos, reinicializamos el control con los nuevos datos

					if ( $.type( cargo ) == 'array'  ) {
									
						o.html( '' );
						
						for ( nJ = 0; nJ < cargo.length ; nJ++) {
						
								o.append($('<option>', { 
									value: cargo[nJ][ 'value' ],
									text : cargo[nJ][ 'text' ] 
								}));								
						}
						
						o.multipleSelect()																
					}

					//	Quan es un Multiple (ni q estigui sols la funcionalitat de Single
					//	s'han de pasar els paràmetres dintre array
					
					switch ( $.type( uValue ) ) {
					
						case 'string':
						
							uValue = [ uValue ];
							break;	

						case 'null':
						
							uValue = []
							break;
					}																		
			
					o.multipleSelect( "setSelects", uValue );			
					
				} else {
					
					o.val( uValue );						
				}
				
				break;	
			
			case 'tcheckbox':
			
				uValue = ( cType == 'boolean' ) ? uValue : false ;
				
				o.prop( 'checked', uValue );
				break;
				
			case 'tmsgitem':
			
				uValue = ( cType == 'string' ) ? uValue : '';
				
				var oTxt = $( '#msgitem_txt_' + cId );
				var oImg = $( '#msgitem_img_' + cId );

				oTxt.text( uValue );
				
						
				if ( cargo == '' || cargo == null ) {
				
					oImg.attr( 'src', '' );
					oImg.css( 'display', 'none' );				
					
				} else {
				
					uValRefresh = cargo + '?' + Math.random();
					
					oImg.attr( 'src', '' );			// Blank
					oImg.attr( 'src', uValRefresh );	// Refrescamos cache
					oImg.attr( 'src', cargo );		// Dejamos valor original
					oImg.css( 'display', '' );					
				}
				
				break;
			
			case 'timage':
		
				if ( uValue == '' || uValue == null ) {
				
					o.find( 'img' ).attr( 'src', '' );
					o.find( 'img' ).css( 'display', 'none' );
					
				} else {
				
					uValRefresh = uValue + '?' + Math.random();
					
					o.find( 'img' ).attr( 'src', '' );			// Blank
					o.find( 'img' ).attr( 'src', uValRefresh );	// Refrescamos cache
					o.find( 'img' ).attr( 'src', uValue );		// Dejamos valor original
					o.find( 'img' ).css( 'display', '' );				
					
					if ( typeof cargo  !== 'undefined' ) {

						o.find( 'a' ).attr( 'href', cargo );							
					}																		
				}

				break;
			
			case 'tgrid':
			
				var oGrid = this.GetControl( cId )	

				if ( $.type( oGrid ) === 'object' ) {			
					oGrid.SetData( uValue );
				}
				
				break;	

			case 'tfolder':				
			
				uValue = ( typeof( uValue ) === 'number') ? ( uValue - 1 ) : 0; 

				o.tabs( "option", "active", uValue );			// Activamos el primer Tab				
				
				break;					
		
			case 'tmsgitem':
			
				if (typeof( uValue ) === 'undefined') uValue = '';					
							
				var x = $( o ).find( 'p' ) 
				
				$(x).html( uValue );
				
				var z = $( o ).find( 'img' ) 
				
				if ( uValue == '' ) {		
					$( z ).hide();	
				} else {				
					$( z ).show();				
				}					
				
				if (typeof( cargo ) === 'string') {	
					
					if ( cargo == '' ) {	
						$( z ).hide();					
					} else {
						$( z ).attr( "src", cargo ); 
						$( z ).show();	
					}					
				}					
			
				break;
				
			case 'tprogressbar':	

				if (typeof( uValue ) === 'undefined') uValue = 0;	

				uValue = parseInt( uValue );
				
				o.progressbar( "option", {value: uValue });
				
				break;
				
			//	Importante: De momento suponemos que dentro de un TDiv habra un 
			//	TPanel. Hemos de revisar por si hay otro TDiv o lo que sea...

			case 'tdiv':
				
				//o.children( '[data-control="tpanel"]').css( 'display', 'none' );										
				o.children( 'div').css( 'display', 'none' );										
			
				if ( uValue ) {						
		
					$( '#' + uValue ).css( 'display', '' );					
				}						
				
				break;

			//	----------------------------------------------------------------------
			//	Inicialmente buscabamos los hijos del contenedor que eran de la clase
			//	TPanel. 
			//		o.children( '[data-control="tpanel"]').css( 'display', 'none' );
			//	Con el nuevo control TDiv, puede ser que un elemento de dentro
			//	el contenedor sea TDiv, TPanel,... Buscaremos entonces los hijos del
			//	contenedor que sean DIV independientemente del tipo 
			//	----------------------------------------------------------------------
				
			case 'tpanel':
	
				//o.children( '[data-control="tpanel"]').css( 'display', 'none' );				
				o.children( 'div' ).css( 'display', 'none' );				
			
				if ( uValue ) {						
		
					$( '#' + uValue ).css( 'display', '' );					
				}						
				
				break;
				
			case 'tframe':
		
				if ( uValue == '' || uValue == null ) {
				
					o.find( 'iframe' ).attr( 'src', '' );
					o.find( 'iframe' ).css( 'display', 'none' );
					
				} else {
				
					uValRefresh = uValue + '?' + Math.random();
					
					o.find( 'iframe' ).attr( 'src', '' );			// Blank
					o.find( 'iframe' ).attr( 'src', uValRefresh );	// Refrescamos cache
					o.find( 'iframe' ).attr( 'src', uValue );		// Dejamos valor original
					o.find( 'iframe' ).css( 'display', '' );				
																		
				}

				break;

			case 'teditor':	

				var oEditor = new TEditor( cId );
				
				if ( ( typeof( uValue ) === 'undefined') || uValue == '' )
					uValue = ' ';
		
				oEditor.Set( uValue );
								
				break;

			case 'taccordion':

				//	Pendiente de chequear si esta activado...
			
				var nTab = parseInt( uValue );

				if ( nTab == 0 )
					$("#" + cId + '_content' ).accordion( "option", "active", false );
				else {
					nTab--;
					$("#" + cId + '_content' ).accordion( "option", "active", nTab );
				}
			
				break;		

			case 'ttree':
			
				var oTree = this.GetControl( cId )
				
				oTree.SetData( uValue );
				
				break;				
				
			case 'thidden':
			
				var cValue;

				if ( $.type( uValue ) == 'string' ) {
					cValue = uValue
				} else {			
					cValue = JSON.stringify( uValue )
				}

				o.val( cValue );
			
				break;	
				
			case 'tyoutube':		// 	Igual que iframe					

				var cUrl = "https://www.youtube.com/embed/" + uValue;

				uValRefresh = cUrl + '?' + Math.random();
			
				o.find( 'iframe' ).attr( 'src', '' );			// Blank
				o.find( 'iframe' ).attr( 'src', uValRefresh );	// Refrescamos cache
				o.find( 'iframe' ).attr( 'src', cUrl );		// Dejamos valor original
				o.find( 'iframe' ).css( 'display', '' );					
				
				break;
				
			default:
				if ( o )
					o.val( uValue );						
		}
	
	
	}

	this.Hide	= function( cId ) {		

		var o 			= $( '#' + cId );

		if ( o == null )
			return null
			
		var cControl 	= o.attr( 'data-control' ) ;

		switch ( cControl ) {	

			case 'tradio':
			
				$('input:radio[name=' + cId + ']').hide();
				$('input:radio[name=' + cId + ']+label').hide();
				break;
			
			case 'tcombobox':
			
				var cProp = o.prop( 'type' );

				if ( ( cProp == 'select-multiple' ) || ( cProp == 'select-one' )) {	
					o.parent().hide();
				} else	 {
					o.hide();
				}
				
				break;
				
			case 'tcheckbox':
			
				o.hide();
				
				var cLabel = '__tweblabel__' + cId;				
				$( "#" + cLabel ).hide();				

				break;
				
			case 'tgrid':				
			
				o.hide();
				$( '#' + cId + '_title' ).hide();
				
				break;
				
			default:
				o.hide();				
		}
	}

	this.Show	= function( cId ) {		

		var o 			= $( '#' + cId );

		if ( o == null )
			return null
			
		var cControl 	= o.attr( 'data-control' ) ;	

		switch ( cControl ) {	
		
			case 'tradio':
			
				$('input:radio[name=' + cId + ']').show();
				$('input:radio[name=' + cId + ']+label').show();
				break;
				
			case 'tcombobox':
			
				var cProp 		= o.prop( 'type' );			
				
				if ( ( cProp == 'select-one' ) ||  ( cProp == 'select-multiple' )) {
					o.parent().show();
				} else	 {
					o.show();
				}
				
				break;		

			case 'tcheckbox':
			
				o.show();
				
				var cLabel = '__tweblabel__' + cId;				
				$( "#" + cLabel ).show();	
				
				break;
				
			case 'tgrid':
			
				o.show();
				$( '#' + cId + '_title' ).show();
				
				break;
				
			default:
				o.show();				
		}
	}

	this.Disable 	= function( cId, uValue ) {		

		var o 			= $( '#' + cId );

		if ( o == null )
			return null
			
		var cControl 	= o.attr( 'data-control' ) ;

		switch ( cControl ) {	

			case 'tget':
	
				o.prop( 'disabled', true ); 
				
				var oBtn = $( '#tweb_btn_' + cId );
				oBtn.hide(); 
			
				break;
				
			case 'tradio':
			
				$('input:radio[name=' + cId + ']').prop( 'disabled', true ); 
				break;				
			
			
			case 'tcombobox_ex':	
			case 'tcombobox':
			
				var cProp 		= o.prop( 'type' );

				if ( ( cProp == 'select-multiple' ) || ( cProp == 'select-one' )) {						
					o.multipleSelect( 'disable' );									
				} else {					
					o.prop( 'disabled', true );
				}
			
				break;
				
			case 'tgrid':
			
				var oGrid = this.GetControl( cId );
				
				oGrid.SetOptions( 'editable', false );
			
				break;

			case 'tfolder' : 	
				
				if ( typeof uValue == 'object' ) {
			
					o.tabs( "option", "disabled", uValue );				
				
				} else { 
							
					var nTabs = $( "#" + cId + " >ul >li").size();		//var t = $("#500").tabs("length");  // No xuta
			
					var aTabsOff = [];

					for (i = 1; i < nTabs; i++) { 
						aTabsOff.push( i );
					}

				// Siempre ha de haber un Tab activo. POr defecto activaremos el 1 y desactivaremos los demas

					$( "#" + cId ).tabs( "option", "active", 0 );			// Activamos el primer Tab
					$( "#" + cId ).tabs( "option", "disabled", aTabsOff );	// Desactivamos los demas Tabs. Siempre tiene de haber 1 activo				
					
				}

				break;				
				
			case 'ttree':
				
				var oTree = this.GetControl( cId )

				if ( oTree ) {				
					oTree.Disable();
				}
				
				break;

			case 'teditor':	

				var oEditor = new TEditor( cId );
		
				oEditor.Disable();
								
				break;	

			case 'taccordion':
			
				$( "#" + cId + '_content' ).accordion( "option", "active", false );
				$( "#" + cId + '_content' ).accordion( {  disabled: true });
			
				break;				
				
			default:

				o.prop( 'disabled', true ); 			
		}
	}	

	this.Enable 	= function( cId ) {		

		var o 			= $( '#' + cId );

		if ( o == null )
			return null
			
		var cControl 	= o.attr( 'data-control' ) ;	
		
		switch ( cControl ) {
		
			case 'tget':
	
				o.prop( 'disabled', false ); 
				
				var oBtn = $( '#tweb_btn_' + cId );
				oBtn.show(); 
			
				break;		

			case 'tradio':
			
				$('input:radio[name=' + cId + ']').prop( 'disabled', false ); 
				break;	
				
			case 'tcombobox_ex':
			case 'tcombobox':
			
				var cProp 		= o.prop( 'type' );
			
				if ( ( cProp == 'select-multiple' ) || ( cProp == 'select-one' )) {						
					o.multipleSelect( 'enable' );									
				} else {					
					o.prop( 'disabled', false );
				}
			
				break;
				
			case 'tgrid':
			
				var oGrid = this.GetControl( cId );
				
				oGrid.SetOptions( 'editable', true );
				
				break;

			case 'tfolder' : 	

				o.tabs( "enable" );	
				
				break;				
				
			case 'ttree':			
				
				var oTree = this.GetControl( cId )
				
				if ( oTree ) {							
					oTree.Enable();					
				}
				
				break;

			case 'teditor':	

				var oEditor = new TEditor( cId );
		
				oEditor.Enable();
								
				break;	

			case 'taccordion':
			
				$( "#" + cId  + '_content' ).accordion( {  disabled: false });
			
				break;					
				
			default:
				o.prop( 'disabled', false ); 			
		}
	}

	this.Focus = function( cId ){	
	
		var o 			= $( '#' + cId );

		if ( o == null )
			return null
			
		var cControl 	= o.attr( 'data-control' ) ;		


		switch ( cControl ) {	

			case 'tradio':			
			
				$('input:radio[name=' + cId + ']').focus();
				break;			
			
			case 'tcombobox':	
			
				var cProp 		= o.prop( 'type' );
			
				if ( cProp == 'select-multiple' ) {						
					o.multipleSelect( 'focus' );									
				} else {					
					o.focus();
				}
			
				break;
				
			case 'teditor':	

				var oEditor = new TEditor( cId );
		
				oEditor.Focus();
								
				break;	
				
			case 'taccordion':	

				//	No funciona, pero tiene sentido ?
				$( "#" + cId + '_content' ).focus();				
				
				break;	
				
			default:
		
				o.focus();		
				//o.select();	// Si el campo esta vacio no funciona...	
		}				
	};
	
	this.Upper = function( cId ){
	
		var o 	= $( '#' + cId );
		var c 	= '';

		if ( o == null )
			return null
			
		var cControl 	= o.attr( 'data-control' ) ;
		
		if ( cControl == 'tget' ) {
			var c = this.Get( cId ).toUpperCase() ;
			this.Set( cId, c );		
		}
		
		return c;				
	};

	this.Lower = function( cId ){
	
		var o 	= $( '#' + cId );
		var c 	= '';

		if ( o == null )
			return null
			
		var cControl 	= o.attr( 'data-control' ) ;
		
		if ( cControl == 'tget' ) {
			var c = this.Get( cId ).toLowerCase() ;
			this.Set( cId, c );		
		}
		
		return c;					
	};			
	
	this.ControlInit = function( cId, oControl, cType ){	

		TControl.aControls[ cId ] = [ oControl, cType ];
	}	

	this.GetControl = function( cId ) {
	
		var oControl = null;
	
		if ( cId in TControl.aControls ) {
			var oControl = TControl.aControls[ cId ][ 0 ];
		}
		
		return oControl;
	}

	this.GetControls = function() {
		return TControl.aControls;
	}		
	
	//	EVENT System -------------------------------------------------------------

		this.InitEvent	= function ( cEvent, uFunction ) {
		
			var cType = typeof uFunction;
		
			switch ( cType ) {
			
				case 'string':			
					
					var fn =  window[ uFunction ]
					
					if (typeof fn === "function") {										
								
						//TControl.bSignal = fn;
						
						this.SetEvent( cEvent, fn );
						
					} else {
						MsgError( uFunction + ' ' + _( '_error_no_function' ) );
					}								
				
					break;
					
				case 'function':
				
					this.SetEvent( cEvent, uFunction );
					
					break;
					
				case 'undefined':				
				
					this.SetEvent( cEvent, null );
					break;
					
				default:
				
					this.SetEvent( 'error', null );				
			}

		}	
		
		this.SetEvent = function( cEvent, bFunction ) {
		
			switch ( cEvent ) {
			
				case 'signal':
				
					TControl.aEvents[ 'signal' ] = bFunction;
					break;
					
				case 'message':
				
					TControl.aEvents[ 'message' ] = bFunction;
					break;
					
				case 'error':
				
					MsgError( _( '_error_init_event' ) )
					break;
			
					
				default:
				
					MsgError( _( '_error_event_no_exist' ) )						
			}	
		}
		
		this.LogEvents = function() { console.log( 'Events', TControl.aEvents ) }
	
	//	EVENT message ------------------------------------------------------------------------------	

		this.InitMessage	= function ( uFunction ) {	this.InitEvent( 'message', uFunction )	}
		
		this.SetMessage	= function ( cMsg ) {	
		
			cMsg = ( typeof cMsg == 'string' ) ? cMsg : '';
			
			var fn 		= TControl.aEvents[ 'message' ]
			var lEvent 	= false
			
			if ( fn ) {
				lEvent = true;
				var fnparams = [ cMsg ];
				fn.apply(null, fnparams );				
			}
		
			return lEvent;		
		}
		
		this.InitCtrlMessage	= function( cId ) {
		
			var cControl 	= $('#' + cId ).attr( 'data-control' ) ;
		
			var o 		= null;
			var cTxt 	= '';
			
			switch ( cControl ) {
			
				case 'tradio':
				
					o 		= $('input:radio[name=' + cId + '],label[name=' + cId + ']');	
					cTxt	= $( '#' + cId  ).attr( 'data-message' )					
				
					break;
			
				default:
				
					o 		= $( '#' + cId  );
					cTxt	= o.attr( 'data-message' )
			}
			
			if ( o ) { 
			
				var oThis = this;
				
				o.mouseenter( function() {
											oThis.SetMessage( cTxt );
			
										});
											
				o.mouseout( function() {
											oThis.SetMessage( '' );										
										});					
			}
		
		}
	
	//	EVENT signal -------------------------------------------------------------------------------	
	
		this.InitSignal	= function ( uFunction ) {	this.InitEvent( 'signal', uFunction )	}	
		
		this.SetSignal	= function ( lOnOff ) {	
	
			lOnOff = ( typeof lOnOff == 'boolean' ) ? lOnOff : false;
			
			var fn 		= TControl.aEvents[ 'signal' ]
			var lEvent 	= false
			
			if ( fn ) {
				lEvent = true;
				var fnparams = [ lOnOff ];
				fn.apply(null, fnparams );				
			}
		
			return lEvent;		
		}			
}


//	EN TEST...

	function TWeb_EvalWhen() {	
	
		$("input").blur(function(){								
		
			var oControl = new TControl();
			var allInputs = $( ":input" );		
			
			var n =  allInputs.length	

			for (i = 0; i < n; i++) { 					
				o = allInputs[i];
				cId = o.id;		
			
				cFunction = $('#' + cId ).attr( 'data-when' ) ;								

				if ( $.type( cFunction ) == 'string'  ) {								

					var fn =  window[ cFunction ]
					
					if (typeof fn === "function") {	
					
						//var fnparams = [ args, e ];
						var fnparams = null;
						var lRet = fn.apply(null, fnparams );
										
						if ( $.type( lRet ) == 'boolean' ) {
						
							if ( lRet )
								oControl.Enable( cId )
							else
								oControl.Disable( cId )														
						
						}																		
					}					
				}				
			}			
		});		
	}



//	Sistema Menus ------------------------------------------------------------------

//	IMPORTANT !!! -> Si al crear un Item le pasamos una funcion y esta no existe, el metodo no
//	se ejecuta, por lo que NMO se creara el Item

var TSubMenu = function( cId ) {

	this.oMenu 			= [];
	this.cId   			= cId;	
	this.options 		= { displayAround:'trigger', position: 'bottom' }
	
	this.Item = function( oParent,  name, action, image, disable, tooltip, submenu ) {
	
		if ( typeof(action) == 'string' ){								

			cFunc = window[ action ];	// Convierte el String en puntero a funcion
		
			cType = typeof( cFunc ) ;
			
			if ( cType == 'function' ){
			 
				action = cFunc;
				
			} else {
			
				alert( 'Error en definicion de accion\n\n' + 
						'Item: '  + name + '\nAccion: ' + action );
						
				action = window[ "FWEB_Error_MenuItem" ];					
			}														
						
		}						
		
		if (typeof( name ) === 'undefined') name = '';
		if (typeof( action ) === 'undefined') action = null;
		if (typeof( image ) === 'undefined') image = null;
		if (typeof( disable ) === 'undefined') disable = false;
		if (typeof( submenu ) === 'undefined') submenu = null;
		if (typeof( tooltip ) === 'undefined') tooltip = null;			
		
		var oItem = new Object();

		oItem[ 'name'	] = name ;
		oItem[ 'img' 	] = image;
		oItem[ 'title' 	] = tooltip;
		oItem[ 'fun' 	] = action;
		oItem[ 'disable'] = disable;
		oItem[ 'subMenu'] = submenu;	

		if ( oParent === null ) {		
			this.oMenu.push( oItem );	
		} else {
			if ( TObjectLen( oParent[ 'subMenu' ] ) === 0 ) oParent[ 'subMenu' ] = [];						
			
			oParent[ 'subMenu' ].push( oItem );
		}

		return oItem;		
	}		
	
	this.Init = function(){
	
		$('#' + this.cId ).contextMenu( this.oMenu, this.options );		

	}			
}

// TREE -------------------------------------------------------------------------------------------

	var TTree = function( cId, aDat ){	

		this.oTree 			= null ;
		this.cId 			= cId ;
		this.data			= aDat;
		this.nAnimation		= 0;
		this.lCheckbox		= false;
		this.lMultiple		= false;
		this.lStripes		= false;
		this.bClick 		= null;
		this.bDblclick 		= null;
		this.lDisabled 		= false;
		this.oItemStatus	= new Object();
		this.aPlugins 		= [ "wholerow", "search" ];
	
		var oThis = this;
	
		this.Init	= function() {
		
			if ( this.lCheckbox ){
			
				this.lMultiple = true;
				this.aPlugins.push( 'checkbox' );									
			}

			var oTree = $( '#' + this.cId )
				.jstree( {
						'core' : {
							'multiple' : this.lMultiple,
							'animation': this.nAnimation,
							'themes' : { "stripes" : this.lStripes },
							'data' : this.data
							},										
						"plugins" : this.aPlugins  // Wholerow marca tota la linea amb focus, Search permet fer busquedes						
					})	
					
			if ( typeof this.bClick == 'function') {

				if ( $.type( oTree ) === 'object' ) {
				
					oTree.on( "changed.jstree", function (e, data) {
						
						if ( oThis.lDisabled == false ) {
							var oNode	=  data.node					
							var fnparams = [ oNode ];
							oThis.bClick.apply(null, fnparams );																				
						}
					});					
				
				}
			}
			
				
			if ( typeof this.bDblclick == 'function') {
			
				if ( $.type( oTree ) === 'object' ) {
				
					oTree.on( "dblclick.jstree", function (e, data) {
					
						if ( oThis.lDisabled == false ) {
							
							var oTree 	= $('#' + oThis.cId ).jstree(true);
							var oNode	=  oTree.get_node( e.target )
							if ( oNode.state.disabled == false ) {									

								var fnparams = [ oNode ];
								oThis.bDblclick.apply(null, fnparams );
							}								
						}
					});	
				}
			}
			
			this.oTree = oTree;
			
			var o = new TControl()								
			o.ControlInit( this.cId, this, 'tree' )				
							
		}

		this.CollapseAll	= function() {	$( '#' + this.cId ).jstree( 'close_all' ) }
		this.ExpandAll		= function() {	$( '#' + this.cId ).jstree( 'open_all' ) }		
		
		this.Disable	= function() {				
	
			this.lDisabled = true;		

			var aTail = $('#' + this.cId ).jstree(true).get_json('#', { 'no_data': true, 'flat': true,'no_state': false });		
			
			var oTree = $( '#' + this.cId ).jstree( true )
			
			this.oItemStatus = new Object();
			
			$.each( aTail, function( key, value ) {				
	
				oThis.oItemStatus[ value.id ] =  value.state.disabled

				oTree.disable_node( value ); 
			});					
		}
		
		this.SetData 	= function( aData ) {		

			$('#' + this.cId ).jstree(true).settings.core.data = aData;
			$('#' + this.cId ).jstree(true).refresh();
		}
		
		this.GetData 	= function() {
		
			var aData = $('#' + this.cId ).jstree(true).get_json('#', { 'no_data': false, 'flat': true, 'no_state': false });
			
			return aData;
		}
		
		this.Enable	= function() {				

			if ( ! this.lDisabled )
				return false;				

			var oTree = $('#' + cId ).jstree(true)
			
			$.each( this.oItemStatus, function( key, value ) {

				var node = $("#" + cId ).jstree().get_node( key );

				if ( ! value ) {		
					oTree.enable_node( node );
				}
				
			});	

			this.oItemStatus 	= new Object();
			this.lDisabled 		= false;
		}
		
		this.GetChecked 	= function() {
		
			var selectedElmsIds = [];
			var selectedElms = $("#" + cId ).jstree("get_selected", true);
			$.each(selectedElms, function() {
				selectedElmsIds.push(this.id);
			});
			
			return selectedElmsIds;			
		}

		this.Search 	= function( cTxt ) {
			var oTree = $('#' + cId ).jstree(true)
			oTree.search( cTxt );			
		}
		
		//	No xuta be. Si el troba encara queda marcat el vell...
		this.Goto		=  function ( cId ) {
			var oTree = $('#' + cId ).jstree("select_node", cId ); 			
		}
		
	}

/*	TUpload() - Subir Ficheros...		

		var oData 	= new Object();
		
		oData[ 'ACTION'	] = 'upload';
		oData[ 'PARAM2' ] = 1234 ;
		oData[ 'PARAM3' ] = "test" ;	
*/

	var TUpload = function( cId, cPhp, oData ){

		cId 	= (typeof cId 	== 'undefined' ) ? '' : cId;
		cPhp	= (typeof cPhp 	!== 'string' ) ? '' : cPhp;		
		
		this.cId 			= cId;
		this.cPhp 			= cPhp ;
		this.oData 			= oData ;

		this.bSend			= null;
		this.bDone			= null;
		this.bFail			= null;
		this.bProgress		= null;
		this.bProgressAll	= null;
		this.bStop			= null;	
		
		this.Execute	= function(){				
		
			if ( jQuery.isFunction( $('#' + this.cId ).fileupload ) == false ) {
				MsgError( 'No se ha cargado el módulo upload' )
				return null
			}		
			
			if ( cPhp == '' ) {
				MsgError( 'Especificar url en TUpload()' )
				return null
			}		
			
			var o 		= new TControl();
			var aFiles 	= o.Get( this.cId ) ;
			
			if ( ( aFiles.length ) == 0 ) {	
				return null;
			}	
			
		//	Parametros adicionales...			

			$('#' + this.cId ).fileupload({										

				autoUpload: false,
				singleFileUploads: false, 	
				
				add: function (e, data) {							
					data.submit();			
				},						
				
				send: this.bSend, 
				done: this.bDone, 
				fail: this.bFail, 
				progress: this.bProgress,
				progressall: this.bProgressAll,
				stop: this.bStop
				
			});	

			for (var i = 0; i < aFiles.length; i++){	
				$('#' + this.cId ).fileupload( 'add', { files: aFiles[i] , url: this.cPhp, formData: this.oData } );	
			}			
			
		}	
		
	}

//	MsgNotify --------------------------------------------------------------------------------------	
//	cType = 	succes, info, error, warn

	function MsgNotify( cMsg, cType, lSound ) {
	
		cType  = (typeof cType == 'undefined' ) ? 'success' : cType;
		lSound = (typeof lSound == 'boolean' ) ? lSound : false;
		
	//	$.notify.defaults( { style: 'metro' );
	
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
		
		$.notify( cMsg, cType );
	
	}	
	
	

// 	MAPS -------------------------------------------------------------------------------------------
/*		Tipo de Mapa ! 
		==============
		ROADMAP 	muestra la vista de mapa de carretera predeterminada.
		SATELLITE 	muestra imágenes de sat├®lite de Google Earth.
		HYBRID 		muestra una mezcla de vistas normales y de satélite.
		TERRAIN 	muestra un mapa físico basado en información del relieve. 		
*/
// -------------------------------------------------------------------------------------------------

	var TMaps = function( cId ){

		this.cId   			= cId;
		this.cKey 			= '';
		this.nLat 			= 0;
		this.nLng 			= 0;
		this.nZoom			= 15;
		this.cType			= 'hybrid';
		this.cTitle			= 'TWeb';
		this.map			= null;
		this.aMarkers		= [];
		
		this.SetLatLng	= function( nLat, nLng ){				
			this.nLat = nLat;				
			this.nLng = nLng;					
		};		
		
		this.SetTitle	= function( cTitle ){ this.cTitle = cTitle;	};			
		this.SetZoom	= function( nZoom  ){ this.nZoom = nZoom;	};			
		this.SetType	= function( cType  ){ this.cType = cType.toLowerCase();	};			
		
		this.Init = function(){
		
			cType = $.type( window[ 'google' ] ) ;
			
			if ( cType == 'undefined' ) {
				MsgError( _( '_error_no_module' ) + ' Google' )
				return null
			}				
			
			//geocoder = new google.maps.Geocoder();

			oLatLng = new Object();
			oLatLng[ 'lat' ] = this.nLat;
			oLatLng[ 'lng' ] = this.nLng;

			var aOptions = { center: oLatLng, zoom: this.nZoom }

			this.map = new google.maps.Map(document.getElementById( this.cId ), aOptions);
			this.map.setTilt(0);

	 
	 		if ( this.nLat != 0 && this.nLng != 0 ) {	 					
				var marker = new google.maps.Marker({ position: oLatLng, map: this.map, title: this.cTitle });
				this.aMarkers.push(marker);				
			}
			  
			panorama = this.map.getStreetView();

			panorama.setPosition(oLatLng);
			panorama.setPov(({
				heading: 265,
				pitch: 0
			}));

			var o = new TControl();
			o.ControlInit( this.cId, this, 'map' );
		
		};	
		
		this.AddMarker = function( nLat, nLng, cTitle, cIcon ) {
		
			cTitle = (typeof cTitle == 'undefined' ) ? null : cTitle;						
	
			var latlng = new google.maps.LatLng( nLat, nLng );			

			var marker = new google.maps.Marker({ position: latlng, map: this.map, title: cTitle, icon: cIcon });	

			this.aMarkers.push(marker);
			
		}	

		this.DelMarkers = function() {
		
			for (var i = 0; i < this.aMarkers.length; i++) {
				this.aMarkers[i].setMap(null);
			}

			this.aMarkers = [];
		}

		
	}
	

/* 	TGetComplete -----------------------------------------------------------------------------------
 		
	El webservice devolvera un array de array asociativo con los valores:
		value:	Valor clave que buscamos
		item:	Texto que aparecerá en el desplegable
	----------------------------------------------------------------------------------------------*/
	
	var TGetComplete = function( cId, cPhp, bSelect, oParameters ){

		this.cId   			= cId;
		this.cPhp 			= cPhp;
		this.cType 			= 'POST';
		this.bSelect		= bSelect;
		this.minLength		= 5;
		this.delay			= 300;
		this.trigger		= '=';
		//this.oParam 		= null;
		this.bBefore		= null;
		this.bSignal		= null;
		this.bHelp			= null;
		this.cHelp			= null;
		this.cId_Dialog		= '';
		
		var oGet = this;
		
		this.Init = function(){
		
			oGet.oParam = new Object();

			$( "#" + this.cId ).autocomplete({			  
			  delay: this.delay, 		
			  focus: function( event, ui ) {
				 // prevent value inserted on focus		
				return false;
			  },		  
			  minLength: this.minLength + 1,		// 1 = longitud del trigger -> =
			  source: TWeb_TGet_Source,
			  select: TWeb_TGet_Select,
			  search: TWeb_TGet_Search			  
			});
			
			if ( this.cId_Dialog !== '' )
				$( "#" + this.cId ).autocomplete( 'option', 'appendTo', '#' + this.cId_Dialog );	//	IMPORTANTE si se ejecuta desde un Dialog
		
		};
		
		function TWeb_TGet_Search() {

			if ( oGet.trigger === '' )
				return true;

			var cValue = this.value;
		  
			if ( cValue.length < 4 )
				return false;
			
			if ( cValue.substr(0,1) !== oGet.trigger )
				return false;									
		};

		function TWeb_TGet_Source( request, response ) {
		
			var uValue = request.term;	
			
			if ( oGet.trigger !== '' ){						
				uValue = uValue.substr(1);										
			}	
						
			var oParam = new Object();
				oParam[ 'search' ] = uValue			
			
			var fn = oGet.bBefore;
			var oNewParam = null
			
		
			if (typeof fn === "function") {				

				var fnparams = null;
				oNewParam = fn.apply(null, fnparams );								
			}
			
			if ( $.type( oNewParam ) == 'object' ) {
				for( var key in oNewParam ) {			
					oParam[ key ] = oNewParam[ key ]			
				}
			}
	
			if ( $.type( oParameters ) == 'object' ) {
				for( var key in oParameters ) {					
					oParam[ key ] = oParameters[ key ]			
				}
			}										
			
			//	Importante: Si TGetcomplete lo usamos desde un dialog, MsgSignal() hace que 
			//	no muestra el resultado. Pendiente
			//	MsgSignal( true );					
				
				if (typeof oGet.bSignal === "function") {	
					var fnparams = [ true ];
					oGet.bSignal.apply(null, fnparams );			
				}			
				

			$.ajax({
			  type: oGet.cType,
			  url: oGet.cPhp,
			  data: oParam,
			  success: response,
			  complete: function() { 
			  
				//MsgSignal() 
				
				if (typeof oGet.bSignal === "function") {	
					var fnparams = [ false ];
					oGet.bSignal.apply(null, fnparams );			
				}				
				
			  },
			  error: function( oError ) {

				if ( oError.status == 404 ) 
					MsgError( _( '_error_no_file' ) + ' ' + oGet.cPhp )
				else 
					MsgError( oError.responseText )

			  },			  
			  dataType: 'json'
			});			
		
		} ;			
		
		function TWeb_TGet_Select( event, ui ) {

			// 	prevent autocomplete from updating the textbox
				event.preventDefault();	
			
			var fn = oGet.bSelect;
			
			if (typeof fn === "function") {				
				var fnparams = [ui.item];
				fn.apply(null, fnparams );								
			}														
		}									
		
	}	

/* 	TEditor ----------------------------------------------------------------------------------------

	----------------------------------------------------------------------------------------------*/
//	API -> http://www.sceditor.com/api/sceditor/
	function TWeb_InitEditor( cId ){
console.log( 'TWEB_EDITOR', cId );	
		$( "#" + cId ).sceditor( {
			toolbar: "bold,italic,underline, strike|left,center,right,justify|font,size,color|bulletlist,orderedlist|horizontalrule,image,email,link,unlink|maximize,source",
			resizeEnabled: false,
			style: "../tweb/libs/sceditor/minified/themes/square.min.css",
			emoticonsRoot: "./fweb/sceditor/",
			emoticonsEnabled : false, 
			//plugins: 'xhtml',   // 'bbcode',
			plugins: 'bbcode',
			spellcheck: false,
			locale: "es"
		});		
		

//		var o = $("#" + cId ).sceditor('instance').dimensions();
//		console.log( o );			
	}			
	
	var TEditor = function( cId ){
alert('ep')
		this.cId  = cId;		
		
		this.Init = function(){
		
			if ( jQuery.isFunction( $('#' + this.cId ).sceditor ) == false ) {
				MsgError( _( '_error_no_module' ) + ' Editor' )
				return null
			}		

			var aCfg = {
				toolbar: "bold,italic,underline, strike|left,center,right,justify|font,size,color|bulletlist,orderedlist|horizontalrule,image,email,link,unlink|maximize,source",
				resizeEnabled: false,
				//resize_enabled: true,
				style: "libs/sceditor/minified/themes/square.min.css",	
				emoticonsRoot: "./tweb/libs/sceditor/",
				emoticonsEnabled : false, 
				//resizeMaxHeight: -1,
				//plugins: 'xhtml',   // 'bbcode',
				plugins: 'bbcode',   // 'bbcode',
				spellcheck: false,
				locale: "es"		
			}		
	
			$( "#" + cId ).sceditor( aCfg );		

			var oEditor = $( "#" + cId  ).sceditor( 'instance' );
		
				oEditor.width( '100%' );
				oEditor.height( '100%' );					
		}
		
		this.Get = function() {
	
			var o = this.GetEditor();
			
			var uValue = o.val();
			
			return uValue;					
		}
		
		this.Set = function( uValue ) {
	
			var o = this.GetEditor();
			
			o.val( uValue );
			
			return null;					
		}

		this.Disable = function() {
	
			var o = this.GetEditor();
			
			o.readOnly( true );
			
			return null;					
		}
		
		this.Enable = function() {
	
			var o = this.GetEditor();
			
			o.readOnly( false );
			
			return null;					
		}	

		this.Focus = function() {
	
			var o = this.GetEditor();
			
			o.focus();
			
			return null;					
		}		
		
		this.GetEditor = function() {
		
			var cId = this.cId + '_editor'
		
			var oEditor = $( "#" + cId  ).sceditor( 'instance' );
		
			return oEditor;
		}
		
		
	}
	
	//	--------------------------------------------------------------------------------------------

function TSound( cFile ) {

	var audioElement = document.createElement('audio');
	audioElement.setAttribute('src', cFile );
	audioElement.setAttribute('autoplay', 'autoplay');
	//audioElement.Play();		
}

function TSound_Success()	{ TSound( _( '_sound_success' ) ) }
function TSound_Error()		{ TSound( _( '_sound_error' ) ) }
function TSound_Warning()	{ TSound( _( '_sound_warn' ) ) }
function TSound_Info()		{ TSound( _( '_sound_info' ) ) }
	
function TTime() {	

	var d = new Date();		
	var h = d.getHours();
	var m = d.getMinutes();
	var s = d.getSeconds();
	
	if ( h < 10 )
		h = "0" + h;			
	if ( m < 10 )
		m = "0" + m;				
	if ( s < 10 )
		s = "0" + s;				
	
	var cTime = h + ":" + m + ":" + s ;
	
	return cTime;

};	

function TDate(){	

	var d = new Date();	
	var a = d.getFullYear();
	var m = d.getMonth() + 1 ;
	var d = d.getDate();		

	if ( m < 10 )
		m = "0" + m;
	if ( d < 10 )
		d = "0" + d;				
	
	var dDate =  d + "/" + m + "/" + a ;
	
	return dDate;

};

function TObjectLen( o ) {

	var count = 0;
	var i;
	
	for (i in o) {
		if (o.hasOwnProperty(i)) {
			count++;
		}					
	}
	return count;		
}	

//	Función para situar el cursor en un campo tipo textarea. Uso: setSelectionRange( $('#id'), 10, 10 )
function setSelectionRange(input, selectionStart, selectionEnd) {
  if (input.setSelectionRange) {
	input.focus();
	input.setSelectionRange(selectionStart, selectionEnd);
  } else if (input.createTextRange) {
	var range = input.createTextRange();
	range.collapse(true);
	range.moveEnd('character', selectionEnd);
	range.moveStart('character', selectionStart);
	range.select();
  }
}	

/*	Funcion para hacer un submit i pasar los parametros via post
	
	url_redirect( {	url: 'my_file.php',
					method: "post",
					data: { LAST: cLast, TEST: 1234 }
				});
	
*/	
function url_redirect(options){

	 var $form = $("<form />");
	 
	 $form.attr("action",options.url);
	 $form.attr("method",options.method);
	 
	 for (var data in options.data) {
		 $form.append('<input type="hidden" name="'+data+'" value="'+options.data[data]+'" />');
	 }
	  
	 $("body").append($form);
	 $form.submit();
}

//	-------------------------------------------------------------------

function InitViewLog( cPhp_View_Log ) {

	$('#_log').click( function() { 
	
		var oConfig = new Object()
		
		oConfig[ 'title' 		] = _( '_dlg_title_log' );
		//	oConfig[ 'icon' 		] = _( '_msg_image_log' );	// No xuta
		oConfig[ 'maximizable' 	] = true;
		oConfig[ 'minimizable' 	] = false;
		oConfig[ 'collapsable' 	] = false;
		oConfig[ 'resizable' 	] = true;
		oConfig[ 'modal' 		] = true;

		
		TLoadDialog( 'tweb_log', cPhp_View_Log, null, oConfig )		
	});	
}
/*
	padLeft(20,5);          // 00020
	padLeft(20,5,1);        // 11120
	padLeft(20,5,'-');      // ---20
*/
function padLeft(data,size,paddingChar) {
  return (new Array(size + 1).join(paddingChar || '0') + String(data)).slice(-size);
}
