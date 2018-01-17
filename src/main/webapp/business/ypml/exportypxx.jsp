<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/tag.jsp"%>
<html> 
<head>
<title>药品目录导出</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">

<%@ include file="/common/common_css.jsp"%>
<%@ include file="/common/common_js.jsp"%>

<script type="text/javascript">
	function ypxxexport(){
		//提交表单
		jquerySubByFId("ypxxlistFrom",ypxxexport_callback);
	}
	function ypxxexport_callback(data){
		message_alert(data);
	}

</script>

</head>
<body>
<!-- 导出条件 -->

<form id="ypxxlistFrom" action="${baseurl}/ypml/exportypxx_submit.action" method="post">
<TABLE  class="table_search">
				<TBODY>
					<TR>
						<TD class="left">流水号：</TD>
						<td ><INPUT type="text" name="ypxxQueryCustom.bm" /></td>
						<TD class="left">通用名：</td>
						<td><INPUT type="text"  name="ypxxQueryCustom.mc" /></TD>
						
						<TD class="left">药品类别：</TD>
						<td >
							<select name="ypxxQueryCustom.sysDictInfoByLb.id" style="width:150px">
								<option value="">全部</option>
								<c:forEach items="${yplbList}" var="dictinfo">
									<option value="${dictinfo.id}">${dictinfo.info}</option>
								</c:forEach>
							</select>
						</td>
						<TD class="left">交易状态：</TD>
						<td >
							<select name="ypxxQueryCustom.sysDictInfoByJyzt.id" style="width:150px">
								<option value="">全部</option>
								<c:forEach items="${ypjyztList}" var="dictinfo">
									<option value="${dictinfo.id}">${dictinfo.info}</option>
								</c:forEach>
							</select>
							
						</td>
					</TR>
					<tr>
					  <td colspan="12" style="text-align:center"><a id="btn" href="#" onclick="ypxxexport()" class="easyui-linkbutton" iconCls='icon-search'>导出</a></td>
					</tr>
				</TBODY>
			</TABLE>
			
</form>


</body>
</html>