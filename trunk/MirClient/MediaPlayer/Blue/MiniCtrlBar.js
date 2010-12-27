with(XMP)
{
XMP.view_MiniCtrlBar = {
		initUI:function(){  //根据 DataCenter.IsFirstInit 来判断是初始化，还是换肤后恢复现场
			
			if(!DataCenter.IsFirstInit)
			{
				this._UpdateByPlayStatus();
				if(DataCenter.FilmDuration!=0)
				{
					MiniBar_playSlider.maxvalue = DataCenter.FilmDuration;
    			MiniBar_bufferProgressBar.maxvalue = DataCenter.FilmDuration;
    		}
    		MiniBar_playSlider.value = DataCenter.PlayProgress;
    		MiniBar_bufferProgressBar.value = DataCenter.DownloadProgress;
    		MiniBar_btnSound.visible = !DataCenter.IsMute;
   		  MiniBar_btnSilence.visible = DataCenter.IsMute;
   		  MiniBar_volSlider.value = DataCenter.Volume;
			}
			this._UpdateSnapshotBtn();
			XmpMiniCtrlBar.Hide();
		},
		saveUI:function(){  //换肤之前保存现场
		},		
		_UpdateSnapshotBtn:function()
		{
			if(DataCenter.CurTabName == "play" && (DataCenter.PlayStatus==5||DataCenter.PlayStatus==6) && XmpPlayer.IsSnapShotable() )
			{
				MiniBar_btnSnapshot.enable = true ;
			}
			else
			{
				MiniBar_btnSnapshot.enable = false ;
			}
		},
		AttachEvent:function(){
			// Attach Event
			var sEvents=["onInitUI","onSaveUI","OnScreenStatusChanged","OnPlayStatusChanged","OnFilmDurationChanged","OnPlayProgressChanged","OnDownloadProgressChanged","OnBufferProgressChanged","OnSilentStatusChanged","OnVolumeChanged","OnMiniCtrlBarStatusChanged"];
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
				XmpMiniCtrlBar.Hide();
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
					MiniBar_playSlider.maxvalue = DataCenter.FilmDuration;
    			MiniBar_bufferProgressBar.maxvalue = DataCenter.FilmDuration;
    		}
			}
			else if(sEvent=="OnPlayProgressChanged")
			{
				MiniBar_playSlider.value = DataCenter.PlayProgress;
			}
			else if(sEvent=="OnDownloadProgressChanged")
			{
				MiniBar_bufferProgressBar.value = DataCenter.DownloadProgress;
			}
			else if(sEvent=="OnBufferProgressChanged")
			{
				if(DataCenter.BufferProgress == 100)
        {
        	MiniBar_btnPause.enable  = true;
        }
        else
        {
        	MiniBar_btnPause.enable  = false;
        }
			}
			else if(sEvent=="OnSilentStatusChanged")
			{
				MiniBar_btnSound.visible = !DataCenter.IsMute;
   		  MiniBar_btnSilence.visible = DataCenter.IsMute;
			}
			else if(sEvent=="OnVolumeChanged")
			{
				MiniBar_volSlider.value = DataCenter.Volume;
			}
			else if(sEvent=="OnMiniCtrlBarStatusChanged")
			{
				var left = arguments[1];
				var top = arguments[2];
				var width = arguments[3];
				var height = arguments[4];
				
				if(width==0||height==0||DataCenter.WindowMode!=2)
				{
					XmpMiniCtrlBar.Hide();
					return;
				}
				
				XmpMiniCtrlBar.SetParent(XmpMainWnd);
				
				XmpMiniCtrlBar.Move(left+3, top+3, width, height);
				XmpMiniCtrlBar.Show(false, false);
			}
			
		},
		_UpdateByPlayStatus:function()
		{
			switch (DataCenter.PlayStatus)
    		{
					case 0:	//PS_NONE
         		break;
					case 1: //PS_READY
		        MiniBar_btnPause.visible = false;
		        MiniBar_btnPlay.visible  = true;
		        MiniBar_btnPlay.enable   = true;
		        MiniBar_playSlider.enable = false;
		        break;
					case 2: //PS_STARTDOWNLOAD
		        MiniBar_btnPlay.enable = false;
		        MiniBar_playSlider.enable = false;
		        break;
    			case 3: //PS_OPENING		
		        MiniBar_btnPlay.enable = false;
		        MiniBar_playSlider.enable = false;
		        break;
    			case 4: //PS_STOPED    
		        MiniBar_btnPause.visible = false;
		        MiniBar_btnPlay.visible  = true;
		        MiniBar_btnPlay.enable  = true; 
		        break;
    			case 5: //PS_PLAYING       
		        MiniBar_btnPause.enable  = true;
		        MiniBar_playSlider.enable = true;
		        MiniBar_btnPlay.visible  = false;
		        MiniBar_btnPause.visible = true;        
        		break;
					case 6: //PS_PAUSED
		        MiniBar_btnPause.visible = false;
		        MiniBar_btnPlay.visible  = true;
		        MiniBar_btnPlay.enable = true;          
		        break;
    		} 
		},
		OnMouseLeave:function(){
			XmpMiniCtrlBar.Hide();
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
			else if(sName=="fullscreen")
			{
				XMP.WindowMode.ChangeWindowMode(1);
			}
			else if(sName=="volume")
			{
				XMP.PlayControl.CtrlVolume(MiniBar_volSlider.value);
			}
			else if(sName=="seek")
			{
				XMP.PlayControl.CtrlSeek(MiniBar_playSlider.value);
			}
			else if(sName=="snapshot")
			{
				XMP.PlayControl.CtrlSnapshot();
			}
		}
	};
	
	view_MiniCtrlBar.AttachEvent();
}