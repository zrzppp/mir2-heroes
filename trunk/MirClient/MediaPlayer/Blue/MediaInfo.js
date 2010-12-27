with(XMP)
{
XMP.view_MediaInfo = {
		AttachEvent:function(){
			// Attach Event
			var sEvents=["OnShowMediaInfo"];
			for(var i = 0; i<sEvents.length; i++)
			{
				var pThis=this;		 
				globalEventSource.attachEvent(this, sEvents[i] ,function(){					 
					var args =  argumentsToArray(arguments).slice(1);
					pThis.OnXMPEvent.apply(pThis, args);				 
					});			  
			}		
		},
		OnXMPEvent:function(sEvent,param1,param2,param3,param4,param5,param6,param7){
			if(sEvent=="OnShowMediaInfo")
			{	
				 var  name = param1;
				 var filetype = param2;
				 var fileSize = param3;
				 var mediatime = param4;
				 var rate = param5;
				 var createtime = param6;
				 var path = param7;
					XmpMediaInfo_Name.text = name ;
					XmpMediaInfo_FileType.text = filetype;
					XmpMediaInfo_FileSize.text = fileSize;
					XmpMediaInfo_Path.editText = XmpPlayer.GetPlayFilePath(); //DataCenter.PlayTitle ;
					XmpMediaInfo_CreateTime.text = createtime ;
					XmpMediaInfo_Rate.text = rate ;
					XmpMediaInfo_MediaTime.text = mediatime ;
					XmpMediaInfo.DoModal(XmpMainWnd);
			}
		},
		_OnUIClick:function(sName)
		{
			if(sName=="close")
			{
				XmpMediaInfo.Close();
			}
		}
	};
	
	view_MediaInfo.AttachEvent();
}