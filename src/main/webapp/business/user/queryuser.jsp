<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/tag.jsp"%>
<html>
<head>
<title>系统用户信息查询</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">

<%@ include file="/common/common_css.jsp"%>
<%@ include file="/common/common_js.jsp"%>
	
<script type="text/javascript">
	$(function(){
		
		//普通列
		var col_arr = [[
		                {field:'usercode',title:'用户账号',width:100},
		                {field:'username',title:'用户名称',width:150},
		                {field:'lb',title:'用户类别',width:100,
		                	//方式1
		                	formatter:function(value,row,index){
		                		return row.sysDictInfoByGroupid.info;
		                	}
		                },
		                {field:'sysDictInfoByGroupid',title:'用户类别2',width:100,
		                	//方式2
		                	formatter:function(value,row,index){
		                		return value.info;
		                	}
		                },
		                {field:'zt',title:'用户状态',width:100,
		                	formatter:function(value,row,index){
		                		return row.sysDictInfoByUserstate.info;
		                	}
		                },
		                {field:'dw',title:'所属单位',width:150,
		                	formatter:function(value,row,index){
		                		//1获得业务码
		                		var dictcode = row.sysDictInfoByGroupid.dictcode;
		                		//2 不同的业务码，表示不同的用户类别，不同用户存在不同的表中
		                		// * 1和2 ，卫生局和卫生院，表：dw_wsy，对象：DwWsy
		                		// * 3，卫生室，表：dw_wss，对象：DwWss
		                		// * 4，供应商，表：dw_gys，对象：DwGys
		                		
		                		if(dictcode==1 || dictcode==2){
		                			return row.dwWsy.mc;
		                		}
		                		
		                		if(dictcode==3){
		                			return row.dwWss.mc;
		                		}
		                		
		                		if(dictcode==4){
		                			return row.dwGys.mc;
		                		}
		                		
		                		return ;
		                	}
		                },
		                {field:'edit',title:'修改',width:100},
		                {field:'delete',title:'删除',width:100,
		                	formatter:function(value,row,index){
		                		return "<a href='javascript:void(0)' onclick=\"deluser('"+row.id+"')\">删除</a>";
		                	}
		                }
		                ]];
		
		//工具类
		var bar_arr = [
						<shiro:hasPermission name="user:add">

		               {
		            	   text:'添加',
		            	   iconCls:'icon-add',
		            	   handler: adduser
		               }
		               </shiro:hasPermission>
		               ];
		
		var options = {
			url:'${baseurl}/user/queryuser_result.action',
			columns:col_arr,
			width:900,
			height:400,
			//fit:true,
			title:'系统用户列表',
			rownumbers:true,				//行号
			pagination:true,				//分页
			toolbar:bar_arr,
		};
		
		$("#sysuserlist").datagrid(options);
	});
	
	//添加用户
	function adduser(){
		//打开一个window，显示添加页面
		createmodalwindow("添加用户",700,240,"${baseurl}/user/adduser.action");
	}
	
	//条件查询
	function sysuserquery(){
		
		
		//重写加载datagrid数据，加载时设置查询条件
		//* 模拟数据
		/*
		var param = {
				"sysUserQueryCustom.usercode":"jack",
				"sysUserQueryCustom.username":"xxx",
				"sysUserQueryCustom.sysDictInfoByGroupid.id":"s0103",
		};
		*/
		// * 通过工具获得数据
		var param = $("#sysuserqueryForm").serializeJson() ;
		
		//加载
		$("#sysuserlist").datagrid("load",param);
		
	}
	
	//删除用户
	function deluser(userId){
		//确定删除
		//_confirm("您确定要删除吗？",function(){确定按钮的回调}, function(){取消按钮的回调});
		_confirm("您确定要删除吗？",function(){
			
			//将数据添加到表单中，然后ajax提交表单
			//1 将用户id，设置到input中
			$("#sysuserdelid").val(userId);
			//2 提交表单 ，sysuserdelForm
			jquerySubByFId("sysuserdelForm",deluser_callback);
			
		});
		
	}
	
	function deluser_callback(data){
		message_alert(data , deluser_message_callback);
	}
	
	function deluser_message_callback(){
		sysuserquery();
	}

</script>
</head>
<body>
<!-- 先写布局 -->
<form id="sysuserqueryForm" name="sysuserqueryForm" method="post" action="">
			<TABLE class="table_search">
				<TBODY>
					<TR>
						<TD class="left">用户账号：${sysUserCustom.usercode }</td>
						<td><INPUT type="text" name="sysUserQueryCustom.usercode" /></TD>
						<TD class="left">用户名称：</TD>
						<td><INPUT type="text" name="sysUserQueryCustom.username" /></TD>

						<TD class="left">用户类别：</TD>
						<td>
							<select name="sysUserQueryCustom.sysDictInfoByGroupid.id">
								<option value="">请选择</option>
								<c:forEach items="${userGroupList}" var="dictinfo">
									<option value="${dictinfo.id}">${dictinfo.info}</option>
								</c:forEach>
								
							</select>
						</TD>
						<td >
						<a id="btn" href="#" onclick="sysuserquery()"
							class="easyui-linkbutton" iconCls='icon-search'>查询</a>
							</td>
					</TR>


				</TBODY>
			</TABLE>
			
		</form>
<!-- datagrid -->
<TABLE border=0 cellSpacing=0 cellPadding=0 width="99%" align=center>
		<TBODY>
			<TR>
				<TD>
					<table id="sysuserlist"></table>
				</TD>
			</TR>
		</TBODY>
</TABLE>
<!-- 此form用于删除用户 -->
<form id="sysuserdelForm" action="${baseurl}/user/deleteuser_submit.action" method="post" style="display:none">
	<!-- form中包括要删除用户的id -->
	<input id="sysuserdelid" name="sysUserCustom.id" value=""/>
</form>
</body>

</html>