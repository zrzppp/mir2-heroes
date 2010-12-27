
if(!XMP) //没有xmp表示不正常使用,直接异常
	debugger

XMP.view_XmpMainWnd={};
//XMP.view_XmpMainWnd.subView_MainPlane={};
//XLUIManager 全局单件
//DataCenter 全局单件
//原则上带_的函数为私有成员, 最后最终元素不带标识，其它容器性元素都带标识打头，如 _view_
with(XMP)
{
	
	XMP.view_XmpMainWnd={
			//这个做法是为了避免XML上UI改名时，需要改动太多
			//axXmpPlayer:XmpPlayer,	//全局activex
			//axXmpPlayerContainer:XmpPlayerContainer,
			//axXmpConfig:XmpConfig,
			//_XmpCaption:XmpCaption,
		//	_MaxBtn:MaxBtn,
		//	_RestroeBtn:RestroeBtn,			
		//	_view_XmpExpandBar:XmpExpandBar,			
			_saveXmpPosition:function (){
										//	DEBUG("_saveXmpPosition");
										XLUIManager.SaveParam("MainWndLeft", XmpMainWnd.left);
								    XLUIManager.SaveParam("MainWndTop", XmpMainWnd.top);
								    XLUIManager.SaveParam("MainWndWidth", XmpMainWnd.width);
								    XLUIManager.SaveParam("MainWndHeight", XmpMainWnd.Height);
										XLUIManager.SaveParam("MainWndState", XmpMainWnd.windowstate );
										
										XLUIManager.SaveParam("PlaylistSatus", DataCenter.IsListShow);
										XLUIManager.SaveParam("PlaylistExpandSatus", DataCenter.IsExpandRightSide);
										},		
			//给UI调用
			onMaximize:function(){
				DataCenter.IsMinimize = false ;
				DEBUG("onMaximize");
				//XMP.view_XmpMainWnd.subView_MainPlane._setNormalSize();
				XMP.WindowMode.UpdateWindowSize();
				MaxBtn.visible=false;
				RestroeBtn.visible=true;
				this._saveXmpPosition();
				if(DataCenter.ConfigWndVisible==1)
				{
					XmpConfigWnd.Show(XmpMainWnd,true);
				}
				else if(DataCenter.ConfigWndVisible==2)
				{
					XmpConfigWnd.Hide();
				}
				
				DataCenter.ConfigWndVisible = 0 ;
			},
			onMinimize:function(){		
				if(DataCenter.IsMinimize==true) return ;
				DataCenter.IsMinimize = true ;
				XLUIManager.Trace("XmpMainWnd::onMinimize start");
				DataCenter.ConfigWndVisible = XmpConfigWnd.visible?1:2 ;
				XmpConfigWnd.Hide();
				XLUIManager.Trace("XmpMainWnd::onMinimize end");
			},
			onRestore:function (){
				DataCenter.IsMinimize = false ;
				XLUIManager.Trace("XmpMainWnd::onRestore start");
				RestroeBtn.visible=false;
				MaxBtn.visible=true;
				if(DataCenter.ConfigWndVisible==1)
				{
					XmpConfigWnd.Show(XmpMainWnd,true);
				}
				else if(DataCenter.ConfigWndVisible==2)
				{
					XmpConfigWnd.Hide();
				}
				
				DataCenter.ConfigWndVisible = 0 ;
				XLUIManager.Trace("XmpMainWnd::onRestore end");
			},
			onSize:function()
			{
			},
			InitDataCenter:function(){
										DEBUG("InitDataCenter");
										if(DataCenter.IsLoaded)	return;
										DataCenter.IsLoaded = true;
										//================================
										
										DataCenter.IsFirstInit=true;   	// 判断是否第一次初始化
										DataCenter.Volume=50;					 	// 记录声音的大小
										DataCenter.IsMute=false;				// 判断是否静音，true表示静音
										DataCenter.WindowMode=0 ;				// 窗口模式，0:普通，...
										DataCenter.PreWindowMode=0;
										DataCenter.WindowTopMost=0;			// 0:不在最前 ，1:播放时最前 ，2:总是最前
										DataCenter.WindowTopmostCurrent=false;
										DataCenter.MainWndState=0;			// 主窗口的状态，最大化/最小化/正常/...
										DataCenter.PlayStatus=0;				// 播放状态
										DataCenter.PrePlayStatus=0;
										DataCenter.FilmDuration=100;
										DataCenter.PlayProgress=0;
										DataCenter.DownloadProgress=0;
										DataCenter.BufferProgress=0;
										DataCenter.AutoShutdownStatus=0;
										DataCenter.RecordStatus=0;
										DataCenter.TitleName="" ;
										DataCenter.TitleLen = 0 ;
										DataCenter.PlayTitleName="" ;
										DataCenter.PlayTitleLen=0;
										DataCenter.PublisherName="" ;
										DataCenter.PublisherLen=0;
										DataCenter.BitRate=0;
										DataCenter.IsListShow = true ;
										DataCenter.IsExpandRightSide = true;
										DataCenter.PreIsListShow = true ;
										DataCenter.PreIsExpandRightSide = true;
										DataCenter.VedioWndLeft=0;					// 窗口模式进行切换，保持视频窗口大小不变
										DataCenter.VedioWndTop=0;
										DataCenter.VedioWndWidth=0;
										DataCenter.VedioWndHeight=0;
										DataCenter.LastTabName1 = "play";
										DataCenter.LastTabName2 = "play";
										DataCenter.CurTabName = "play";
										DataCenter.SkinMgrWnd=0;
										DataCenter.DVDDriver="";
										DataCenter.MoviehallVisible=false;
										DataCenter.SearchVisible=false;
										DataCenter.MovieHallID = "";
										DataCenter.ShowTimeType = 0;
										DataCenter.TrackStatus = 0 ;
										DataCenter.RecordFlag = 0 ;
										DataCenter.Windowtext = "迅雷看看播放器" ;
										DataCenter.arrPlayRecord = [] ;
										DataCenter.ConfigWndVisible = 0 ;
										DataCenter.DisableUpdateWindowSize=false ;
										DataCenter.BossStatus=false;
										DataCenter.IsFirstShowlist=true ;
										DataCenter.IsFirstExpandlist=true;
										DataCenter.TrayStatus=false;
									},
		InitXmpPlayer:function(){
										DEBUG("InitXmpPlayer");
									},
		ResizeXmpPlayer:function(){
										DEBUG("ResizeXmpPlayer");
										//
									  if(parseInt(XmpMainWnd.width) - 250 > parseInt(DataCenter.WindowtextLen))
								  		XmpCaption.alignX = "1";
								  	else
								  		XmpCaption.alignX = "0";
								  	XmpExpandBar.SetParent(XmpMainWnd);
										XmpExpandBar.Move(parseInt(XmpMainWnd.width) - 6, parseInt(XmpMainWnd.height)/2 - 12, 4, 25);
										XMP.WindowMode.UpdateWindowSize();
									},
		OnRClick:function(obj,wparam,lparam){
										XMP.view_XmpMainWnd.subView_MainPlane.OnRClick(obj,wparam,lparam);
									},
		Quit:function(){
										XMP.view_XmpMainWnd.subView_MainPlane._quit();
									}
		};
	
			
	XMP.view_XmpMainWnd.subView_MainPlane={
	//axXmpPlayer:XmpPlayer,	//全局activex
	//axXmpPlayerContainer:XmpPlayerContainer,
	//axXmpConfig:XmpConfig,
	//_view_XmpSkinMgrHost:XmpSkinMgrHost,
	//parent:XmpMainWnd,
		//_volSlider:volSlider,
		//_btnTabPlay:btnTabPlay,
		//_btnTabMovieHall:btnTabMovieHall,
		//_btnTabMovieHallClose:btnTabMovieHallClose,
		//_btnTabSearch:btnTabSearch,
		//_btnTabSearchClose:btnTabSearchClose,
		//_btnShowPlaylist:btnShowPlaylist,
		//_btnHidePlaylist:btnHidePlaylist,
		attachEvent:function(){
			// Attach Event
			var sEvents=["onInitUI","onSaveUI","OnBosskey","OnTitleChanged","OnResizePlaySilder","OnTabViewSelectChanged","OnShowPlaylist","OnExpandRightSideChanged","OnTabViewAddRemoveChanged","OnScreenStatusChanged","OnPlayStatusChanged","OnFilmDurationChanged","OnPlayProgressChanged","OnDownloadProgressChanged","OnBufferProgressChanged","OnSilentStatusChanged","OnVolumeChanged","OnPlayBarStatusChanged","OnBitRateChanged"];
			for(var i = 0; i<sEvents.length; i++)
			{
				var pThis=this;		 
				globalEventSource.attachEvent(this, sEvents[i] ,function(){					 
					var args =  argumentsToArray(arguments).slice(1);
					pThis.OnXMPEvent.apply(pThis, args);				 
					});			  
			}		
		},
		_UpdateSnapshotBtn:function()
		{
			if(DataCenter.CurTabName == "play" && (DataCenter.PlayStatus==5||DataCenter.PlayStatus==6) && XmpPlayer.IsSnapShotable() )
			{
				btnSnapshot.enable = true ;
			}
			else
			{
				btnSnapshot.enable = false ;
			}
		},
		InsertTab:function(tabname){
								var start = g_InsetTabStartOffset;
								if(tabname == "search")
								{		
									var bVisible = btnTabMovieHall.visible;
									btnTabSearch.left = start;
									btnTabSearchClose.left = start + g_SearchCloseOffset;
									if(bVisible)
									{
										btnTabSearch.left = parseInt(btnTabSearch.left) + parseInt(btnTabMovieHall.width) + g_TabDistance;
										btnTabSearchClose.left = parseInt(btnTabSearchClose.left) + parseInt(btnTabMovieHall.width) + g_TabDistance;
									}
							
									btnTabSearch.visible = true;
									btnTabSearchClose.visible = true;
							    btnTabMovieHallClose.visible = false;
								}
								else if(tabname == "moviehall")
								{
									var bVisible = btnTabSearch.visible;
									btnTabMovieHall.left = start;
									btnTabMovieHallClose.left = start + g_MovieHallCloseOffset;
									moviehallid.left = start + g_MoviehallIDOffset;
									if(bVisible)
									{
										//btnTabMovieHall.left = parseInt(btnTabMovieHall.left) + parseInt(btnTabSearch.width);
										//btnTabMovieHallClose.left = parseInt(btnTabMovieHallClose.left) + parseInt(btnTabSearch.width);
										//moviehallid.left = parseInt(moviehallid.left) + parseInt(btnTabSearch.width);
										
										XLUIManager.Trace("MoveTabSearch from : " + btnTabSearch.left);
										
										btnTabSearch.left = parseInt(btnTabSearch.left) + parseInt(btnTabMovieHall.width) + g_TabDistance ;
									  btnTabSearchClose.left = parseInt(btnTabSearchClose.left) + parseInt(btnTabMovieHall.width) + g_TabDistance;
									  
									  XLUIManager.Trace("MoveTabSearch to : " + btnTabSearch.left);
									}
									moviehallid.visible = true;
									btnTabMovieHall.visible = true;	
									btnTabMovieHallClose.visible = true;
									btnTabSearchClose.visible = false;
								}
							},							
		_UpdateWindowModeBtn:function()
		{
			var bCanSwitch = false ;
			if(DataCenter.CurTabName == "play")
			{
				if((DataCenter.PlayStatus == 3 || DataCenter.PlayStatus == 5 || DataCenter.PlayStatus == 6))
				{
					bCanSwitch = true;
				}
			}
			else if(btnTabMovieHall.checked == true)
			{
				if(XmpPlayer.IsMoviehallInPlayingMode())	
				{
					bCanSwitch= true;
				}
			}
			
			if(!bCanSwitch)
			{
				// 全部Disable
				btnFullScreenSwitch.enable=0 ;
			}
			else
			{
				btnFullScreenSwitch.enable=1 ;
			}
		},
		CloseTab:function(tabname){
							var start = g_InsetTabStartOffset;
							if(tabname == "search")
							{
								XLUIManager.Trace("CloseTab() : search");
								btnTabSearch.visible = false;
								btnTabSearchClose.visible = false;	
							//	var bVisible = btnTabMovieHall.visible;
							//	if(bVisible)
							//		btnTabMovieHall.left = start;
							XmpPlayer.ClearSearchEdit();
							XLUIManager.Trace("OutputTab::CloseTab:Start: cur="+DataCenter.CurTabName+",last1="+DataCenter.LastTabName1+",last2="+DataCenter.LastTabName2);
							DataCenter.CurTabName = DataCenter.LastTabName1 ;
							DataCenter.LastTabName1 = DataCenter.LastTabName2 ;
							DataCenter.LastTabName2 = "play" ;
							XLUIManager.Trace("OutputTab::CloseTab:end: cur="+DataCenter.CurTabName+",last1="+DataCenter.LastTabName1+",last2="+DataCenter.LastTabName2);
							this._SwitchTab(DataCenter.CurTabName);
						
							}
							else if(tabname == "moviehall")
							{
								XLUIManager.Trace("CloseTab() : moviehall");
								btnTabMovieHall.visible = false;	
								btnTabMovieHallClose.visible = false;
								moviehallid.visible = false;
								var bVisible = btnTabSearch.visible;
								if(bVisible)
								{
									btnTabSearch.left = start;
									btnTabSearchClose.left = start + g_SearchCloseOffset;
								}
								
								if(DataCenter.LastTabName2 == "theater")
								{
									DataCenter.CurTabName = "theater" ;
									DataCenter.LastTabName2 = DataCenter.LastTabName1 ;
									DataCenter.LastTabName1 = "play" ;
								}
								else if(DataCenter.LastTabName1 == "theater")
								{
									DataCenter.CurTabName = "theater" ;
									DataCenter.LastTabName1 = "play" ;
								}
								else
								{
									DataCenter.CurTabName = "theater" ;
								}
									
								this._SwitchTab(DataCenter.CurTabName);
							}
							
						},
		ShowFullScreenBtn:function(bShow){
										},
		EnableShowListBtn:function(bEnable){
													btnShowPlaylist.enable = bEnable ;
													btnHidePlaylist.enable = bEnable ;												
										},
										
		ShowOpenBtn:function (benable){
									benable = true ;
									btnOpen.enable = benable ;
								},
									
		ChangeMF_BK:function (index){
									var strbk ;
									if(index==1)
									{
										strbk = "$MF_Bk.bmp" ;
									}
									else
									{
										strbk = "$MF_Bk2.bmp" ;
									}
									
									XmpMainWnd.BeginChangeBkImage();
									{
											XmpMainWnd.CImg = strbk;
									}
									XmpMainWnd.EndChangeBkImage();
								},
		ChangePlaylistButtonState:function (){
																if(DataCenter.IsListShow)
																{
																		btnHidePlaylist.visible = true;
																		btnShowPlaylist.visible = false;
																}
																else
																{
																		btnHidePlaylist.visible = false;
																		btnShowPlaylist.visible = true;
																}
															},	
		ExpandRightSideImpl:function (bExpand){
													XLUIManager.Trace("ExpandRightSideImpl:" + bExpand+",PreIsListShow="+DataCenter.PreIsListShow+",PreExpandRightSide="+DataCenter.PreIsExpandRightSide+",IsListShow="+DataCenter.IsListShow+",ExpandRightSide="+DataCenter.IsExpandRightSide);
													//DataCenter.DisableUpdateWindowSize=true;
													//
													var sidewidth = 172;
													var minwidthNoList = 606;
													var minWidthList = parseInt(minwidthNoList) + parseInt(sidewidth) ;
													var width = parseInt(XmpMainWnd.width) ;
													if(bExpand)
													{
														if(!(DataCenter.PreIsListShow && DataCenter.PreIsExpandRightSide))
														{
															//if(!DataCenter.IsFirstExpand)
																width += sidewidth ;
														}
														
														if(XmpMainWnd.windowstate != 2)
															XmpMainWnd.Move( XmpMainWnd.left, XmpMainWnd.top, width, XmpMainWnd.height);	
														XmpMainWnd.minwidth = minWidthList;		
													}
													else
													{
														if(DataCenter.PreIsListShow && DataCenter.PreIsExpandRightSide)
														{
															//if(!DataCenter.IsFirstExpand)
																width -= sidewidth ;
														}
														
														XmpMainWnd.minwidth = minwidthNoList;	
														if(XmpMainWnd.windowstate != 2)
															XmpMainWnd.Move( XmpMainWnd.left, XmpMainWnd.top, width, XmpMainWnd.height);
													}
													
													//DataCenter.IsFirstExpand = false ;
													DataCenter.DisableUpdateWindowSize=false;
													XLUIManager.Trace("DisableUpdateWindowSize = false");
													XMP.WindowMode.UpdateWindowSize();
													//this._setNormalSize();
												},														
		OnXMPEvent:function(sEvent,param1,param2,param3){
								if(sEvent=="onInitUI")
								{	
									this.initUI();
								}
								else if(sEvent=="onSaveUI")
								{
									this.saveUI();
								}					
								else if(sEvent=="OnBosskey")
								{
									if(DataCenter.BossStatus)
									{
										// 恢复之前状态
										traymanager._maintray.visible=true;
										//traymanager._maintray.visible=DataCenter.BossTrayVisible;
										XmpPlayer.LevelBossStatus();
								/*		if(DataCenter.BossMainWndVisible)
											XmpMainWnd.Show(DataCenter.WindowTopmostCurrent,true);		
										if(DataCenter.BossConfigWndVisible)
											XmpConfigWnd.Show(XmpMainWnd,true);				*/			
									}
									else
									{
										// 进入老板状态
										if(DataCenter.PlayStatus==5/*Playing*/)
										{
											XMP.PlayControl.CtrlPause();
										}
										XmpPlayer.EnterBossStatus();
										traymanager._maintray.visible=false;
										/*
										DataCenter.BossMainWndVisible = XmpMainWnd.visible ;
										DataCenter.BossConfigWndVisible = XmpConfigWnd.visible ;
										DataCenter.BossTrayVisible = traymanager._maintray.visible ;
										
										traymanager._maintray.visible=false;
										XmpMainWnd.Hide();
										XmpConfigWnd.Hide();*/
									}
									
									DataCenter.BossStatus = !DataCenter.BossStatus;
								}
								else if(sEvent=="OnPlayStatusChanged")
								{
									if(DataCenter.PlayStatus==5)
									{
										DataCenter.ShowTimeType = XmpPlayer.GetShowTimeType();
										
										if(DataCenter.BossStatus) XMP.PlayControl.CtrlPause();
									}
									
									this._UpdateSnapshotBtn();
									this._updateByPlayStatus();
									this._UpdateWindowModeBtn();
								}
								else if(sEvent=="OnFilmDurationChanged")
								{
									if(DataCenter.FilmDuration!=0)
									{
										playSlider.maxvalue = DataCenter.FilmDuration;
					    			bufferProgressBar.maxvalue = DataCenter.FilmDuration;    
					    		}
					    		//PlayTimePanel.text = this._TranslateTime(DataCenter.PlayProgress) + "/" + this._TranslateTime(DataCenter.FilmDuration);     
					    		this._UpdatePlayTimePanel();
								}
								else if(sEvent=="OnPlayProgressChanged")
								{
									//PlayTimePanel.text = this._TranslateTime(DataCenter.PlayProgress) + "/" + this._TranslateTime(DataCenter.FilmDuration);     
									this._UpdatePlayTimePanel();
									playSlider.value = DataCenter.PlayProgress; 
								}
								else if(sEvent=="OnDownloadProgressChanged")
								{
									bufferProgressBar.value = DataCenter.DownloadProgress;
								}
								else if(sEvent=="OnTabViewAddRemoveChanged")
								{
									var badd=param1;
									var label=param2;
									var mhallid=param3;
									if(badd)
									{
										this.InsertTab(label);
										if(label == "moviehall")
										{
											moviehallid.text = mhallid;	
											DataCenter.MovieHallID = moviehallid.text;
										}
									}
									else
									{
										this.CloseTab(label);
									}
								}
								else if(sEvent=="OnTabViewEnableChanged")
								{
									var enable=param1;
									 if(enable == 0)
								    {
								        // FALSE
								        btnTabPlay.enable = false;
								        btnTabSearch.enable = false;
								        btnTabClassical.enable = false;
								        btnTabTheater.enable = false;
								    } 
								    else
								    {
								        // TRUE
								        btnTabPlay.enable = true;
								        btnTabSearch.enable = true;
								        btnTabClassical.enable = true;
								        btnTabTheater.enable = true;
								    }
								}
								else if(sEvent=="OnTabViewSelectChanged")
								{
									var labelname=param1;
									this._UpdateWindowModeBtn();
									
									btnTabMovieHallClose.visible = false;
									btnTabSearchClose.visible = false;
							    
							    XLUIManager.Trace("OnTabViewSelectChanged::CurTabName = "+DataCenter.CurTabName + ",last1="+DataCenter.LastTabName1+",last2="+DataCenter.LastTabName2);							    
							    switch(labelname)
							    {
							        case "play":
							            btnTabPlay.checked = true;
							            this.ShowFullScreenBtn(true);
							            this.EnableShowListBtn(true);
							            this.ShowOpenBtn(true);
							            //this.ShowExpandBar(true);
							            this.ChangeMF_BK(1);
							            break;
							         case "classical":
							            btnTabClassical.checked = true;
							            this.ShowFullScreenBtn(false);
							            this.EnableShowListBtn(false);
							            this.ShowOpenBtn(true);
							            //this.ShowExpandBar(false);
							            this.ChangeMF_BK(2);
							            break;
							        case "theater":
							            btnTabTheater.checked = true;
							            this.ShowFullScreenBtn(false) ;
							            this.EnableShowListBtn(false);
							            this.ShowOpenBtn(true);
							            //this.ShowExpandBar(false);
							            this.ChangeMF_BK(2);
							            break;
											case "search":
													if(!btnTabSearch.visible)
														this.InsertTab("search");
							       			btnTabSearch.checked = true;
							       			this.ShowFullScreenBtn(false) ;
							       			this.EnableShowListBtn(false);
							       			this.ShowOpenBtn(true);
							       			//this.ShowExpandBar(false);
							       			this.ChangeMF_BK(2);
							       			btnTabMovieHallClose.visible = false;
													btnTabSearchClose.visible = true;
							       			break;
							       	case "moviehall":
													if(!btnTabMovieHall.visible)
														this.InsertTab("moviehall");
							       			btnTabMovieHall.checked = true;
							       			this.EnableShowListBtn(true);
							       			this.ShowOpenBtn(false);
							       			//this.ShowExpandBar(true);
							       			this.ChangeMF_BK(2);
							       			btnTabMovieHallClose.visible = true;
													btnTabSearchClose.visible = false;
							        		break;
							    }
									XLUIManager.Trace("OnTabViewSelectChanged ..... ");	
									XLUIManager.Trace(labelname);
									this._UpdateSnapshotBtn();
									XMP.WindowMode.UpdateWindowSize();
							    //this._setNormalSize();								
								}
								else if(sEvent=="OnBufferProgressChanged")
								{
									if(DataCenter.BufferProgress == 100)
							    {
							        btnPause.enable  = true; 				  
							        //PlayTimePanel.text = this._TranslateTime(DataCenter.PlayProgress) + "/" + this._TranslateTime(DataCenter.FilmDuration);     
							        this._UpdatePlayTimePanel();
							    }
							    else
							    {		        
							       	btnPause.enable = false;       
							       	this._UpdatePlayTimePanel(); 
							        //PlayTimePanel.text = "正在缓冲(" + DataCenter.BufferProgress + "%)";
							    }
								}/*
								else if(sEvent=="OnPlayBarStatusChanged")
								{
									
								}*/
								/*
								else if(sEvent=="OnAutoShutdownStatusChanged")
								{
									
								}	*/							
								else if(sEvent=="OnSilentStatusChanged")
								{
									btnSound.visible = !DataCenter.IsMute;
					    		btnSilence.visible = DataCenter.IsMute;
								}/*
								else if(sEvent=="OnAddRecentFile")
								{
									
								}
								else if(sEvent=="OnTopmostStatusChanged")
								{
									var status=param1;
								  if (status == 0)
								  {
									  DataCenter.IsMainWndTop = false ;
								    XmpMainWnd.Show(false, true);
										XLUIManager.SetSkinManagerTopMost(false);
								    
								    TopMostBtn.visible = false ;
								    NotTopMostBtn.visible = true ;
								  }
								  else if (status == 1)
								  {
								    if(DataCenter.PlayStatus == 5)
									  {
											DataCenter.IsMainWndTop = true ;
								    	XmpMainWnd.Show(true, true);
											XLUIManager.SetSkinManagerTopMost(true);
									  }
								  }
								  else if (status == 2)
								  {
									  DataCenter.IsMainWndTop = true ;
								    XmpMainWnd.Show(true, true);
										XLUIManager.SetSkinManagerTopMost(true);
								    
								    TopMostBtn.visible = true ;
								    NotTopMostBtn.visible = false ;
								  }
								   DataCenter.TopMost = status;
									
								}
								else if(sEvent=="OnAdjustRecentFile")
								{
								}
								else if(sEvent=="OnClearRecentFiles")
								{
								}*//*
								else if(sEvent=="OnRecordStatusChanged")
								{
								}
								else if(sEvent=="OnPopupVideoWndMenu")
								{
								}*/
								else if(sEvent=="OnTitleChanged")
								{
									var newTitle=param1;
									var len=param2;									
									XLUIManager.Trace("OnTitleChanged" + newTitle);
									DataCenter.Windowtext = newTitle ;
									DataCenter.WindowtextLen = global.GetStringWidth(newTitle, "$system.title.default");
							    XmpMainWnd.windowtext = newTitle; 
							    if(parseInt(XmpMainWnd.width) - 250 > parseInt(DataCenter.WindowtextLen))
							    	XmpCaption.alignX = "1";
							    else
							    	XmpCaption.alignX = "0";
							
							    if(newTitle == "迅雷看看播放器")
							      XmpCaption.text = "";
							    else
							    	XmpCaption.text = newTitle;
								}
								else if(sEvent=="OnScreenStatusChanged")
								{
									if(DataCenter.WindowMode==0)
									{
										XmpMainWnd.usekeycolor = true;
										XmpMainWnd.BeginChangeBkImage();
										{
											XmpMainWnd.LTImg = "$MF_LeftTop.bmp";
											XmpMainWnd.TImg  = "$MF_Top.bmp";
											XmpMainWnd.RTImg = "$MF_RightTop.bmp";
											
											XmpMainWnd.LImg  = "$MF_Left.bmp";
											XmpMainWnd.RImg  = "$MF_Right.bmp";
											
											XmpMainWnd.LBImg = "$MF_LeftBottom.bmp";
											XmpMainWnd.BImg  = "$MF_Bottom.bmp";
											XmpMainWnd.RBImg = "$MF_RightBottom.bmp";
										}
										XmpMainWnd.EndChangeBkImage();
									}
									else if(DataCenter.WindowMode==2)
									{
										XmpMainWnd.usekeycolor = false;
										XmpMainWnd.BeginChangeBkImage();
										{
											XmpMainWnd.LTImg = "$MNF_LeftTop.bmp";
											XmpMainWnd.TImg  = "$MNF_TopBottom.bmp";
											XmpMainWnd.RTImg = "$MNF_RightTop.bmp";
											
											XmpMainWnd.LImg  = "$MNF_LeftRight.bmp";
											XmpMainWnd.RImg  = "$MNF_LeftRight.bmp";
											
											XmpMainWnd.LBImg = "$MNF_LeftBottom.bmp";
											XmpMainWnd.BImg  = "$MNF_TopBottom.bmp";
											XmpMainWnd.RBImg = "$MNF_RightBottom.bmp";
										}
										XmpMainWnd.EndChangeBkImage();
									}
								}								
								else if(sEvent=="OnVolumeChanged")
								{
									volSlider.value = DataCenter.Volume;
								}/*
								else if(sEvent=="OnTopBarStatusChanged")
								{
								}
								else if(sEvent=="OnMiniCtrlBarStatusChanged")
								{
								}*//*
								else if(sEvent=="OnPlayTitleChanged")
								{
								}
								else if(sEvent=="OnPublisherChanged")
								{
								}*/
								else if(sEvent=="OnBitRateChanged")
								{
									var bitRate = "";
						
									if(DataCenter.PlayStatus == 3 || DataCenter.PlayStatus == 5)
										bitRate = parseInt(DataCenter.BitRate/1024) + "KB/S";
										
									if(DataCenter.BitRate==0)
										BitRatePanel.text = "";
									else
										BitRatePanel.text = bitRate;
								}
								else if(sEvent=="OnShowPlaylist")
								{
									var bshow=param1;
									
									this.ChangePlaylistButtonState();
									
									//this.ShowExpandBar(bshow);	
									if(bshow || (!bshow && DataCenter.IsExpandRightSide) )
									{
											this.ExpandRightSideImpl(bshow);
									}
								}/*
								else if(sEvent=="OnMenuHotkeyChanged")
								{
								}*/
								else if(sEvent=="OnExpandRightSideChanged")
								{
										this.ExpandRightSideImpl(arguments[1]);	
								}/*
								else if(sEvent=="OnShowMessageBox")
								{
								}*/
								else if(sEvent=="OnResizePlaySilder")
								{
									var width = arguments[1];
									playSlider.width =  width - 10 ;
									bufferProgressBar.width = width - 10 ;
									SeekBk.width = width ;
								}/*
								else if(sEvent=="OnShowAutoShutDownMsgBox")
								{
								}*/
								/*
								else if(sEvent=="OnBrightSetableChange")
								{
								}*/
										
							},
		_updateByPlayStatus:function(){
												switch (DataCenter.PlayStatus)
										    {
										    case 0:	
										        //PS_NONE
										         break;
										    case 1:
										    //PS_READY
										        btnStop.enable   = false;
										        btnPause.visible = false;
										        btnPlay.visible  = true;
										        btnPlay.enable   = true;
										        playSlider.enable = true;//false;
														bufferProgressBar.visible = false;
										 
										        BitRatePanel.text = "";
										       // PlayTimePanel.text = "";
										        break;
										    case 2:
										    //PS_STARTDOWNLOAD
										        btnPlay.enable = false;
										        playSlider.enable = true;//false;
										        btnStop.enable = true;
														bufferProgressBar.visible = true;
										        break;        
										    case 3:
										    //PS_OPENING
														XLUIManager.Trace("OnPlayStatusChanged() : PS_OPENING");
										        btnPlay.enable = false;
										        playSlider.enable = true;//false;
														btnStop.enable = true;
														bufferProgressBar.visible = true;
										
														BitRatePanel.text = "";
										       // PlayTimePanel.text = "";
										        
										        break;
										
										    case 4:   
										    //PS_STOPED    
										        btnPause.visible = false;
										        btnPlay.visible  = true;
										        btnPlay.enable = true;
										        btnStop.enable   = false;
										        playSlider.enable = true;//false;
														bufferProgressBar.visible = false;										        
										        BitRatePanel.text = "";
										       // PlayTimePanel.text = "已停止";
										        break;										
										    case 5: 
										    //PS_PLAYING
										        btnStop.enable   = true;
										        btnPlay.visible  = false;
										        btnPause.visible = true;
										        btnPause.enable  = true;                 
										        playSlider.enable = true;       
														bufferProgressBar.visible = true;
										        break;
										    case 6:
										    //PS_PAUSED
										        btnPause.visible = false;
										        btnPlay.visible  = true;
										        btnPlay.enable = true;
										        BitRatePanel.text = "";        
										        //PlayTimePanel.text = "已暂停";
										        break;										
										    } 
										    
										    this._UpdatePlayTimePanel();
											},
		initUI:function(){  //根据 DataCenter.IsFirstInit 来判断是初始化，还是换肤后恢复现场	    
	    //XmpPlayer.UpdateLayout();
	    
			this._UpdateSnapshotBtn();
			this._UpdateWindowModeBtn();
			
			this._UpdateVolumeStatus();
			if(!DataCenter.IsFirstInit)
			{		
				if(DataCenter.FilmDuration!=0)
				{
					playSlider.maxvalue = DataCenter.FilmDuration; 
    			bufferProgressBar.maxvalue = DataCenter.FilmDuration;  
    		}
    		//PlayTimePanel.text = this._TranslateTime(DataCenter.PlayProgress) + "/" + this._TranslateTime(DataCenter.FilmDuration);
    		this._UpdatePlayTimePanel();
    		
    		bufferProgressBar.value = DataCenter.DownloadProgress; 
    		btnSound.visible = !DataCenter.IsMute;
    		btnSilence.visible = DataCenter.IsMute;  
    		volSlider.value = DataCenter.Volume;
    		
    		var bitRate = "";
	
				if(DataCenter.PlayStatus == 3 || DataCenter.PlayStatus == 5)
					bitRate = parseInt(DataCenter.BitRate/1024) + "KB/S";
					
				if(DataCenter.BitRate==0)
					BitRatePanel.text = "";
				else
					BitRatePanel.text = bitRate;
				
				XMP.globalEventSource.fireEvent("OnTitleChanged",DataCenter.Windowtext, 0);
				
				moviehallid.text = DataCenter.MovieHallID;
				 if( DataCenter.SearchVisible )
				 		XMP.globalEventSource.fireEvent("OnTabViewSelectChanged","search");
				 if( DataCenter.MoviehallVisible)
				 		XMP.globalEventSource.fireEvent("OnTabViewSelectChanged","moviehall");
				 XMP.globalEventSource.fireEvent("OnTabViewSelectChanged",DataCenter.CurTabName);
				this._SwitchTab(DataCenter.CurTabName);
				
				this.ChangePlaylistButtonState();
				
				if(DataCenter.PlayStatus == 2 || DataCenter.PlayStatus == 3 || DataCenter.PlayStatus == 5 || DataCenter.PlayStatus == 6)
				{
					btnStop.enable   = true;
				}
				
				this._updateByPlayStatus();
				
				XmpSkinMgrHost.DoModal(XmpMainWnd);
			}
			
			XLUIManager.Trace("NSkin::OnInit step 4");
		 
		},
		saveUI:function(){  //换肤之前保存现场								
						XMP.view_XmpMainWnd._saveXmpPosition();
					  XLUIManager.SaveParam("Volume", DataCenter.Volume);
			    	XLUIManager.SaveParam("Mute", DataCenter.IsMute);			
			    	
			    	DataCenter.MoviehallVisible=btnTabMovieHall.visible;
						DataCenter.SearchVisible=btnTabSearch.visible;	
					},
		_TranslateTime:function(nTime)
		{
			var nSecond = Number(nTime);
	    nSecond = nSecond / 1000;
	    
	    var nHour = parseInt(nSecond / 3600);
	    nSecond = nSecond % 3600;
	    var nMinute = parseInt(nSecond / 60);
	    nSecond = parseInt(nSecond % 60);
	    
	    var sOut;
	    if(nHour >= 10) sOut = nHour;
	    else sOut = "0" + nHour;
	    if(nMinute >= 10) sOut = sOut + ":" + nMinute;
	    else sOut = sOut + ":0" + nMinute;
	    if(nSecond >= 10) sOut = sOut + ":" + nSecond;
	    else sOut = sOut + ":0" + nSecond;
	    	
	    return sOut;  
		},
		_UpdatePlayTimePanel:function()
		{
			XLUIManager.Trace("_UpdatePlayTimePanel : PlayStatus="+DataCenter.PlayStatus);
			
			switch(DataCenter.PlayStatus)
			{
				case 4:
					{
						PlayTimePanel.text = "已停止" ;
					}
					break;
				case 5:
					{
						if(XmpPlayer.GetPlayStatusFlag() & 0x4)
							PlayTimePanel.text = "正在缓冲(" + DataCenter.BufferProgress + "%)";
						else
						{
							if(DataCenter.ShowTimeType==0)
								PlayTimePanel.text = this._TranslateTime(DataCenter.PlayProgress) + "/" + this._TranslateTime(DataCenter.FilmDuration);
							else
								PlayTimePanel.text = DataCenter.PlayProgress + "/" + DataCenter.FilmDuration ;
						}
					}
					break;
				case 6:
					{
						PlayTimePanel.text = "已暂停" ;
					}
					break;
				default:
					PlayTimePanel.text = "" ;
			}
			//PlayTimePanel.text = "正在缓冲(" + DataCenter.BufferProgress + "%)";
			//PlayTimePanel.text = this._TranslateTime(DataCenter.PlayProgress) + "/" + this._TranslateTime(DataCenter.FilmDuration);
		},
		_UpdateVolumeStatus:function()
		{
			DataCenter.Volume = 50 ;
			DataCenter.IsMute = false;
			
			var muteState = XLUIManager.LoadParam("Mute", "False"); 
			var volume = XLUIManager.LoadParam("Volume", "50");
			if(muteState == "True" || muteState == "true" || muteState == "TRUE")
			{
				DataCenter.IsMute = true ;
			}
			
			if(typeof(volume) != "undefined" && volume != "")
			{
				DataCenter.Volume = volume ;
			}
			
			XMP.PlayControl.CtrlVolume(DataCenter.Volume);
 
	    if(DataCenter.IsMute)
	    {
				XMP.PlayControl.CtrlSound();
	    }
	    else
	    {
				XMP.PlayControl.CtrlSilence();
	    }
		},
		_changeTrayState:function (visible){
											if (visible)
										  {
										    traymanager._maintray.visible = true;
										  }
										  else
										  {
										    traymanager._maintray.visible = false;
										  }
										},
		_button_PopMenu_onClick:function (object, wparam, lparam){
														  var item = menumanager._mainmenu;
														  if (item == undefined)
														  {
														    return false;
														  }
														  
														  var bEnable;
														  if (DataCenter.PlayStatus==2 || DataCenter.PlayStatus == 5 || DataCenter.PlayStatus == 6)
														  {
														    bEnable = true;
														  }
														  else
														  {
														    bEnable = false;
														  }
														  
														  var mainmenu = menumanager._mainmenu;
														  var filemenu = mainmenu._item_file;
														  if (filemenu != undefined)
														  {
														    filemenu.LockUpdate(true);
														    
														    filemenu._item_close.enable = bEnable;
														    filemenu._item_mediainfo.enable = bEnable;
														    
														    filemenu.LockUpdate(false);
														  }
														  
														  var viewmenu = mainmenu._item_view._item_fullscreen;
														  if (viewmenu != undefined)
														  {
														    viewmenu.checked = DataCenter.IsFullScreen;
														  }
														  
														  var playmenu = mainmenu._item_play;
														  if (playmenu != undefined)
														  {
														    playmenu.LockUpdate(true);
														    
														    playmenu._item_playpause.enable = bEnable;
														    playmenu._item_stop.enable = bEnable;
														    playmenu._item_before.enable = bEnable;
														    playmenu._item_next.enable = bEnable;
														    playmenu._item_jumpfront.enable = bEnable;
														    playmenu._item_jumpback.enable = bEnable;
														
														    playmenu.LockUpdate(false);
														  }
														  
														  return item.TrackPopupMenu( wparam, lparam+1, XmpMainWnd);
													},
		_onUIClick:function(uiid){
							ASSERT(typeof uiid == "string", "uiid==null");							 
							var pThis=this;
							var uiid2onclick={
								"max":pThis._button_Max_onClick,
								"restore":pThis._button_Restroe_onClick,
								"close":pThis._button_Close_onClick,
								"search":pThis._button_Search_onClick,
								"stop":pThis._button_Stop_onClick,
								"prev":pThis._button_Prev_onClick,
								"play":pThis._button_Play_onClick,
								"pause":pThis._button_Pause_onClick,
								"next":pThis._button_Next_onClick,
								"sound":pThis._button_Sound_onClick,
								"silence":pThis._button_Silence_onClick,
								"open":pThis._button_Open_onClick,
								"fullscreen":pThis._button_FullScreen_onClick,
								"showplaylist":pThis._button_ShowPlayList_onClick,
								"hideplaylist":pThis._button_HidePlayList_onClick,
								"changeskin":pThis._button_ChangeSkin_onClick,
								"tabsearchclose":pThis._button_TabSearchClose_onClick,
								"tabmoviehallclose":pThis._button_TabMovieHallClose_onClick,
								"tabplay":pThis._radio_TabPlay_onClick,
								"tabclassical":pThis._radio_TabClassical_onClick,
								"tabtheater":pThis._radio_TabTheater_onClick,
								"tabsearch":pThis._radio_TabSearch_onClick,
								"tabmoviehall":pThis._radio_TabMovieHall_onClick,
								"volume":pThis._slider_Volume_onClick,
								"playposition":pThis._slider_PlayPosition_onClick,
								"buffer":pThis._progressbar_Buffer_onClick,
								"snapshot":pThis._snapshotImg
							}
							var fun =uiid2onclick[uiid];
							ASSERT(typeof fun != "undefined", "fun==null");
							if(fun)
								fun.call(this);
						},
		_snapshotImg:function()
		{
			XMP.PlayControl.CtrlSnapshot(3);
		},
		_button_Max_onClick:function(){
														XmpMainWnd.Max();
													},
		_button_Restroe_onClick:function(){
																XmpMainWnd.Restore();	
														},  
		_quit:function(){
						this._changeTrayState(false);		
			var playing = XmpPlayer.On_playing;
			DEBUG("playing="+playing);
			if(playing)
			{
				 XMP.view_MsgBox.OnXMPEvent("OnShowMessageBox","确认","退出迅雷看看播放器，将会终止当前提供的播放服务，确认退出？",4,"确认","取消");
				 if(!DataCenter.MsgBoxRetValue)
				 {
				 	this._changeTrayState(true);		
				 		return;				 	
				 }
			}
			
			
						XMP.globalEventSource.fireEvent("onQuit");
						
						XLUIManager.Trace("JS::XmpMainWnd::Quit");
						XmpMainWnd.Hide();
						XmpPlayer.OnDisConnection();	
						XmpConfig.OnDisConnection2();
						PlaylistView.UninitView();
						DEBUG("_quit2");
						XMP.view_XmpMainWnd._saveXmpPosition();					  
						DEBUG("_quit3");
			    	
			    	XLUIManager.SaveParam("Volume", DataCenter.Volume);
			    	XLUIManager.SaveParam("Mute", DataCenter.IsMute);
			    	DEBUG("_quit4");
			    	XLUIManager.Quit();						
					},
		_button_Close_onClick:function(){
																DEBUG("_button_Close_onClick");
																if(XmpPlayer.IsQuitToTray() == true)
																{
																	if(DataCenter.PlayStatus==5/*Playing*/)
																	{
																		XMP.PlayControl.CtrlPause();
																	}
																	
																	DataCenter.TrayStatus=true;
																	this._changeTrayState(true);
																	DataCenter.TrayConfigWndVisible = XmpConfigWnd.visible ;
																	//XmpMainWnd.visible = false ;
																	XmpMainWnd.Hide();
																	XmpConfigWnd.Hide();
																	
																}
																else
																{
																	DEBUG("_button_Close_onClick2");		
																	XMP.menu_XMPMenu.OnMenuQuit();
																	//this._quit();
																}
														},
		_button_Search_onClick:function (){
															if(XmpPlayer.GoSearch()){
																this.InsertTab("search");
															}
														},
		_button_Stop_onClick:function (){
															XMP.PlayControl.CtrlStop();
														},
		_button_Prev_onClick:function (){
															XMP.PlayControl.CtrlPrev();
														},
		_button_Play_onClick:function (){
															XMP.PlayControl.CtrlPlay();
														},
		_button_Pause_onClick:function (){
															XMP.PlayControl.CtrlPlay();		
														},
		_button_Next_onClick:function (){
															XMP.PlayControl.CtrlNext();	
														},
		_button_Sound_onClick:function (){											
															XMP.PlayControl.CtrlSound();
														},
		_button_Silence_onClick:function (){
															XMP.PlayControl.CtrlSilence();
														},
		_button_Open_onClick:function (){
															XMP.PlayControl.CtrlOpen();
														},
		_button_FullScreen_onClick:function (){
															XMP.WindowMode.ChangeWindowMode(1);
														},
		_button_ShowPlayList_onClick:function (){			
			DataCenter.DisableUpdateWindowSize=true;	
			XLUIManager.Trace("DisableUpdateWindowSize = true");	
			PlaylistViewContainer.left = "XmpMainWnd.width-175" ;
			PlaylistViewContainer.top = g_PlayerContainerTop ;
			PlaylistViewContainer.width = "0" ;
			PlaylistViewContainer.height = "XmpMainWnd.height - g_PlayerContainerHeightOffset";									
															XmpPlayer.ShowPlaylist(true, XmpMainWnd.windowstate == 2);
														},
		_button_HidePlayList_onClick:function (){		
			DataCenter.DisableUpdateWindowSize=true;
			XLUIManager.Trace("DisableUpdateWindowSize = true");
			PlaylistViewContainer.left = "XmpMainWnd.width-175" ;
			PlaylistViewContainer.top = g_PlayerContainerTop ;
			PlaylistViewContainer.width = "0" ;
			PlaylistViewContainer.height = "XmpMainWnd.height - g_PlayerContainerHeightOffset";					
															XmpPlayer.ShowPlaylist(false, XmpMainWnd.windowstate == 2);
														},
		_button_ChangeSkin_onClick:function (){
															    DataCenter.SkinMgrWnd=XLUIManager.ToggleChangeSkin(false);     															
																	XmpSkinMgrHost.DoModal(XmpMainWnd);
														},
		_SwitchTab:function(tabname)
		{
			if(tabname=="search")
			{
				if(btnTabSearch.visible == false)
				{
					this._selectPlayerView("play");
				}
				else
				{
		    	this._selectPlayerView(tabname);
		  	}
		  }
		  else if(tabname=="moviehall")
		  {
		  	if(btnTabMovieHall.visible == false)
				{
					this._selectPlayerView("play");
				}
				else
				{
		    	this._selectPlayerView(tabname);
		  	}
		  }
		  else
		  {
		  	this._selectPlayerView(tabname);
		  }
		  
		   XMP.WindowMode.UpdateWindowSize();
		 
		},												
		_selectPlayerView:function(tabname){
															if(tabname=="search")
															{
																btnTabSearchClose.visible = true;
														    btnTabMovieHallClose.visible = false;
														  }
														  else if(tabname=="moviehall")
														  {
														  	btnTabSearchClose.visible = false;
														    btnTabMovieHallClose.visible = true;
														  }
														  else
														  {
														  	btnTabSearchClose.visible = false;
														    btnTabMovieHallClose.visible = false;
														  }														  
															XmpPlayer.SelectTabView(tabname);			
														},
		_button_TabSearchClose_onClick:function (){
																		this.CloseTab("search");
														},
		_button_TabMovieHallClose_onClick:function (){
																	XmpPlayer.CloseTab("moviehall");
														},
		_radio_TabPlay_onClick:function (){
															if(btnTabSearch.visible == false)
															{
																this._selectPlayerView("play");
															}
															else
															{
													    	this._selectPlayerView("play");
													  	}
													  	XMP.WindowMode.UpdateWindowSize();
													  	//this._setNormalSize();
														},												
		_radio_TabClassical_onClick:function (){
															this._selectPlayerView("classical");
															XMP.WindowMode.UpdateWindowSize();
															//this._setNormalSize();
														},
		_radio_TabTheater_onClick:function (){
															this._selectPlayerView("theater");
															XMP.WindowMode.UpdateWindowSize();
															//this._setNormalSize();
														},
		_radio_TabSearch_onClick:function (){
															if(btnTabSearch.visible == false)
															{
																this._selectPlayerView("play");
															}
															else
															{
														   	this._selectPlayerView("search");
														  }
														  XMP.WindowMode.UpdateWindowSize();
														  //this._setNormalSize();
														},
		_radio_TabMovieHall_onClick:function (){
																if(btnTabMovieHall.visible == false)
																{
																	this._selectPlayerView("play");
																}
																else
																{
														    	this._selectPlayerView("moviehall");
														  	}
														  	XMP.WindowMode.UpdateWindowSize();
														  	//this._setNormalSize();
														},							
		_slider_Volume_onClick:function(){
															XMP.PlayControl.CtrlVolume(volSlider.value);
															
														},
		_slider_PlayPosition_onClick:function (){
														var currProgress = playSlider.value; 
														//XmpPlayer.CtrlSeek(currProgress);
														XMP.PlayControl.CtrlSeek(currProgress);
														
														},
		_progressbar_Buffer_onClick:function (){
														}  ,
		OnRClick:function(obj,wparam,lparam){
			var item = menumanager._mainmenu;
		  if (item == undefined)
		  {
		    return false;
		  }
			  
		  return item.TrackPopupMenu(wparam, lparam, XmpMainWnd );
		}
	}
 XMP.view_XmpMainWnd.subView_MainPlane.attachEvent();
}

