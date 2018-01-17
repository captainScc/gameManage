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

	//普通列描述
	var col_arr = [[
	                {field:'id',title:'采购单编号',width:100},
	                {field:'mc',title:'采购单名称',width:200},
	                {field:'cjsj',title:'创建时间',width:200,
	                	formatter:function(value ,rows, index){
	                		/*
	                		//自定义 js 时间格式化
	                		//1 获得时间对象
	                		var date = new Date(value);
	                		//2 通过不同函数获得具体信息
	                		var year = date.getFullYear();
	                		var month = date.getMonth() + 1;
	                		var day = date.getDate();
	                		return year + "-" + month + "-" + day;
	                		*/
	                		
	                		//直接使用api
	                		var date = new Date(value);
	                		return date.toLocaleString();
	                	}
	                },
	                {field:'xgsj',title:'修改时间',width:100},
	                
	                {field:'tjsj',title:'提交时间',width:100},
	                {field:'shsj',title:'审核时间',width:100},
	                {field:'sysDictInfoByzt',title:'采购单状态',width:100,
	                	formatter:function(value,rows,index){
	                		return value.info;
	                	}
	                },
	                {field:'edit',title:'修改',width:40,
	                	formatter:function(value,rows,index){
	                		//只有 未提交和 审核未通过 才可以修改
	                		var ztId = rows.sysDictInfoByzt.id;
	                		if( ztId == '01001' ||  ztId == '01004'){
		                		return "<a href='javascript:void(0)' onclick=\"edityycgd('"+rows.id+"')\">修改</a>";
	                		}
	                	}
	                },
	                ]];
	
	//工具条
	var bar_arr = [];

	//基本参数
	var options = {
			url:'${baseurl}/cgd/list_result.action',
			columns:col_arr,
			width:'100%',
			height:500,
			title:'采购单列表',
			rownumbers:true,				//行号
			pagination:true,				//分页
			toolbar:bar_arr,				//工具条
	};

	$(function(){
		
		
		//渲染datagrid
		$("#yycgdlist").datagrid(options);
	});
	
	//编辑采购单
	function edityycgd(id){
		//打开一个选项卡，标题“id + 采购单修改”
		var title = id + "采购单修改";
		parent.opentabwindow(title,"${baseurl}/cgd/edit.action?yycgdCustom.id=" + id)
	}
	
</script>
<title>维护采购单</title>
</head>
<body>
<!-- 查询条件 -->
<form id="yycgdqueryForm" name="yycgdqueryForm" method="post" action="">
			<TABLE class="table_search">
				<TBODY>
					<TR>
						<TD class="left">采购单号</td>
						<td><INPUT type="text" name="yycgdQueryCustom.yycgdbm" /></TD>
						<TD class="left"></TD>
						<td></TD>

						<TD class="left">采购单状态：</TD>
						<td>
							<select name="yycgdQueryCustom.sysDictInfoByzt.id">
								<option value="">请选择</option>
								<!--groupList就是模型对象中的属性 -->
								<c:forEach items="${yycgdZtList}" var="dictinfo">
								  <option value="${dictinfo.id}">${dictinfo.info}</option>
								</c:forEach>
								
							</select>
						</TD>
						<td >
						<a id="btn" href="#" onclick="yycgdquery()"
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
						<table id="yycgdlist"></table>
					</TD>
				</TR>
			</TBODY>
		</TABLE>
</body>
</html>