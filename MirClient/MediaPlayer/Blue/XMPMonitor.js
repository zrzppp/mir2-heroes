
if(!XMP) //没有xmp表示不正常使用,直接异常
	debugger
	
with(XMP)
{	
	 
 
	XMP.monitor = {		
			scriptHost:new ActiveXObject("XScriptHost.XScriptHost"),
			AttachEvent:function(){
			 							var sEvents=["onInitUI","onSaveUI","onQuit","OnShowPlaylist"];
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
										if("onInitUI"==sEvent)
										{	
											 
											 this.init();
										}
										else if("onQuit"==sEvent)
										{
											//alert('aaa');
										//	ASSERT(0);
											this.scriptHost=null;
										}
										else if("OnShowPlaylist"==sEvent)
										{
										//	this.scriptHost.SetAddin("xmpplayer", XmpPlayer);
										}
									},
			init:function(){
						this.scriptHost.Load("Skin/scripthost.xml",0);
						this.scriptHost.SetAddin("xmpplayer", XmpPlayer);
						this.scriptHost.Run();
						//ASSERT(0);
					}
		}
	
 		monitor.AttachEvent();
 
}