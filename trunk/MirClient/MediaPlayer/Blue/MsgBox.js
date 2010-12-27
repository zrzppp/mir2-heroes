with(XMP)
{
XMP.view_MsgBox = {
		AttachEvent:function(){
			// Attach Event
			var sEvents=["OnShowMessageBox","onQuit"];
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
			if(sEvent=="OnShowMessageBox")
			{	
				var title = arguments[1];
				var msgInfo = arguments[2];
				var type = arguments[3];
				var okText = arguments[4];
				var cancelText = arguments[5];
				var width = arguments[6];
				var height = arguments[7];
				
				XmpMsgBox_Btn_Ok.text = okText ;
				XmpMsgBox_Btn_Cancel.text = cancelText ;
				
				XmpMsgBox_Btn_Ok.Tips = okText;
				XmpMsgBox_Btn_Cancel.Tips = cancelText ;
			
				var len = global.GetStringWidth(msgInfo, "$system.title.default");
				var miWidth = eval(XmpMsgBox_TipsInfo.width);
				var lines = Math.floor(len/miWidth);
				if( (len%miWidth) > 0)
					lines += 1;
				XLUIManager.Trace("MessageBox Step1 : " + lines);
				XmpMsgBox_TipsInfo.top = (26 + (110 - lines * 14)/2);
				
				if(type==4) // Query
				{
					XmpMsgBox_Btn_Ok.visible = true;
					XmpMsgBox_Btn_Cancel.visible = true;
					XmpMsgBox_Btn_Ok.left = XmpMsgBox.width-165;
					XmpMsgBox_Btn_Cancel.left = XmpMsgBox.width-85;
					XmpMsgBox_Btn_Ok.top = XmpMsgBox.height-35;
					XmpMsgBox_Btn_Cancel.top = XmpMsgBox.height-35;
				}
				else
				{
					XmpMsgBox_Btn_Ok.visible = true;
					XmpMsgBox_Btn_Cancel.visible = false;
					XmpMsgBox_Btn_Ok.left = XmpMsgBox.width/2-38;
					XmpMsgBox_Btn_Ok.top = XmpMsgBox.height-35;
				}
				
				if(type==1)
				{
					XmpMsgBox_Icon_Notice.visible=false;
					XmpMsgBox_Icon_Error.visible=true;
				}
				else
				{
					XmpMsgBox_Icon_Notice.visible=true;
					XmpMsgBox_Icon_Error.visible=false;
				}
				
				
				XmpMsgBox_Title.text = title;
				XmpMsgBox_TipsInfo.text = msgInfo;
				
				XmpMsgBox.DoModal(XmpMainWnd);
			}
			else if(sEvent=="onQuit")
			{
				XmpPlayer.SetMsgBoxRetValue(0);
				DataCenter.MsgBoxRetValue = 0;
				XmpMsgBox.Close();
			}
		},
		_OnUIClick:function(sName)
		{
			if(sName=="close")
			{
				XmpPlayer.SetMsgBoxRetValue(0);
				DataCenter.MsgBoxRetValue = 0;
				XmpMsgBox.Close();
			}
			else if(sName=="ok")
			{
				XmpPlayer.SetMsgBoxRetValue(1);
				DataCenter.MsgBoxRetValue = 1;
				XmpMsgBox.Close();
			}
		}
	};
	
	view_MsgBox.AttachEvent();
}