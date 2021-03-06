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


function check(id){
	var sendUrl = "${baseurl}/cgd/check.action?yycgdCustom.id="+id;
	createmodalwindow("采购单审核", 800, 300, sendUrl);
}


//工具栏

var toolbar = [];

var columns = [ [
 
 {
	field : 'id',
	title : '采购单编号',
	width : 80
},{
	field : 'mc',
	title : '采购单名称',
	width : 150
},{
	field : 'cjsj',
	title : '建单时间',
	width : 80,
	formatter: function(value,row,index){
		if(value){
			try{
			//通过js日期格式化
			var date = new Date(value);
			var y = date.getFullYear();//获取年
			var m = date.getMonth()+1;//获取月
			var d = date.getDate();
			return y+"-"+m+"-"+d;
			}catch(e){
				alert(e);
			}
		}
		
	}
},{
	field : 'xgsj',
	title : '修改时间',
	width : 80,
	formatter: function(value,row,index){
		if(value){
			try{
			var date = new Date(value);
			var y = date.getFullYear();
			var m = date.getMonth()+1;
			var d = date.getDate();
			return y+"-"+m+"-"+d;
			}catch(e){
				alert(e);
			}
		}
		
	}
},{
	field : 'tjsj',
	title : '提交时间',
	width : 80,
	formatter: function(value,row,index){
		if(value){
			try{
			var date = new Date(value);
			var y = date.getFullYear();
			var m = date.getMonth()+1;
			var d = date.getDate();
			return y+"-"+m+"-"+d;
			}catch(e){
				alert(e);
			}
		}
		
	}
},{
	field : 'shsj',
	title : '审核时间',
	width : 80,
	formatter: function(value,row,index){
		if(value){
			try{
			var date = new Date(value);
			var y = date.getFullYear();
			var m = date.getMonth()+1;
			var d = date.getDate();
			return y+"-"+m+"-"+d;
			}catch(e){
				alert(e);
			}
		}
		
	}
},{
	field : 'cgdztmc',
	title : '采购单<br>状态', 
	width : 60,
	formatter:function(value,row,index){
		return row.sysDictInfoByzt.info;
	}
},{
	field : 'opt2',
	title : '查看',
	width : 60,
	formatter:function(value, row, index){
		return '<a href=javascript:yycgdview("'+row.id+'")>查看</a>';
	}
},{
	field : 'opt3',
	title : '审核',
	width : 60,
	formatter:function(value, row, index){
		return '<a href=javascript:check("'+row.id+'")>审核</a>';
	}
}]];


	$(function() {
		//参数
		var options = {
			title : '采购单列表',
			striped : true,
			url : '${baseurl}/cgd/checklist_result.action',
			queryParams:{//查询参数，只在加载时使用，点击查询使用load重新加载不使用此参数
				//businessyear:'${year}'
			}, 
			idField : 'id',//查询结果集主键采购单id
			columns : columns,
			autoRowHeight:true,
			pagination : true,
			rownumbers : true,
			toolbar : toolbar,
			onClickRow : function(index, field, value) {
				$('#yycgdlist').datagrid('unselectRow', index);
			}
		};
		
		//渲染
		$('#yycgdlist').datagrid(options);
	});

	function yycgdquery() {
		var formdata = $("#yycgdqueryForm").serializeJson();//将form中的input数据取出来
		//alert(formdata);
		$('#yycgdlist').datagrid('load', formdata);
	}
	

	
	$(function(){
		//加载采购单状态
		//getDictinfoCodelist('010','yycgdCustom.zt');
		//加载年
		//businessyearlist('businessyear');
	

	});
</script>
</HEAD>
<BODY>
    <form id="yycgdqueryForm" name="yycgdqueryForm" method="post" >
			<TABLE  class="table_search">
				<TBODY>
					
					<TR> 
					<TD class="left">采购单编号：</td>
						<td><INPUT type="text"  name="yycgdQueryCustom.id" /></TD>
					<TD class="left">采购单名称：</TD>
						<td ><INPUT type="text" name="yycgdQueryCustom.mc" /></td>
					  <TD class="left">采购单状态：</TD>
						<td >
							<select id="yycgdQueryCustom.zt" name="yycgdQueryCustom.zt" style="width:150px">
							<option value="">全部</option>
								<c:forEach items="${yycgdZtList}" var="dictinfo">
									<option value="${dictinfo.id}">${dictinfo.info}</option>
								</c:forEach>
							</select>
							<a id="btn" href="#" onclick="yycgdquery()" class="easyui-linkbutton" iconCls='icon-search'>查询</a>	
						</td>
						
						
						
					</tr>
					
				</TBODY>
			</TABLE>
	   
		<TABLE border=0 cellSpacing=0 cellPadding=0 width="99%" align=center>
			<TBODY>
				<TR>
					<TD>
						<table id="yycgdlist"></table>
					</TD>
				</TR>
			</TBODY>
		</TABLE>
		 </form>


</BODY>
</HTML>

