var g_AutoShutdownTimerId = 0;
var g_AutoShutdownLastTime = 1000*60;
with(XMP)
{
XMP.view_AutoShutdownMsgBox = {
		AttachEvent:function(){
			// Attach Event
			var sEvents=["OnShowAutoShutDownMsgBox"];
			for(var i = 0; i<sEvents.length; i++)
			{
				var pThis=this;		 
				globalEventSource.attachEvent(this, sEvents[i] ,function(){					 
					var args =  argumentsToArray(arguments).slice(1);
					pThis.OnXMPEvent.apply(pThis, args);				 
					});			  
			}		
		},
		
		_OnTimerAutoShutdown:function (){
													XLUIManager.Trace("OnTimerAutoShutdown()");	
													g_AutoShutdownLastTime -= 1000;
													AutoShutdownMsgBox_Tips.text = "迅雷影音播放列表中的所有任务播放完毕，离关机还有 " + g_AutoShutdownLastTime/1000 + " 秒！";
													if(g_AutoShutdownLastTime <= 0)
													{
														timermanager.ClearInterval(g_AutoShutdownTimerId);
														this._CloseAutoShutDownMsgBox();														 
														XmpPlayer.ShutdownComputer();
													}
											},
		
		OnXMPEvent:function(sEvent,param1,param2){
			if(sEvent=="OnShowAutoShutDownMsgBox")
			{	
				XLUIManager.Trace("OnShowAutoShutDownMsgBox");	
				var pThis = this;
				g_AutoShutdownTimerId = timermanager.SetInterval(function(){ pThis._OnTimerAutoShutdown() },1000);
				AutoShutdownMsgBox_Tips.text = "迅雷影音播放列表中的所有任务播放完毕，离关机还有 60 秒！";
				AutoShutdownMsgBox.DoModal(XmpMainWnd);
			}
		},
		_CloseAutoShutDownMsgBox:function(){
															g_AutoShutdownLastTime = 1000*60;
															if(g_AutoShutdownTimerId >=  0)
															{
																timermanager.ClearInterval(g_AutoShutdownTimerId);
															}
															AutoShutdownMsgBox.Close();
														},			
		_OnUIClick:function(sName)
		{
			if(sName=="close")
			{
					AutoShutdownMsgBox.Close();
			}
			else if(sName=="shutdown")
			{
					this._CloseAutoShutDownMsgBox();
					XmpPlayer.ShutdownComputer();
			}
			else if(sName=="cancel")
			{
					this._CloseAutoShutDownMsgBox();
			}
		}
	};
	
	view_AutoShutdownMsgBox.AttachEvent();
}