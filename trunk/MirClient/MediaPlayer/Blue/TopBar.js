var g_FlashTopBarTimerId = 0;

with(XMP)
{
XMP.view_TopBar = {
		initUI:function(){  //根据 DataCenter.IsFirstInit 来判断是初始化，还是换肤后恢复现场
			
			if(!DataCenter.IsFirstInit)
			{
				this._UpdateByWindowMode();
				this._UpdateByWindowTopmost();
				
				PlayTitle.text = DataCenter.PlayTitleName;
				Publisher.text = DataCenter.PublisherName;
				this._UpdateTopbarSize();
			}
			
			XmpTopBar.Hide();
		},
		saveUI:function(){  //换肤之前保存现场
		},
		AttachEvent:function(){
			// Attach Event
			var sEvents=["onInitUI","onSaveUI","OnFlashTopBar","OnScreenStatusChanged","onTopmostChange","OnTopBarStatusChanged","OnPlayTitleChanged","OnPublisherChanged"];
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
			else if(sEvent=="OnScreenStatusChanged")
			{
				this._UpdateByWindowMode();
			}
			else if(sEvent=="onTopmostChange")
			{
				this._UpdateByWindowTopmost();
			}
			else if(sEvent=="OnTopBarStatusChanged")
			{
				var left = arguments[1];
				var top = arguments[2] ;
				var width=arguments[3];
				var height=arguments[4];
				var topoffset = g_PlayerContainerTop ;
				var leftoffset = g_PlayerContainerLeft ;
				
				if(width==0||height==0)
				{
					XmpTopBar.Hide();
					return;
				}
	
				XmpTopBar.SetParent(XmpMainWnd);
				
				XLUIManager.Trace("OnTopBarStatusChanged:WindowMode="+DataCenter.WindowMode);
					
				if(DataCenter.WindowMode==2)
					XmpTopBar.Move(left+2, top+2, width+2, height);
				else if(DataCenter.WindowMode==1)
					XmpTopBar.Move(left, top, width, height);
				else
					XmpTopBar.Move(left + leftoffset, top + topoffset, width, height);
		
				this._UpdateTopbarSize();
				XmpTopBar.Show(false, false);
			}
			else if(sEvent=="OnPlayTitleChanged")
			{
				PlayTitle.text = DataCenter.PlayTitleName;
				this._UpdateTopbarSize();
			}
			else if(sEvent=="OnPublisherChanged")
			{
				Publisher.text = DataCenter.PublisherName;
				this._UpdateTopbarSize();
			}
			else if(sEvent=="OnFlashTopBar")
			{
				var left = arguments[1];
				var top = arguments[2];
				var width = arguments[3];
				var height = arguments[4];
				
				if(width == 0 || height == 0)
				{
					XmpTopBar.Hide();
				}
				else
				{
					//OnShowTopBar(left, right, width, height);
					XMP.globalEventSource.fireEvent("OnTopBarStatusChanged",left, top, width, height);
					var pThis=this;
					g_FlashTopBarTimerId = timermanager.SetInterval(function(){ pThis._FlashTopBarFinish() },3000);
				}
			}
		},
		_FlashTopBarFinish:function()
		{
			timermanager.ClearInterval(g_FlashTopBarTimerId);
			XmpTopBar.Hide();
		},
		_UpdateByWindowTopmost:function()
		{
			if(DataCenter.WindowTopmostCurrent)
				{
					TopMostBtn.visible=true;
					NotTopMostBtn.visible=false;
				}
				else
				{
					TopMostBtn.visible=false;
					NotTopMostBtn.visible=true;
				}
		},
		_UpdateByWindowMode:function()
		{
			if(DataCenter.WindowMode==0)
				{
					FullScreenBtn.enable = true;
					NormalModeBtn.enable=false;
					MiniModeBtn.enable=true;
					
					TopBar_btnMin.visible = false;
					TopBar_btnClose.visible = false;
					TopBar_btnMin_Separator.visible = false;
					TopBar_btnClose_Separator.visible = false;
				}
				else if(DataCenter.WindowMode==1)
				{
					FullScreenBtn.enable = false;
					NormalModeBtn.enable=true;
					MiniModeBtn.enable=true;
					TopBar_btnMin.visible = false;
					TopBar_btnClose.visible = false;
					TopBar_btnMin_Separator.visible = false;
					TopBar_btnClose_Separator.visible = false;
				}
				else if(DataCenter.WindowMode==2)
				{
					FullScreenBtn.enable = true;
					NormalModeBtn.enable=true;
					MiniModeBtn.enable=false;
					TopBar_btnMin.visible = true;
					TopBar_btnClose.visible = true;
					TopBar_btnMin_Separator.visible = true;
					TopBar_btnClose_Separator.visible = true;
				}
				
				XmpTopBar.Hide();
		},
		OnLButtonDown:function(obj,wparam,lparam){
			if(DataCenter.WindowMode==2)
			XmpPlayer.OnTopbarLButtonDown(wparam,lparam);
		},
		OnMouseLeave:function(){
			XmpTopBar.Hide();
		},
		_UpdateTopbarSize:function()
		{
			Publisher.left = XmpTopBar.width - DataCenter.PublisherLen - 60 ;
			Publisher.width = DataCenter.PublisherLen + 10 ;
	
			PlayTitle_Publisher_Separator.left = XmpTopBar.width - DataCenter.PublisherLen - 65 ;
 
			PlayTitle.left = 105 ;
			if(DataCenter.PlayTitleLen > XmpTopBar.width - Publisher.width - 165)
 			{
 				PlayTitle.alignX="0" ;
 			}
 			else
			{
				PlayTitle.alignX="1" ;
			}
 		
			if(DataCenter.PlayTitleName == "" || DataCenter.PublisherName == "")
			{
				PlayTitle_Publisher_Separator.visible = false;
			}
			else
			{
				PlayTitle_Publisher_Separator.visible = true;
			}
 		},
		_OnUIClick:function(sName)
		{
			if(sName=="fullscreen")
			{
				XMP.globalEventSource.fireEvent("OnTopBarStatusChanged",0,0,0,0);
				XMP.globalEventSource.fireEvent("OnMiniCtrlBarStatusChanged",0,0,0,0);
				XMP.WindowMode.ChangeWindowMode(1);
			}
			else if(sName=="normalmode")
			{
				XMP.globalEventSource.fireEvent("OnTopBarStatusChanged",0,0,0,0);
				XMP.globalEventSource.fireEvent("OnMiniCtrlBarStatusChanged",0,0,0,0);
				XMP.WindowMode.ChangeWindowMode(0);
			}
			else if(sName=="minimode")
			{
				XMP.globalEventSource.fireEvent("OnTopBarStatusChanged",0,0,0,0);
				XMP.WindowMode.ChangeWindowMode(2);
			}
			else if(sName=="topmost")
			{
				XMP.WindowStatus.ChangeWindowStatus(0);
			}
			else if(sName=="nottopmost")
			{
				XMP.WindowStatus.ChangeWindowStatus(2);
			}
		}
	};
	
	view_TopBar.AttachEvent();
}