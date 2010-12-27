
with(XMP)
{
XMP.view_PlayCtrlBar = {
		initUI:function(){  //根据 DataCenter.IsFirstInit 来判断是初始化，还是换肤后恢复现场
			if(!DataCenter.IsFirstInit)
			{
				this._UpdateByPlayStatus();
				if(DataCenter.FilmDuration!=0)
				{
					PlayBar_playSlider.maxvalue = DataCenter.FilmDuration;
    			PlayBar_bufferProgressBar.maxvalue = DataCenter.FilmDuration;    
    		}
    		//PlayBar_PlayTimePanel.text = this._TranslateTime(DataCenter.PlayProgress) + "/" + this._TranslateTime(DataCenter.FilmDuration);
    		PlayBar_bufferProgressBar.value = DataCenter.DownloadProgress; 
    		PlayBar_btnSound.visible = !DataCenter.IsMute;
    		PlayBar_btnSilence.visible = DataCenter.IsMute;  
    		PlayBar_volSlider.value = DataCenter.Volume;
    		
    		this._UpdatePlayTimePanel();
    		
    		var bitRate = "";
	
				if(DataCenter.PlayStatus == 3 || DataCenter.PlayStatus == 5)
					bitRate = parseInt(DataCenter.BitRate/1024) + "KB/S";
					
				if(DataCenter.BitRate==0)
					PlayBar_BitRatePanel.text = "";
				else
					PlayBar_BitRatePanel.text = bitRate;
			}
			this._UpdateSnapshotBtn();
			XmpPlayBar.Hide();
		},
		saveUI:function(){  //换肤之前保存现场
		},				
		_UpdatePlayTimePanel:function()
		{
			switch(DataCenter.PlayStatus)
			{
				case 4:
					{
						PlayBar_PlayTimePanel.text = "已停止" ;
					}
					break;
				case 5:
					{
						if(XmpPlayer.GetPlayStatusFlag() & 0x4)
							PlayBar_PlayTimePanel.text = "正在缓冲(" + DataCenter.BufferProgress + "%)";
						else
						{
							if(DataCenter.ShowTimeType==0)
								PlayBar_PlayTimePanel.text = this._TranslateTime(DataCenter.PlayProgress) + "/" + this._TranslateTime(DataCenter.FilmDuration);
							else
								PlayBar_PlayTimePanel.text = DataCenter.PlayProgress + "/" + DataCenter.FilmDuration ;
						}
					}
					break;
				case 6:
					{
						PlayBar_PlayTimePanel.text = "已暂停" ;
					}
					break;
				default:
					PlayBar_PlayTimePanel.text = "" ;
			}
			//PlayTimePanel.text = "正在缓冲(" + DataCenter.BufferProgress + "%)";
			//PlayTimePanel.text = this._TranslateTime(DataCenter.PlayProgress) + "/" + this._TranslateTime(DataCenter.FilmDuration);
		},
		_UpdateSnapshotBtn:function()
		{
			if(DataCenter.CurTabName == "play" && (DataCenter.PlayStatus==5||DataCenter.PlayStatus==6) && XmpPlayer.IsSnapShotable() )
			{
				PlayBar_btnSnapshot.enable = true ;			
			}
			else
			{
				PlayBar_btnSnapshot.enable = false ;
			}
		},
		AttachEvent:function(){
			// Attach Event
			var sEvents=["onInitUI","onSaveUI","OnScreenStatusChanged","OnPlayStatusChanged","OnFilmDurationChanged","OnPlayProgressChanged","OnDownloadProgressChanged","OnBufferProgressChanged","OnSilentStatusChanged","OnVolumeChanged","OnPlayBarStatusChanged","OnBitRateChanged"];
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
				XmpPlayBar.Hide();
			}
			else if(sEvent=="OnPlayStatusChanged")
			{
				this._UpdateSnapshotBtn();
				this._UpdateByPlayStatus();
			}
			else if(sEvent=="OnFilmDurationChanged")
			{
				if(DataCenter.FilmDuration!=0)
				{
					PlayBar_playSlider.maxvalue = DataCenter.FilmDuration;
    			PlayBar_bufferProgressBar.maxvalue = DataCenter.FilmDuration;    
    		}
    		//PlayBar_PlayTimePanel.text = this._TranslateTime(DataCenter.PlayProgress) + "/" + this._TranslateTime(DataCenter.FilmDuration);     
    		this._UpdatePlayTimePanel();
			}
			else if(sEvent=="OnPlayProgressChanged")
			{
				//PlayBar_PlayTimePanel.text = this._TranslateTime(DataCenter.PlayProgress) + "/" + this._TranslateTime(DataCenter.FilmDuration);     
				PlayBar_playSlider.value = DataCenter.PlayProgress; 
				this._UpdatePlayTimePanel();
			}
			else if(sEvent=="OnDownloadProgressChanged")
			{
				PlayBar_bufferProgressBar.value = DataCenter.DownloadProgress;    
			}
			else if(sEvent=="OnBufferProgressChanged")
			{
				this._UpdatePlayTimePanel();
			}
			else if(sEvent=="OnSilentStatusChanged")
			{
				PlayBar_btnSound.visible = !DataCenter.IsMute;
    		PlayBar_btnSilence.visible = DataCenter.IsMute;
			}
			else if(sEvent=="OnVolumeChanged")
			{
				PlayBar_volSlider.value = DataCenter.Volume;
			}
			else if(sEvent=="OnBitRateChanged")
			{
				var bitRate = "";
	
				if(DataCenter.PlayStatus == 3 || DataCenter.PlayStatus == 5)
					bitRate = parseInt(DataCenter.BitRate/1024) + "KB/S";
					
					if(DataCenter.BitRate==0)
						PlayBar_BitRatePanel.text = "";
					else
						PlayBar_BitRatePanel.text = bitRate;
			}
			else if(sEvent=="OnPlayBarStatusChanged")
			{
				var bShow = arguments[1] ;
				if(bShow && DataCenter.WindowMode==1)
		    {
		    	XmpPlayBar.SetParent(XmpMainWnd);
		    	
		    	var sw = global.GetScreenWidth();
					var sh = global.GetScreenHeight();
      		XmpPlayBar.Move(0, sh-50,	sw, 50);
      		
		      XmpPlayBar.Show(false, false);       
		    }
		    else
		    {
		       XmpPlayBar.Hide();
		    }
			}
		},
		_UpdateByPlayStatus:function()
		{
			switch (DataCenter.PlayStatus)
    		{
    			case 0:	//PS_NONE
         		break;
    			case 1: //PS_READY
		        PlayBar_BitRatePanel.text = "";
		       // PlayBar_PlayTimePanel.text = "";
		        PlayBar_btnStop.enable   = false;
		        PlayBar_btnPause.visible = false;
		        PlayBar_btnPlay.visible  = true;
		        PlayBar_btnPlay.enable   = true;
		        PlayBar_playSlider.enable = false;        
		        break;
    			case 2: //PS_STARTDOWNLOAD
		        PlayBar_btnPlay.enable = false;
		        PlayBar_playSlider.enable = false;
		        break;
    			case 3: //PS_OPENING
		        PlayBar_BitRatePanel.text = "";
		       // PlayBar_PlayTimePanel.text = "";
		       	PlayBar_btnPlay.enable = false;
		        PlayBar_playSlider.enable = false;     
		        break;
					case 4: //PS_STOPED     
		        PlayBar_BitRatePanel.text = "";
		      //  PlayBar_PlayTimePanel.text = "已停止";
		        PlayBar_btnPause.visible = false;
		        PlayBar_btnPlay.visible  = true;
		       	PlayBar_btnStop.enable   = false;     
		        break;
    			case 5: //PS_PLAYING
		        PlayBar_btnStop.enable   = true;
		        PlayBar_btnPlay.visible  = false;
		        PlayBar_btnPause.visible = true;
		        PlayBar_btnPause.enable  = true;
		        PlayBar_playSlider.enable = true;  
        		break;
    			case 6: //PS_PAUSED
		        PlayBar_BitRatePanel.text = "";
		      //  PlayBar_PlayTimePanel.text = "已暂停";
		        PlayBar_btnPause.visible = false;
		        PlayBar_btnPlay.visible  = true;
		       	PlayBar_btnPlay.enable  = true;        
		        break;
   			} 
   			
   			this._UpdatePlayTimePanel();
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
		_OnUIClick:function(sName)
		{
			if(sName=="play")
			{
				XMP.PlayControl.CtrlPlay();
			}
			else if(sName=="pause")
			{
				XMP.PlayControl.CtrlPause();
			}
			else if(sName=="stop")
			{
				XMP.PlayControl.CtrlStop();
			}
			else if(sName=="prev")
			{
				XMP.PlayControl.CtrlPrev();
			}
			else if(sName=="next")
			{
				XMP.PlayControl.CtrlNext();
			}
			else if(sName=="sound")
			{
				XMP.PlayControl.CtrlSound();
			}
			else if(sName=="silence")
			{
				XMP.PlayControl.CtrlSilence();
			}
			else if(sName=="open")
			{
				XMP.PlayControl.CtrlOpen();
			}
			else if(sName=="exitfullscreen")
			{
				XMP.WindowMode.ChangeWindowMode(0);
			}
			else if(sName=="volume")
			{
				XMP.PlayControl.CtrlVolume(PlayBar_volSlider.value);
			}
			else if(sName=="seek")
			{
				XMP.PlayControl.CtrlSeek(PlayBar_playSlider.value);
			}
			else if(sName=="snapshot")
			{
				XMP.PlayControl.CtrlSnapshot();
			}
		}
	};
	
	view_PlayCtrlBar.AttachEvent();
}