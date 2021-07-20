//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    local o, oCol, oBrw
	local aRows 	:= LoadData()	//	Registers + id (recno)
	local hStates 	:= LoadStates()


	DEFINE WEB oWeb TITLE 'xBrowse II' TABLES INIT
	
	DEFINE FORM o

		HTML o INLINE '<h3>Basic xBrowse II</h3><hr>'		
		
	INIT FORM o
		
		//	Define Cols
		//	CfgCol keys: header, align, width, sort, edit, edit_type, formatter, escape 							

		hCfgCol := {=>}
		
		hCfgCol[ 'id'] 			:= { 'header' => 'Id.', 'align' => 'center', 'width' => 50 }
		hCfgCol[ 'first'] 		:= { 'header' => 'First', 'edit' => .t., 'sort' => .t. }
		hCfgCol[ 'last'] 		:= { 'header' => 'Last', 'edit' => .t. }
		hCfgCol[ 'married'] 	:= { 'header' => 'Married', 'edit' => .t., 'edit_type' => 'L'}
		hCfgCol[ 'state'] 		:= { 'header' => 'State', 'edit' => .t., 'edit_type' => 'COMBOBOX', 'edit_with' => hStates }
		hCfgCol[ 'age'] 		:= { 'header' => 'Age', 'edit' => .t., 'edit_type' => 'N', 'align' => 'center', 'formatter' => 'MyAge'}						
		hCfgCol[ 'salary'] 		:= { 'header' => 'Salary &nbsp;&nbsp;', 'sort' => .t., 'width' => 100, 'edit' => .t., 'edit_type' => 'V', 'align' => 'right' }						
		hCfgCol[ 'notes'] 		:= { 'header' => 'Notes...', 'edit' => .t., 'edit_type' => 'M'  }	

		//	Define browse
		//	CfgBrw keys: uniqueid, height, btnave, btnadd, btndel, lang, dark, stripped, print, export, search, tools, edit_title

		hCfgBrw := {=>}
		
		hCfgBrw[ 'uniqueid' ]  	:= 'id'
		hCfgBrw[ 'height' ] 	:= 600
		hCfgBrw[ 'btnsave' ] 	:= 'MyBtnSave()'
		hCfgBrw[ 'btnadd' ] 	:= 'MyBtnAdd()'
		hCfgBrw[ 'btndel' ] 	:= 'MyBtnDel()'
		//hCfgBrw[ 'lang' ]		:= 'en-EN'
		//hCfgBrw[ 'dark' ] 	:= .t.
		//hCfgBrw[ 'stripped' ] := .t.		
		//hCfgBrw[ 'print' ] 	:= .t.		
		//hCfgBrw[ 'export' ] 	:= .t.		
		//hCfgBrw[ 'search' ] 	:= .t.		
		//hCfgBrw[ 'tools' ] 	:= .t.		
		//hCfgBrw[ 'edit_title' ]:= 'My title...'
		
		
		DEFINE BROWSE ID 'ringo' DATA aRows UNIQUEID 'id' CONFIG hCfgBrw COLS hCfgCol OF o		
		
		HTML o 
		
			<script>
	
				var oBrw 	= new TWebBrowse( 'ringo' )			
				
				function MyAge( value ){
				
					if ( value > 70 )
						return '<b><span style="color:red;">' + value + '</span></b>'
					else
						return value				
				}
				
				function MyBtnSave() {
				
					MsgNotify( 'Check console...');

					var aChanges = oBrw.GetDataChanges()					
					
					console.log( 'You need process now this changes', aChanges )																	
					console.log( 'After process changes you should reset changes browse with ResetChanges() method' )
					
					oBrw.ResetChanges();
				}
				
				function MyBtnAdd() {
				
					var oItem = oBrw.GetItemEmpty()										
						oItem.first 	= 'Mike'
						oItem.married 	= true 
						oItem.age 		= 34 
					
					oBrw.AddRow( oItem )				
				}
				
				function MyBtnDel() {
				
					if ( !oBrw.IsSelect() )
						return null 
				
					MsgYesNo( 'Delete row ?', 'Delete', '<i class="fas fa-trash-restore-alt"></i>', function(){
					
						oBrw.DeleteRow()
					})				
				}	
				
			</script>
		
		ENDTEXT					
	
	END FORM o	
	
retu nil

{% LoadFile( 'loaddata.prg' ) %} 
{% LoadFile( 'loadstates.prg' ) %} 