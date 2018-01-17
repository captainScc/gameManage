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
	//普通列
	var col_arr=[[
	              {
	            	  field:'id',
	            	  checkbox:true
	              },
	              {field:'bm',title:'流水号',width:100,
	            	  formatter:function(value,rows,index){
	            		  return rows.ypxx.bm;
	            	  }
	              },
	              {field:'mc',title:'通用名',width:100,
	            	  formatter:function(value,rows,index){
	            		  return rows.ypxx.mc;
	            	  }
	              },
	              {field:'jx',title:'剂型',width:100,
	            	  formatter:function(value,rows,index){
	            		  return rows.ypxx.jx;
	            	  }
	              },
	              {field:'gg',title:'规格',width:100,
	            	  formatter:function(value,rows,index){
	            		  return rows.ypxx.gg;
	            	  }
	              },
	              {field:'zhxs',title:'转换系数',width:100,
	            	  formatter:function(value,rows,index){
	            		  return rows.ypxx.zhxs;
	            	  }
	              },
	              {field:'zbjg',title:'中标价格',width:100},
	              {field:'sysDictInfoCgzt',title:'交易状态',width:100,
	            	  formatter:function(value,row,index){
	            		  return value.info;
	            	  }
	              },
	              {field:'cgl',title:'采购量',width:100,
	            	  //标准写法
	            	  /*editor:{
	            		  type:'numberbox',		//类型
	            		  options:{				//每一个类型对应参数
	            			  precision:1		//小数位数
	            		  }	
	            	  }*/
	            	  // 简化写法
	            	  editor:'numberbox'
	              },
	              {field:'cgje',title:'采购金额',width:100},
	              ]];
	//工具条
	var bar_arr=[
		{
			id : 'yycgdmxaddshow',
			text : '采购药品添加',
			iconCls : 'icon-add',
			handler : yycgdmxaddshow
		}
		,{
			id : 'yycgdmxdelete',
			text : '采购药品删除',
			iconCls : 'icon-add',
			handler : yycgdmxdelete
		}
		,{
			id : 'yycgdmxcglsave',
			text : '保存采购量',
			iconCls : 'icon-add',
			handler : yycgdmxcglsave
		}  
	];

$(function (){
	
	//***********按钮**************
	$('#submitbtn').linkbutton({   
		iconCls: 'icon-ok'  
	});  
	$('#closebtn').linkbutton({   
		iconCls: 'icon-cancel'  
	});
	
	
	// 基本参数
	var options = {
			title:'采购单明细列表',
			url:'${baseurl}/cgd/yycgdmx_result.action',
			queryParams:{				//额外查询条件
				"yycgdQueryCustom.id":"${yycgdCustom.id }"
			},	
			columns:col_arr,
			width:'100%',
			rownumbers:true,				//行号
			pagination:true,				//分页
			toolbar:bar_arr,				//工具条
			onClickRow:onClickRow			//行点击事件
	};
	
	
	//加载datagrid
	$('#yycgdmxlist').datagrid(options);
});

	//datagrid行点击事件
	// * 记录当前编辑行
	var editIndex = undefined;
	// 结束之前的编辑
	function endEditing(){
		if (editIndex == undefined){return true}
		//校验之前处于编辑状态行
		if ($('#yycgdmxlist').datagrid('validateRow', editIndex)){
			//结束当前编辑状态
			$('#yycgdmxlist').datagrid('endEdit', editIndex);
			editIndex = undefined;
			return true;
		} else {
			return false;
		}
	}
	function onClickRow(index){
		//点击不同行进行操作
		if (editIndex != index){
			if (endEditing()){
				$('#yycgdmxlist').datagrid('selectRow', index)
						.datagrid('beginEdit', index);
				editIndex = index;
			} else {
				//选择编辑行
				$('#yycgdmxlist').datagrid('selectRow', editIndex);
			}
		}
	}


	//添加药品--显示所有药品信息
	function yycgdmxaddshow(){
		//打开一个window
		createmodalwindow("显示药品信息列表","1000","400","${baseurl}/cgd/addyycgdmx.action?yycgdCustom.id=${yycgdCustom.id}");
	}
	
	//删除药品
	function yycgdmxdelete(){
		
	}
	
	//采购量保存
	function yycgdmxcglsave(){
		//手动结束编辑
		endEditing();
		
		//1 获得修改的信息
		var updateArray = $('#yycgdmxlist').datagrid('getChanges', "updated");
		if(updateArray.length == 0){
			//alert("没有勾选");
			alert_warn("没有修改内容");
			return;
		}
		
		$("input[name='mxIds']").remove();
		$("input[name='mxCgls']").remove();
		
		//2 动态向表单添加数据
		//<input name="mxIds" value="1">
		//<input name="mxCgls" value="10">
		$.each(updateArray,function(){
			$("#edityycgdmxcglForm").append("<input name='mxIds' value='"+this.id+"'>");
			$("#edityycgdmxcglForm").append("<input name='mxCgls' value='"+this.cgl+"'>");
		});
		
		//3 提交表单
		jquerySubByFId("edityycgdmxcglForm",yycgdmxcglsave_callback);
		
	}
	function yycgdmxcglsave_callback(data){
		message_alert(data, yycgdmxquery);
	}
	
	
	//采购单明细查询条件
	function yycgdmxquery(){
		//1 将表单所有的条件转换json
		var params = $("#yycgdmxForm").serializeJson();
		//2 通知datagrid重新加载数据即可
		// * 注意：重新加载时，额外数据将清除。需要在表单中添加隐藏字段
		$('#yycgdmxlist').datagrid("load",params);
	}
	
	//提交采购单
	function yycgdsubmit(){
		jquerySubByFId("yycgdsubmitForm",yycgdsubmit_callback);
	}
	function yycgdsubmit_callback(data){
		message_alert(data); //location.href
	}

</script>
<title>添加采购单</title>
</head>
<body>
<!-- 采购单基本信息start -->
<form id="yycgdform" action="${baseurl }/cgd/submit.action" method="post">
<!-- 采购单id -->
<input type="hidden" name="yycgdCustom.id" value="${yycgdCustom.id }"/>

<TABLE border=0 cellSpacing=0 cellPadding=0 width="70%" bgColor=#c4d8ed align=center>
	<TBODY>
		<TR>
				<TD  width="100%">
					<TABLE cellSpacing=0 cellPadding=0 width="100%">
						<TBODY>
							<TR>
								<TD>&nbsp;编辑采购单</TD>
								<TD align=right>&nbsp;</TD>
							</TR>
						</TBODY>
					</TABLE>
				</TD>
			</TR>
			<TR>
				<TD>
					<TABLE class="toptable grid" border=1 cellSpacing=1 cellPadding=4
						align=center>
						<TBODY>
							<TR>
								<TD height=30 width="15%" align=right >采购单号：</TD>
								<TD class=category width="35%"> 
								${yycgdCustom.id }
								</TD>
								<TD height=30 width="15%" align=right >采购单名称：</TD>
								<TD class=category width="35%">
								${yycgdCustom.mc }
								</TD>
							</TR>
							<TR>
							   <TD height=30 width="15%" align=right >建单时间：</TD>
								<TD class=category width="35%">
									<fmt:formatDate value="${yycgdCustom.cjsj}" pattern="yyyy-MM-dd HH:mm:ss:SSS"/>
								</TD>
								<TD height=30 width="15%" align=right >提交时间：</TD>
								<TD class=category width="35%">
								<fmt:formatDate value="${yycgdCustom.tjsj}" pattern="yyyy-MM-dd"/>
								</TD>
								
							</TR>
								<TR>
								<TD height=30 width="15%" align=right>联系人：</TD>
								<TD class=category width="35%">
								<input type="text" name="yycgd.lxr" id="yycgd.lxr" value="${yycgdCustom.lxr}"  style="width:260px" />
								</TD>
								<TD height=30 width="15%" align=right >联系电话：</TD>
								<TD class=category width="35%">
								<input type="text" name="yycgd.lxdh" id="yycgd.lxdh" value="${yycgdCustom.lxdh}"  style="width:260px" />
								</TD>
							</TR>
							<TR>
								<TD height=30 width="15%" align=right>采购单状态：</TD>
								<TD class=category width="35%">
								${yycgdCustom.sysDictInfoByzt.info}
								</TD>
								<TD height=30 width="15%" align=right>备注：</TD>
								<TD colspan=3>
									<textarea rows="2" cols="30" name="yycgd.bz">${yycgdCustom.bz}</textarea>
								</TD>
							</TR>
							
							<TR>
								<TD height=30 width="15%" align=right>审核时间：</TD>
								<TD class=category width="35%">
								<fmt:formatDate value="${yycgdCustom.shsj}" pattern="yyyy-MM-dd"/>
								</TD>
								<TD height=30 width="15%" align=right >审核意见：</TD>
								<TD class=category width="35%">
								${yycgdCustom.shyj}
								</TD>
							</TR>
							
							<tr>
							  <td colspan=4 align=center class=category>
								<a  href="#" onclick="yycgdsave()" class="easyui-linkbutton" iconCls='icon-save'>保存</a>
							    <a  href="#" onclick="yycgdsubmit()" class="easyui-linkbutton" iconCls='icon-save'>提交</a>
							  </td>
							</tr>
						</TBODY>
					</TABLE>
				</TD>
		    </TR>
	</TBODY>
</TABLE>

</form>
<!-- 采购单基本信息end -->


<!-- 明细查询条件start -->
<form id="yycgdmxForm" action="${baseurl }/cgd/saveyycgdmx.action" method="post">
	<!-- 存放采购单id -->
	<input type="hidden" name="yycgdQueryCustom.id" value="${yycgdCustom.id}" />
	
<TABLE border=0 cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed>
		<TBODY>
			<TR>
				<TD background=images/r_0.gif width="100%">
					<TABLE cellSpacing=0 cellPadding=0 width="100%">
						<TBODY>
							<TR>
								<TD>&nbsp;采购药品列表</TD>
								<TD align=right>&nbsp;</TD>
							</TR>
						</TBODY>
					</TABLE>
				</TD>
			</TR>
		</TBODY>
	</TABLE>
<TABLE  class="table_search">
				<TBODY>
					<TR>
						
						<TD class="left">通用名：</td>
						<td><INPUT type="text"  name="yycgdMxQueryCustom.ypxx.mc" /></TD>
						<TD class="left">剂型：</TD>
						<td ><INPUT type="text" name="yycgdMxQueryCustom.ypxx.jx" /></td>
						<TD class="left">规格：</TD>
						<td ><INPUT type="text" name="yycgdMxQueryCustom.ypxx.gg" /></td>
						<TD class="left">转换系数：</TD>
						<td ><INPUT type="text" name="yycgdMxQueryCustom.ypxx.zhxs" /></td>
					</TR>
					<TR>
						<TD class="left">流水号：</TD>
						<td ><INPUT type="text" name="yycgdMxQueryCustom.ypxx.bm" /></td>
						<TD class="left">生产企业：</TD>
						<td ><INPUT type="text" name="yycgdMxQueryCustom.ypxx.scqymc" /></td>
						<TD class="left">商品名称：</TD>
						<td ><INPUT type="text" name="yycgdMxQueryCustom.ypxx.spmc" /></td>
						 <td class="left">价格范围：</td>
				  		<td>
				      		<INPUT id="yycgdMxQueryCustom.zbjeStart" name="yycgdMxQueryCustom.zbjeStart" style="width:70px"/>
							至
							<INPUT id="yycgdMxQueryCustom.zbjeEnd" name="yycgdMxQueryCustom.zbjeEnd" style="width:70px"/>
							
				 		 </td>
					</tr>
					<tr>
					  
						<TD class="left">药品类别：</TD>
						<td >
							<!-- 药品类别从数据字典中取id作为页面传入action的value -->
							<select id="ypxxCustom.lb" name="ypxxCustom.lb" style="width:150px">
								<option value="">全部</option>
								<c:forEach items="${yplbList}" var="value">
									<option value="${value.id}">${value.info}</option>
								</c:forEach>
							</select>
						</td>
						<TD class="left">交易状态：</TD>
						<td >
						    <!-- 交易状态从数据字典中取出dictcode作为页面传入action的value -->
							<select id="ypxxCustom.jyzt" name="ypxxCustom.jyzt" style="width:150px">
								<option value="">全部</option>
								<c:forEach items="${jyztList}" var="value">
									<option value="${value.dictcode}">${value.info}</option>
								</c:forEach>
							</select>
							
						</td>
						<TD class="left">采购状态：</TD>
						<td >
						   
							<select id="yycgdCustom.cgzt" name="yycgdCustom.cgzt" style="width:150px">
								<option value="">全部</option>
								<c:forEach items="${cgztList}" var="value">
									<option value="${value.dictcode}">${value.info}</option>
								</c:forEach>
							</select>
							
						</td>
				 		<TD class="left">供货状态：</TD>
						<td >
						   
							<select id="gysypmlCustom.control" name="gysypmlCustom.control" style="width:150px">
								<option value="">全部</option>
								<c:forEach items="${ghztList}" var="value">
									<option value="${value.dictcode}">${value.info}</option>
								</c:forEach>
							</select>
							
						</td>

				  		<td colspan=2>
				  		
						<a id="btn" href="#" onclick="yycgdmxquery()" class="easyui-linkbutton" iconCls='icon-search'>查询</a>
				  		</td>
						
					</TR>
					
				</TBODY>
			</TABLE>
			 <!-- datagrid -->
		<TABLE border=0 cellSpacing=0 cellPadding=0 width="99%" align=center>
			<TBODY>
				<TR>
					<TD>
					<!-- 采购单明细列表 -->
						<table id="yycgdmxlist"></table>
					</TD>
				</TR>
			</TBODY>
		</TABLE>
</form>
<!-- 明细查询条件end -->

<!-- 采购量 start -->
<form id="edityycgdmxcglForm" action="${baseurl}/cgd/saveyycgdmxcgl_submit.action" method="post">
	<!-- 采购单id -->
	<input  name="yycgdCustom.id" value="${yycgdCustom.id }">
	<!-- 明细和数据成对的
		<input name="mxIds" value="1">
		<input name="mxCgls" value="10">
		* 需要在服务器上提供两个List获得数据
			List<String> mxIds
			List<String> mxCgls
		
	-->
</form>
<!-- 采购量 end -->


<!-- 提交 start -->
<form id="yycgdsubmitForm" action="${baseurl}/cgd/yycgdsubmit_submit.action" method="post">
	<!-- 采购单id -->
	<input  name="yycgdCustom.id" value="${yycgdCustom.id }">
</form>
<!-- 提交 end -->


</body>
</html>