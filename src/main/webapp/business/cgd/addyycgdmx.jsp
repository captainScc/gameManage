<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/tag.jsp"%>
<html>
  <head>
    <title></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">

<%@ include file="/common/common_css.jsp"%>
<%@ include file="/common/common_js.jsp"%>

<script type="text/javascript">

	//添加采购单明细
	function addyycgdmx(){
		
		//1 获得所有的勾选项
		var selectArray = $('#ypxxlist').datagrid("getSelections");
		if(selectArray.length == 0){
			//alert("没有勾选");
			alert_warn("没有勾选");
			return;
		}
		
		// 将表单之前  ypxxids 清除了
		$("input[name='ypxxids']").remove();
		
		//2 将药品信息id 添加到表单（addyycgdmxForm）中
		// * <input name="ypxxids" value="1">
		$.each(selectArray,function(){
			//this 就是遍历一行数据
			$("#addyycgdmxForm").append("<input name='ypxxids' value='"+this.id+"'>");
		});
		
		//3 ajax提交表单
		jquerySubByFId("addyycgdmxForm",addyycgdmx_callback);
		
	}
	
	function addyycgdmx_callback(data){
		message_alert(data,addyycgdmx_message_callback);
	}
	function addyycgdmx_message_callback(){
		//关闭窗口
		parent.closemodalwindow();
		
		//刷新父页面的datagrid
		parent.yycgdmxquery();
	}


	//工具栏
	var toolbar = [ {
		id : 'ypxxdel',
		text : '确认采购',
		iconCls : 'icon-remove',
		handler : addyycgdmx
	} ];

	var frozenColumns;

	var columns = [ [ {
		field : 'id',
		title : '',
		checkbox : true
	}, {
		field : 'bm',
		title : '流水号',
		width : 80
	}, {
		field : 'mc',
		title : '通用名',
		width : 130
	}, {
		field : 'jx',
		title : '剂型',
		width : 80
	}, {
		field : 'gg',
		title : '规格',
		width : 100
	}, {
		field : 'zhxs',
		title : '转换系数',
		width : 50
	}, {
		field : 'scqymc',
		title : '生产企业',
		width : 180
	}, {
		field : 'spmc',
		title : '商品名称',
		width : 150
	}, {
		field : 'zbjg',
		title : '中标价',
		width : 50
	}, {
		field : 'jyzt',
		title : '交易状态',
		width : 60,
		//嵌套对象输出使用formatter方法
		formatter : function(value, row, index) {
			return row.sysDictInfoByJyzt.info;
		}
	}, {
		field : 'opt3',
		title : '详细',
		width : 60,
		formatter : function(value, row, index) {
			return '<a href=javascript:ypxxinfo(\'' + row.id + '\')>查看</a>';
		}
	} ] ];

	
	$(function() {
		
		//基本参数
		var options = {
				title : '药品信息列表',
				striped : true,
				url : '${baseurl}/ypml/list_result.action',		//查询所有药品信息，与采购没有关系的
				idField : 'id',//唯一标记一条记录的列的key
				columns : columns,
				pagination : true,
				rownumbers : true,
				toolbar : toolbar,
				pageList:[5,10,15],
				pageSize:5,
				onClickRow : function(index, field, value) {
					$('#ypxxlist').datagrid('unselectRow', index);
				}
			};
		
		//渲染datagrid
		$('#ypxxlist').datagrid(options);
	});

	function ypxxquery() {

		var formdata = $("#ypxxqueryForm").serializeJson();
		$('#ypxxlist').datagrid('load', formdata);
	}

</script>
</HEAD>
<BODY>
<div id="ypxxquery_div">
    <form id="ypxxqueryForm" name="ypxxqueryForm" action="" method="post">
			<TABLE  class="table_search">
				<TBODY>
					<TR>
						
						<TD class="left">通用名：</td>
						<td><INPUT type="text"  name="ypxxQueryCustom.mc" /></TD>
						<TD class="left">剂型：</TD>
						<td ><INPUT type="text" name="ypxxQueryCustom.jx" /></td>
						<TD class="left">规格：</TD>
						<td ><INPUT type="text" name="ypxxQueryCustom.gg" /></td>
						<TD class="left">转换系数：</TD>
						<td ><INPUT type="text" name="ypxxQueryCustom.zhxs" /></td>
					</TR>
					<TR>
						<TD class="left">流水号：</TD>
						<td ><INPUT type="text" name="ypxxQueryCustom.bm" /></td>
						<TD class="left">生产企业：</TD>
						<td ><INPUT type="text" name="ypxxQueryCustom.scqymc" /></td>
						<TD class="left">商品名称：</TD>
						<td ><INPUT type="text" name="ypxxQueryCustom.spmc" /></td>
						 <td class="left">价格范围：</td>
				  		<td>
				      		<INPUT id="ypxxQueryCustom.zbjglower" name="ypxxQueryCustom.zbjglower" style="width:70px"/>
							至
							<INPUT id="ypxxQueryCustom.zbjgupper" name="ypxxQueryCustom.zbjgupper" style="width:70px"/>
							
				 		 </td>
					</tr>
					<tr>
					  
						<TD class="left">药品类别：</TD>
						<td >
							<select id="ypxxQueryCustom.lb" name="ypxxQueryCustom.lb" style="width:150px">
								<option value="">全部</option>
								<c:forEach items="${yplbList}" var="value">
									<option value="${value.id}">${value.info}</option>
								</c:forEach>
							</select>
						</td>
						<TD class="left">交易状态：</TD>
						<td >
							<select id="ypxxQueryCustom.jyzt" name="ypxxQueryCustom.jyzt" style="width:150px">
								<option value="">全部</option>
								<c:forEach items="${jyztList}" var="value">
									<option value="${value.id}">${value.info}</option>
								</c:forEach>
							</select>
							
						</td>
						
				 		 <td class="left" height="25">质量层次：</td>
				  		<td>
				  		<select id="ypxxQueryCustom.zlcc" name="ypxxQueryCustom.zlcc" style="width:150px">
								<option value="">全部</option>
								<c:forEach items="${ypzlccList}" var="value">
									<option value="${value.id}">${value.info}</option>
								</c:forEach>
						</select>
					
				  		</td>
						<td colspan=2 >
							<a id="btn" href="#" onclick="ypxxquery()" class="easyui-linkbutton" iconCls='icon-search'>查询</a>
						</td>
					</TR>
					
				</TBODY>
			</TABLE>
	    </form>
		<TABLE border=0 cellSpacing=0 cellPadding=0 width="99%" align=center>
		<TBODY>
			<TR>
				<TD>
					<table id="ypxxlist"></table>
				</TD>
			</TR>
		</TBODY>
	</TABLE>
</div>
<form id="addyycgdmxForm" action="${baseurl}/cgd/addyycgdmx_submit.action" method="post">
	<!-- 采购单id -->
	<input  name="yycgdCustom.id" value="${yycgdCustom.id }">
	<!-- 所有勾选药品信息id 
		* 提交 多组 <input name="ypxxids" value="1">
		* 服务器只需要提供 String[] ypxxids 或 List<String> ypxxids 就可以获得所有的数据
		<input name="ypxxids" value="1">
		<input name="ypxxids" value="2">
		<input name="ypxxids" value="3">
	-->
</form>

</BODY>
</HTML>

