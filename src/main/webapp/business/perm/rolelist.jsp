<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/tag.jsp"%>
<html>
<head>
<title>角色列表</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">

<%@ include file="/common/common_css.jsp"%>
<%@ include file="/common/common_js.jsp"%>

<script type="text/javascript">
	
   function authorize_role(id) {
		//alert(id);
		var sendUrl = "${baseurl}/perm/roleauth.action?sysRoleQueryCustom.id="+id;
		createmodalwindow("角色权限授权", 800, 450, sendUrl);
	};

	//工具栏
	var toolbar = [ /* {
		id : 'authorize_role',
		text : '角色权限授权',
		iconCls : 'icon-add',
		handler : authorize_role
	}  */];

	var frozenColumns;

	var columns = [ [ /* {
		field : 'id',
		title : '',
		checkbox : true
	}, */ {
		field : 'name',
		title : '角色名称',
		width : 180
	}, {
		field : 'opt1',
		title : '角色授权',
		width : 130,
		formatter:function(value,row,index){
			//return "<a href='${baseurl}/roleauth/roleauth.action?roleId="+row.id+"' target='_blank'>角色授权</a>";
			return "<a href=javascript:authorize_role('"+row.id+"')>角色授权</a>";
		}
	}  ] ];

	function initGrid() {
		$('#sysrolelist').datagrid({
			title : '系统角色列表',
			//nowrap : false,
			striped : true,
			//collapsible : true,
			url : '${baseurl}/perm/rolelist_result.action',
			//sortName : 'code',
			//sortOrder : 'desc',
			//remoteSort : false,
			idField : 'id',
			//frozenColumns : frozenColumns,
			columns : columns,
			pagination : true,
			rownumbers : true,
			//toolbar : toolbar,
			//loadMsg : "",
			//pageList : [ 15, 30, 50, 100 ],
			onClickRow : function(index, field, value) {
				$('#sysrolelist').datagrid('unselectRow', index);
			}
		});

	}
	
	function sysrolelistquery() {

		var formdata = $("#sysrolequeryForm").serializeJson();
		//alert(formdata);
		$('#sysrolelist').datagrid('unselectAll');
		$('#sysrolelist').datagrid('load', formdata);
	}

	
	$(function() {
		initGrid();
		
	});


	
</script>
</HEAD>
<BODY>
	<div id="sysrolequery_div">

		<TABLE border=0 cellSpacing=0 cellPadding=0 width="99%" align=center>
			<TBODY>
				<TR>
					<TD>
						<table id="sysrolelist"></table>
					</TD>
				</TR>
			</TBODY>
		</TABLE>
	</div>


</BODY>
</HTML>

