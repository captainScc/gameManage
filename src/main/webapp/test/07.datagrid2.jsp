<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<LINK rel="stylesheet" type="text/css"	href="${pageContext.request.contextPath}/js/easyui/themes/default/easyui.css" />
	<LINK rel="stylesheet" type="text/css"	href="${pageContext.request.contextPath}/js/easyui/themes/icon.css">
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js"></script>
	<SCRIPT type="text/javascript" src="${pageContext.request.contextPath}/js/easyui/jquery.easyui.1.4.min.js"></SCRIPT>
	
	<script type="text/javascript">
		$(function(){
			//定义普通类描述
			var col_arr = [[
			                {field:'productid',title:'商品编号',width:100},
			                {field:'productname',title:'商品名称',width:100},
			                {field:'unitcost',title:'单价',width:100},
			                {field:'status',title:'状态',width:100},
			                {field:'listprice',title:'小计',width:100},
			                {field:'listprice',title:'小计',width:100},
			                {field:'listprice',title:'小计',width:100},
			                {field:'del',title:'删除',width:100,
			                	//参数1：field指定名称在json数据中，一行中对应的数据
			                	formatter:function(value,row,index){
			                		return "<a href='javascript:void(0)' onclick=\"userdel('"+row.productid+"')\">删除</a>";
			                	}
			                }
			                ]];
			//冻结列，与普通类语法一样的
			var fro_col_arr = [[
			                    {field:'productid',title:'商品编号',width:100},
			                    ]];
			
			//工具条
			var bar_arr = [
			               {
			            	   iconCls: 'icon-edit'
			               },
			               '-',
			               {
			            	   iconCls: 'icon-add',
			            	   handler: useradd,
			            	   text:'添加'
			               }
			               ];
			
			var options={
				url:'datagrid_data.json',
				columns:col_arr,
				width:600,
				height:300,
				title:'系统用户列表',
				rownumbers:true,				//行号
				pagination:true,				//分页
				frozenColumns:fro_col_arr,		//冻结列
				pageList:[5,10,15],				//分页初始化页面大小选择列表
				pageSize:5,						//分页初始化页面大小
				toolbar:bar_arr,				//工具条
				queryParams:{"username":"jack"}	//额外查询条件
			};
			
			$("#dg").datagrid(options);
		});
		
		//用户添加
		function useradd(){
			alert("添加");
		}
		
		//用户删除
		function userdel(uid){
			alert(uid);
		}
	</script>
	
<title>Insert title here</title>
</head>
<body>
	<table id="dg"></table>  
	
</body>
</html>