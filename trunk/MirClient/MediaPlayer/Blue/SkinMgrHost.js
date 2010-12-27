with(XMP)
{	
XMP.view_SkinMgrHost = {
		AttachEvent:function(){
			// Attach Event
			var sEvents=["onInitUI","onSaveUI"];
			for(var i = 0; i<sEvents.length; i++)
			{
				var pThis=this;		 
				globalEventSource.attachEvent(this, sEvents[i] ,function(){					 
					var args =  argumentsToArray(arguments).slice(1);
					pThis.OnXMPEvent.apply(pThis, args);				 
					});			  
			}		
		},
		_initUI:function()
		{
		},
		_saveUI:function()
		{
			this._XmpSkinMgrHost_Close(false);
		},
		OnXMPEvent:function(sEvent,param1,param2){
			if(sEvent=="onInitUI")
			{	
				this._initUI();
			}
			else if(sEvent=="onSaveUI")
			{
				this._saveUI();
			}
		},
		OnCreate:function()
		{
			XmpPlayer.AttachWindowParent(DataCenter.SkinMgrWnd,XmpSkinMgrHost.handle);
		},
		_OnUIClick:function(sName)
		{
			if(sName=="close")
			{
				this._XmpSkinMgrHost_Close(true);
			}
		},
		_XmpSkinMgrHost_Close:function(real)
		{
			if(real==true)
				XmpPlayer.AttachWindowParent(DataCenter.SkinMgrWnd,0);
			else
				XmpPlayer.AttachWindowParent(DataCenter.SkinMgrWnd,-1);
				
			XmpSkinMgrHost.Close();
		}
	};
	
	view_SkinMgrHost.AttachEvent();
}