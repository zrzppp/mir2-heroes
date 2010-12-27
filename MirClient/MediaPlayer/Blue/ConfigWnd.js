with(XMP)
{
XMP.view_ConfigWnd = {
		initUI:function(){  //根据 DataCenter.IsFirstInit 来判断是初始化，还是换肤后恢复现场
			
			XmpConfig.UpdateLayout();
	    XmpConfigContainer.Show();
		},
		saveUI:function(){  //换肤之前保存现场
		},
		AttachEvent:function(){
			// Attach Event
			var sEvents=["onInitUI","onSaveUI","OnCtrlButtonEnableChanged"];
			for(var i = 0; i<sEvents.length; i++)
			{
				var pThis=this;		 
				globalEventSource.attachEvent(this, sEvents[i] ,function(){					 
					var args =  argumentsToArray(arguments).slice(1);
					pThis.OnXMPEvent.apply(pThis, args);				 
					});			  
			}		
		},
		OnXMPEvent:function(sEvent,param1,param2){
			if(sEvent=="onInitUI")
			{	
				this.initUI();
			}
			else if(sEvent=="onSaveUI")
			{
				this.saveUI();
			}
			else if(sEvent=="OnCtrlButtonEnableChanged")
			{
				var ctrlid= arguments[1];
				var enable= arguments[2];
				
				var val = true;
				if(enable == 0)
				val = false;
			
				if(ctrlid==10)
				{
					cfApply.enable = val ;
					if(val)
						cfApply.textcolor="$static.normaltext";
					else
						cfApply.textcolor="$static.disabletext";
				}
			}
		},
		InitXmpConfig:function()
		{
		},
		ResizeXmpConfig:function()
		{
			 XmpConfig.UpdateLayout();
		},
		_OnUIClick:function(sName)
		{
			if(sName=="close")
			{
				 XmpConfig.Cancel();
				 XmpConfigWnd.Hide();
			}
			else if(sName=="ok")
			{
					var ret = XmpConfig.Confirm();
					if(ret)
						XmpConfigWnd.Hide();
			}
			else if(sName=="apply")
			{
					XmpConfig.Apply();
			}
			else if(sName=="General")
			{
			 		XmpConfig.SelectTabView(sName);
			}			
			else if(sName=="Play")
			{
					XmpConfig.SelectTabView(sName);
			}			
			else if(sName=="Color")
			{
					XmpConfig.SelectTabView(sName);
			}			
			else if(sName=="Speed")
			{
					XmpConfig.SelectTabView(sName);
			}			
			else if(sName=="Associate")
			{
				XmpConfig.SelectTabView(sName);
			}			
			else if(sName=="Hotkey")
			{
				XmpConfig.SelectTabView(sName);
			}	
			else if(sName=="Subtitle")
			{
				XmpConfig.SelectTabView(sName);
			}
		}
	};
	
	view_ConfigWnd.AttachEvent();
	
}