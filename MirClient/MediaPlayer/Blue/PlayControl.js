
with(XMP)
{
	
XMP.PlayControl = {
	CtrlPlay:function(){
		XmpPlayer.CtrlPlay();
	},
	CtrlPause:function(){
		XmpPlayer.CtrlPlay();
	},
	CtrlStop:function(){
		XmpPlayer.CtrlStop();
	},
	CtrlPrev:function(){
		XmpPlayer.CtrlPrev();
	},
	CtrlNext:function(){
		XmpPlayer.CtrlNext();
	},
	CtrlSound:function(){
		XmpPlayer.CtrlVolume(0);
		DataCenter.IsMute = true ;
		globalEventSource.fireEvent("OnSilentStatusChanged",DataCenter.IsMute);
	},
	CtrlSilence:function(){
		XmpPlayer.CtrlVolume(DataCenter.Volume);
		DataCenter.IsMute = false ;
		globalEventSource.fireEvent("OnSilentStatusChanged",DataCenter.IsMute);
	},
	CtrlOpen:function(){
		XmpPlayer.CtrlOpen();
	},
	CtrlOpenDVD:function(){
		DataCenter.DVDDriver = XmpPlayer.GetMediaInDVDDrivers();
		if(DataCenter.DVDDriver != "")
		{
			XmpPlayer.OpenDVDMedia(DataCenter.DVDDriver);
		}
	},
	CtrlSeek:function(nVal){
		XmpPlayer.CtrlSeek(nVal);
	},
	CtrlVolume:function(nVal){
		DataCenter.Volume = nVal ;
		globalEventSource.fireEvent("OnVolumeChanged",DataCenter.Volume);
		if(!DataCenter.IsMute)
		{
			XmpPlayer.CtrlVolume(nVal);
		}
	},
	CtrlVolumeUp:function()
	{
		DataCenter.Volume = parseInt(DataCenter.Volume)+5 ;
		if(DataCenter.Volume>100) DataCenter.Volume=100;
			
		XMP.PlayControl.CtrlVolume(DataCenter.Volume);
	},
	CtrlVolumeDown:function()
	{
		DataCenter.Volume = parseInt(DataCenter.Volume)-5 ;
		if(DataCenter.Volume<0) DataCenter.Volume=0;
			
		XMP.PlayControl.CtrlVolume(DataCenter.Volume);
	},
	CtrlSnapshot:function(val){
		XmpPlayer.SnapshotImg(val);
	}
};

//===================================================
//== 改变窗口模式
//== XMP.WindowMode.ChangeWindowMode(nScreenStatus) ;
//== XMP.WindowMode.UpdateWindowSize();
//=====================================================
XMP.WindowMode = {
		initUI:function(){  //根据 DataCenter.IsFirstInit 来判断是初始化，还是换肤后恢复现场
		},
		saveUI:function(){  //换肤之前保存现场
		},
		AttachEvent:function(){
			// Attach Event
			var sEvents=["onInitUI","onSaveUI","OnPlayStatusChanged","OnScreenStatusChanged"];
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
				if(DataCenter.WindowMode==0)
				{
					this._ToggleNormalImpl();
				}
				else if(DataCenter.WindowMode==1)
				{
					this._ToggleFullScreenImpl();
				}
				else if(DataCenter.WindowMode==2)
				{
					this._ToggleMiniImpl();
				}
				else if(DataCenter.WindowMode==-1)
				{
					this.UpdateWindowSize();
				}
			}
			else if(sEvent=="OnPlayStatusChanged")
			{
				if(DataCenter.PlayStatus==4/*STOP*/)
				{
					//this.ChangeWindowMode(0);
				}
				this.UpdateWindowSize();
			}
		},
  // 由界面发出的调用
	ChangeWindowMode:function(nStatus){ //0:普通 1:全屏 2:精简
		XmpPlayer.CmdScreenStatus(nStatus);
	},
	UpdateWindowSize:function()
	{
		
		if(DataCenter.WindowMode==0)
		{
			this._UpdateNormalSize();
		}
		else if(DataCenter.WindowMode==1)
		{
			this._UpdateFullScreenSize();
		}
		else if(DataCenter.WindowMode==2)
		{
			this._UpdateMiniSize();
		}
	},
	// 下面的函数，由状态事件调用
	_ToggleNormalImpl:function(){
		this._SaveVedioWndRect();		
		XLUIManager.Trace("_ToggleNormalImpl::savevediorect: left="+DataCenter.VedioWndLeft+",top="+DataCenter.VedioWndTop+",w="+DataCenter.VedioWndWidth+",h="+DataCenter.VedioWndHeight);
		XLUIManager.Trace("_ToggleNormalImpl::PreWindowMode="+DataCenter.PreWindowMode+",MainWndState="+DataCenter.MainWndState);
		if(DataCenter.PreWindowMode==1)
		{
			if(DataCenter.MainWndState==2)
			{
				XmpMainWnd.Restore();
				XmpMainWnd.Max();
			}
			else
			{
				XmpMainWnd.Restore();
			}
		}
		XmpMainWnd.MainPlane.visible = true;
		
		XmpMainWnd.minheight = 422 ;
		XmpMainWnd.minwidth = 606 ;
		if(DataCenter.IsListShow && DataCenter.IsExpandRightSide)
		{
			XmpMainWnd.minwidth = 778 ;
		}
		
		this._RestoreVedioWndRect();
		XmpMainWnd.Refresh();
		this._UpdateNormalSize();
		if(XmpMainWnd.top<0)
		{
			XmpMainWnd.Move(XmpMainWnd.left,0,XmpMainWnd.width,XmpMainWnd.height);
		}
	},
	_ToggleMiniImpl:function(){
		this._SaveVedioWndRect();	
		XLUIManager.Trace("_ToggleMiniImpl::savevediorect: left="+DataCenter.VedioWndLeft+",top="+DataCenter.VedioWndTop+",w="+DataCenter.VedioWndWidth+",h="+DataCenter.VedioWndHeight);
		XLUIManager.Trace("_ToggleMiniImpl::PreWindowMode="+DataCenter.PreWindowMode+",MainWndState="+DataCenter.MainWndState);
		
		if(DataCenter.PreWindowMode==0)
		{
			DataCenter.MainWndState = XmpMainWnd.windowstate;
		}
		
		if(DataCenter.PreWindowMode==1)
		{
			if(DataCenter.MainWndState==2)
			{
				XmpMainWnd.Restore();
				XmpMainWnd.Max();
			}
			else
			{
				XmpMainWnd.Restore();
			}
		}
		if(DataCenter.MainWndState == 2)
		{
			var left = XmpMainWnd.left ;
			var top = XmpMainWnd.top ;
			var width = XmpMainWnd.width ;
			var height = XmpMainWnd.height ;
			XmpMainWnd.Restore();
			XmpMainWnd.Move(left,top,width,height);
		}
		
		XmpMainWnd.MainPlane.visible = false;
				
		XmpMainWnd.minheight = 240 ;
		XmpMainWnd.minwidth = 320 ;
		
		this._UpdateMiniSize();
		this._RestoreVedioWndRect();
		this._UpdateMiniSize();
	},
	_ToggleFullScreenImpl:function(){
		if(XmpMainWnd.windowstate==3)
		{
			XmpMainWnd.Restore();
		}
		
		this._SaveVedioWndRect();	
		if(DataCenter.PreWindowMode==0)
		{
			DataCenter.MainWndState = XmpMainWnd.windowstate;
		}
		
		XmpMainWnd.MaxMax();
		XmpMainWnd.MainPlane.visible = true;
		this._UpdateFullScreenSize();
	},
	_SaveVedioWndRect:function(){
		if(DataCenter.PreWindowMode==0)
		{
			DataCenter.VedioWndLeft = parseInt(XmpPlayerContainer.left)+parseInt(XmpMainWnd.left);
			DataCenter.VedioWndTop = parseInt(XmpPlayerContainer.top)+parseInt(XmpMainWnd.top);
			DataCenter.VedioWndWidth = eval(XmpPlayerContainer.width);
			DataCenter.VedioWndHeight = eval(XmpPlayerContainer.height)-12/*播放时进度条的高度*/;
			
			if(DataCenter.IsListShow && DataCenter.IsExpandRightSide && DataCenter.CurTabName == "moviehall")
			{
				DataCenter.VedioWndWidth = parseInt(DataCenter.VedioWndWidth)- 172/*播放列表的宽度*/ ;
			}
			XLUIManager.Trace("DataCenter.VedioWnd::Save="+DataCenter.VedioWndLeft+",top="+DataCenter.VedioWndTop+",w="+DataCenter.VedioWndWidth+",h="+DataCenter.VedioWndHeight);
		}
		else if(DataCenter.PreWindowMode==2)
		{
			DataCenter.VedioWndLeft = parseInt(XmpPlayerContainer.left)+parseInt(XmpMainWnd.left);
			DataCenter.VedioWndTop = parseInt(XmpPlayerContainer.top)+parseInt(XmpMainWnd.top);
			DataCenter.VedioWndWidth = eval(XmpPlayerContainer.width);
			DataCenter.VedioWndHeight = eval(XmpPlayerContainer.height);
			
			XLUIManager.Trace("DataCenter.VedioWnd::Save="+DataCenter.VedioWndLeft+",top="+DataCenter.VedioWndTop+",w="+DataCenter.VedioWndWidth+",h="+DataCenter.VedioWndHeight);
		}
		XLUIManager.Trace("DataCenter.VedioWnd::IsListShow="+DataCenter.IsListShow+",IsExpandRightSide="+DataCenter.IsExpandRightSide);
	},
	_RestoreVedioWndRect:function()
	{
		if(DataCenter.WindowMode==0)
		{
			XLUIManager.Trace("DataCenter.VedioWnd::Restore="+DataCenter.VedioWndLeft+",top="+DataCenter.VedioWndTop+",w="+DataCenter.VedioWndWidth+",h="+DataCenter.VedioWndHeight);
			XLUIManager.Trace("DataCenter.VedioWnd::IsListShow="+DataCenter.IsListShow+",IsExpandRightSide="+DataCenter.IsExpandRightSide);
			var left = parseInt(DataCenter.VedioWndLeft) - g_PlayerContainerLeft - 1 ;
			var top = parseInt(DataCenter.VedioWndTop) - g_PlayerContainerTop - 1 ;
			var width = parseInt(DataCenter.VedioWndWidth) + 10 ;
			var height = parseInt(DataCenter.VedioWndHeight) + g_PlayerContainerHeightOffset + 12 ;
			
			if(DataCenter.IsListShow && DataCenter.IsExpandRightSide)
			{
				width = parseInt(width) + 172 ;
			}
			XLUIManager.Trace("DataCenter.VedioWnd::Restore,l="+left+",t="+top+",w="+width+",h="+height);
			
			if(XmpMainWnd.windowstate!=2)
			XmpMainWnd.Move(left,top,width,height);
		}
		else if(DataCenter.WindowMode==2)
		{
			XLUIManager.Trace("DataCenter.VedioWnd::Restore="+DataCenter.VedioWndLeft+",top="+DataCenter.VedioWndTop+",w="+DataCenter.VedioWndWidth+",h="+DataCenter.VedioWndHeight);
			var left = parseInt(DataCenter.VedioWndLeft) - 2 ;
			var top = parseInt(DataCenter.VedioWndTop) - 2 ;
			var width = parseInt(DataCenter.VedioWndWidth) + 6 ;
			var height = parseInt(DataCenter.VedioWndHeight) + 6 ;
			XLUIManager.Trace("DataCenter.VedioWnd::Restore,l="+left+",t="+top+",w="+width+",h="+height);
			XmpMainWnd.Move(left,top,width,height);
		}
	},
	_UpdateNormalSize:function()
	{
		if(DataCenter.DisableUpdateWindowSize) return ;
		
		XLUIManager.Trace("DisableUpdateWindowSize ,Update");
		
		XmpPlayer.MoveSearchEditCtrl(parseInt(XmpMainWnd.width)-g_SearchEditLeftOffset,g_SearchEditTop,g_SearchEditWidth,g_SearchEditHeight);
		
		XmpPlayer.PreShowPlaySlider(false);
			
		if(DataCenter.CurTabName == "play" && DataCenter.IsListShow && DataCenter.IsExpandRightSide)
		{
			XmpPlayerContainer.left = g_PlayerContainerLeft;
			XmpPlayerContainer.top = g_PlayerContainerTop;
			XmpPlayerContainer.width = "XmpMainWnd.width - g_PlayerContainerWidthOffset-172";
			XmpPlayerContainer.height = "XmpMainWnd.height - g_PlayerContainerHeightOffset";
			
			PlaylistViewContainer.left = "XmpMainWnd.width-175" ;
			PlaylistViewContainer.top = g_PlayerContainerTop ;
			PlaylistViewContainer.width = "170" ;
			PlaylistViewContainer.height = "XmpMainWnd.height - g_PlayerContainerHeightOffset";
			
			PlaylistViewContainer.visible = true ;
			
			PlaylistView.UpdateLayout();
			XmpPlayer.UpdateLayout();
		}
		else
		{
			XmpPlayerContainer.left = g_PlayerContainerLeft;
			XmpPlayerContainer.top = g_PlayerContainerTop;
			XmpPlayerContainer.width = "XmpMainWnd.width - g_PlayerContainerWidthOffset";
			XmpPlayerContainer.height = "XmpMainWnd.height - g_PlayerContainerHeightOffset";
			
			PlaylistViewContainer.left = "XmpMainWnd.width-175" ;
			PlaylistViewContainer.top = g_PlayerContainerTop ;
			PlaylistViewContainer.width = "0" ;
			PlaylistViewContainer.height = "XmpMainWnd.height - g_PlayerContainerHeightOffset";
			
			XmpPlayer.UpdateLayout();
		}
		
		var hallmode = XmpPlayer.IsMoviehallInPlayingMode() ;
		
		if(DataCenter.CurTabName == "play")
		{
			if((DataCenter.PlayStatus == 5 || DataCenter.PlayStatus == 6))
				XmpPlayer.PreShowPlaySlider(true);
		}
		else if(btnTabMovieHall.checked == true)
		{
			if(hallmode && (DataCenter.PlayStatus == 5 || DataCenter.PlayStatus == 6))	
				XmpPlayer.PreShowPlaySlider(true);
		}
	},
	_UpdateMiniSize:function()
	{		
		XmpPlayer.PreShowPlaySlider(false);
		XmpPlayerContainer.left = 3;
		XmpPlayerContainer.top = 3;
		XmpPlayerContainer.width = "XmpMainWnd.width - 6";
		XmpPlayerContainer.height = "XmpMainWnd.height - 6";
		
		XmpPlayer.UpdateLayout();
		
		PlaylistViewContainer.left = "XmpMainWnd.width-175" ;
		PlaylistViewContainer.top = g_PlayerContainerTop ;
		PlaylistViewContainer.width = "0" ;
		PlaylistViewContainer.height = "XmpMainWnd.height - g_PlayerContainerHeightOffset";
			
	},
	_UpdateFullScreenSize:function()
	{
		XmpPlayer.PreShowPlaySlider(false);
		XmpPlayerContainer.left = 0;
		XmpPlayerContainer.top = 0;
		XmpPlayerContainer.width = "XmpMainWnd.width";
		XmpPlayerContainer.height = "XmpMainWnd.height";
		
		PlaylistViewContainer.left = "XmpMainWnd.width-175" ;
			PlaylistViewContainer.top = g_PlayerContainerTop ;
			PlaylistViewContainer.width = "0" ;
			PlaylistViewContainer.height = "XmpMainWnd.height - g_PlayerContainerHeightOffset";
			
	}
};

//===================================================
//== 改变窗口Topmost状态
//== XMP.WindowStatus.ChangeWindowStatus(nTopmostStatus) ;
//=====================================================
XMP.WindowStatus = {
		initUI:function(){  //根据 DataCenter.IsFirstInit 来判断是初始化，还是换肤后恢复现场
			XLUIManager.Trace("XMP.WindowStatus.ChangeTopmostStatus = " + DataCenter.WindowTopMost);
			this.ChangeWindowStatus(DataCenter.WindowTopMost);
		},
		saveUI:function(){  //换肤之前保存现场
		},
		AttachEvent:function(){
			// Attach Event
			var sEvents=["onInitUI","onSaveUI","OnTopmostStatusChanged","OnPlayStatusChanged","OnScreenStatusChanged"];
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
			else if(sEvent=="OnTopmostStatusChanged" || sEvent=="OnPlayStatusChanged" || sEvent=="OnScreenStatusChanged")
			{
				this._UpdateWindowStatus();
			}
		},
	ChangeWindowStatus:function(nStatus) // 0:不在最前  1:播放时最前 2:总是最前
	{
		if (nStatus == 0)
	  {
	    XmpPlayer.CmdTopmostNever();
	  }
	  else if (nStatus == 1)
	  {
	    XmpPlayer.CmdTopmostPlaying();
	  }
	  else if (nStatus == 2)
	  {
	    XmpPlayer.CmdTopmostAlways();
	  }
	},
	_UpdateWindowStatus:function()
	{
		if(DataCenter.WindowMode==1)
		{
			this._ToggleTopMost();
		}
		else if(DataCenter.WindowTopMost==2)
		{
			this._ToggleTopMost();
		}
		else if(DataCenter.WindowTopMost==1 && DataCenter.PlayStatus==5)
		{
			this._ToggleTopMost();
		}
		else
		{
			this._ToggleNotTopMost();
		}
	},
	_ToggleTopMost:function()
	{
		if(XmpMainWnd.visible)
		XmpMainWnd.Show(true, true);
		XLUIManager.SetSkinManagerTopMost(true);
		DataCenter.WindowTopmostCurrent=true;
		globalEventSource.fireEvent("onTopmostChange",true);
	},
	_ToggleNotTopMost:function()
	{
		if(XmpMainWnd.visible)
		XmpMainWnd.Show(false, true);
		XLUIManager.SetSkinManagerTopMost(false);
		DataCenter.WindowTopmostCurrent=false;
		globalEventSource.fireEvent("onTopmostChange",false);
	}

};

XMP.DisplayMode = {
		AttachEvent:function(){
			// Attach Event
			var sEvents=["onDisplayRatioModChange","OnPlayStatusChanged"];
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
			if(sEvent=="onDisplayRatioModChange")
			{	
				this._updateVedioRect();
			}
			else if(sEvent=="OnPlayStatusChanged")
			{
				if(DataCenter.PlayStatus==5 && DataCenter.PrePlayStatus!=6)
					this._updateVedioRect();
			}
		},
		_updateVedioRect:function()
		{
			if(XmpPlayer.GetDisplayRatioMod()==1)
			{
				XMP.globalEventSource.fireEvent("OnTopBarStatusChanged",0,0,0,0);
				XMP.globalEventSource.fireEvent("OnMiniCtrlBarStatusChanged",0,0,0,0);
				
				var nVedioWidth = XmpPlayer.GetVideoWidth();
	      var nVedioHeight =  XmpPlayer.GetVideoHeight();
	       	  	
	      // 调整大小
	      if(DataCenter.WindowMode!=1/*全屏*/ && XmpMainWnd.windowstate!=2/*最大化*/)
	      {
	       	if(DataCenter.WindowMode==2/*mini*/)
					{
						XmpMainWnd.Move(XmpMainWnd.left, XmpMainWnd.top, nVedioWidth+6, nVedioHeight+6);
					}
					else if(DataCenter.WindowMode==0)
					{
						if( DataCenter.IsListShow && DataCenter.IsExpandRightSide )
							XmpMainWnd.Move(XmpMainWnd.left, XmpMainWnd.top, nVedioWidth+172+g_PlayerContainerWidthOffset, nVedioHeight+g_PlayerContainerHeightOffset+12);
						else
							XmpMainWnd.Move(XmpMainWnd.left, XmpMainWnd.top, nVedioWidth+g_PlayerContainerWidthOffset, nVedioHeight+g_PlayerContainerHeightOffset+12);
					}
	      }
	    }
		}
};

	WindowStatus.AttachEvent();
	WindowMode.AttachEvent();
	DisplayMode.AttachEvent();
}