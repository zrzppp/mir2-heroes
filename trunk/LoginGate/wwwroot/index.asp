<%
on error resume next
Function safechk()
	dim server_v1,server_v2
	server_v1=Cstr(Request.ServerVariables("HTTP_REFERER"))
	server_v2=Cstr(Request.ServerVariables("SERVER_NAME"))
	if mid(server_v1,8,len(server_v2))<>server_v2 then
		msg="不能从外部网页提交！"
		response.write "<script language=javascript>alert('"&msg&"');location.href='index.asp';</script>"
		response.end
	end if
End Function


userip=Request.ServerVariables("HTTP_X_FORWARDED_FOR") 
if userip= "" Then userip=Request.ServerVariables("REMOTE_ADDR") 

if request("action")="add" then
	safechk
	if session("GetCode")=Request("GetCode") then

		dim contentss
		countfile=server.mappath("iplist.txt")
	 
		Set fss=CreateObject("Scripting.FileSystemObject")
		Set tss=fss.OpenTextFile(countfile,1,True) 
		contentss=tss.ReadAll
		tss.close
		set fss=nothing


		Set fss=CreateObject("Scripting.FileSystemObject")
		Set tss=fss.OpenTextFile(countfile,2,True) 
		if (instr(contentss,userip)>0)=false then
			if len(contentss)<5 then
				contentss=userip
			else
				contentss=contentss&vbcrlf&userip
			end if
		end if
		tss.write contentss
		tss.close
		set tss=nothing

		response.write "<script>alert('您的IP："&userip&"已经成功加入绿色通道,祝您游戏愉快!');location.href='index.asp';</script>"
	else
		response.write "<script>alert('验证码不对!');location.href='index.asp';</script>"
	end if
else
%>
<script>
<!--
function chk1(theform){
	if (theform.GetCode.value==""){
		alert("请输入验证码!");
		theform.GetCode.focus();
		return false;
	}
}
//-->
</script><style type="text/css">
<!--
body,td,th {
	font-size: 12px;
	color: #FFFFFF;
}
body {
	margin-left: 0px;
	margin-top: 100px;
	margin-right: 0px;
	margin-bottom: 50px;
}
.bian {
	border: 1px ridge #CCCCCC;
}
.TopName {
	FILTER: dropshadow(color=#000000, offx=1, offy=1, positive=1)
}
-->
</style>
<table width="380" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><img src="images/863sf_cn_r1_c1.gif" width="380" height="62" /></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td width="4%" rowspan="2"><img src="images/863sf_cn_r2_c1.gif" width="15" height="188" /></td>
        <td width="350" height="160" background="images/863sf_cn_r2_c2.gif"><table width="200" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="30" align="left" class="TopName">您的ＩＰ是：<%=userip%></td>
          </tr>
		  <form action="?action=add" method="post" name="form1" onsubmit="return chk1(this);">
          <tr>
            <td height="30" align="left" class="TopName">请输入验证码：
              <input name="GetCode" class="bian" value="" size="6"> 
              <img src="code.asp"></td>
          </tr>
          <tr>
            <td height="30" align="left" class="TopName"><input type="submit" name="submit" value="提交"> 
              <input type="reset" name="Submit" value="重置" /></td>
          </tr>
</form>
        </table></td>
        <td width="4%" rowspan="2"><img src="images/863sf_cn_r2_c3.gif" width="15" height="188" /></td>
      </tr>
      <tr>
        <td><img src="images/863sf_cn_r3_c2.gif" width="350" height="28" /></td>
        </tr>
    </table></td>
  </tr>
</table>
<%
end if
%>
	
	

