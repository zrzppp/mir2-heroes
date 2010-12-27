with(XMP)
{
XMP.view_ExpandBar = {
		initUI:function(){  //根据 DataCenter.IsFirstInit 来判断是初始化，还是换肤后恢复现场
		},
		saveUI:function(){  //换肤之前保存现场
		},
		AttachEvent:function(){
			// Attach Event
			var sEvents=["onInitUI","onSaveUI","OnShowPlaylist","OnScreenStatusChanged","OnTabViewSelectChanged","OnExpandRightSideChanged"];
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
			else if(sEvent=="OnShowPlaylist" || sEvent=="OnScreenStatusChanged" || sEvent=="OnTabViewSelectChanged" || sEvent=="OnExpandRightSideChanged")
			{
				this._UpdateExpandBar();
			}
		},
		_UpdateExpandBar:function(bshow)
		{
			// DataCenter.IsListShow
			// DataCenter.IsExpandRightSide
			// DataCenter.WindowMode
			// DataCenter.CurTabName
			
			
			
			if(DataCenter.IsListShow && DataCenter.WindowMode==0 && (DataCenter.CurTabName == "play" || DataCenter.CurTabName == "moviehall"))
			{
				XmpExpandBar.Show(false,false);
				
				btnCollapes.visible=DataCenter.IsExpandRightSide;
				btnExpand.visible=!DataCenter.IsExpandRightSide;
				XLUIManager.Trace("JS::OnInit::PlaylistStatus:_UpdateExpandBar : Show");
			}
			else
			{
				XLUIManager.Trace("JS::OnInit::PlaylistStatus:_UpdateExpandBar : Hide");
				XmpExpandBar.Hide();
			}
		},
		_OnUIClick:function(sName)
		{
			if(sName=="openlist")
			{				
				PlaylistViewContainer.left = "XmpMainWnd.width-175" ;
			PlaylistViewContainer.top = g_PlayerContainerTop ;
			PlaylistViewContainer.width = "0" ;
			PlaylistViewContainer.height = "XmpMainWnd.height - g_PlayerContainerHeightOffset";
				if(XmpMainWnd.windowstate == 2)
					XmpPlayer.ExpandRightSide(true, true);
				else
					XmpPlayer.ExpandRightSide(true, false);
			}
			else if(sName=="closelist")
			{				
				PlaylistViewContainer.left = "XmpMainWnd.width-175" ;
			PlaylistViewContainer.top = g_PlayerContainerTop ;
			PlaylistViewContainer.width = "0" ;
			PlaylistViewContainer.height = "XmpMainWnd.height - g_PlayerContainerHeightOffset";
				if(XmpMainWnd.windowstate == 2)
					XmpPlayer.ExpandRightSide(false, true);
				else
					XmpPlayer.ExpandRightSide(false, false);
			}
		}
	};
	
	view_ExpandBar.AttachEvent();
}