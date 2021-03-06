<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<LINK rel="stylesheet" type="text/css"	href="${pageContext.request.contextPath}/js/easyui/themes/default/easyui.css" />
	<LINK rel="stylesheet" type="text/css"	href="${pageContext.request.contextPath}/js/easyui/themes/icon.css">
	<LINK rel="stylesheet" type="text/css"	href="${pageContext.request.contextPath}/js/easyui/styles/default.css">
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js"></script>
	<SCRIPT type="text/javascript" src="${pageContext.request.contextPath}/js/easyui/jquery.easyui.1.4.min.js"></SCRIPT>
	
	<style type="text/css">
		.hover{
			border: 1px dashed rgb(153, 187, 232) !important;
		}
	</style>
	<script type="text/javascript">
		$(function(){
			$(".easyui-accordion a").hover(function(){
				$(this).addClass("hover");
			},function(){
				$(this).removeClass("hover");
			});
		});
	
		
		//添加选项卡
		function addtab(obj,url){
			//获得标题
			var t = $(obj).text();
			
			var options = {    
			    title:t,    
			    content:'<iframe src="'+url+'" frameborder="0" marginheight="0" marginwidth="0" width="100%" height="100%" scrolling="auto"></iframe>',    
			    closable:true   
			};
			
			//如果已经有了将选中，如果没有将添加
			var e = $("#tt").tabs("exists",t);
			if(e){
				$("#tt").tabs("select",t);
				//存在
			} else{
				//不存在，添加
				$('#tt').tabs('add',options);
			}
			
		}
		
	</script>
	
<title>Insert title here</title>
</head>
<body class="easyui-layout">
    <div data-options="region:'north',split:true" style="height:30px;">
    	<div  style="line-height: 20px; overflow: hidden;background: url(${pageContext.request.contextPath}/images/layout-browser-hd-bg.gif) 50% 50% repeat-x rgb(127, 153, 190);">
	    	<img align="absmiddle" src="${pageContext.request.contextPath}/images/blocks.gif" width="20" height="20"> 医药集中采购系统
    	</div>
    
    </div>   
    <div data-options="region:'south',split:true" style="height:30px;background-color: #D2E0F2;">
    	<center>系统版本号：   发布日期：</center>
    </div> 
      
    <div data-options="region:'west',title:'导航菜单',split:true" style="width:200px;" class="easyui-accordion">
    	<!-- 菜单start -->
 
	    <div title="测试菜单" data-options="iconCls:'icon icon-sys'" style="overflow:auto;padding:10px;">   
	        <h3 style="color:#0099FF;">Accordion for jQuery</h3>   
	        <p>Accordion is a part of easyui framework for jQuery.     
	        It lets you define your accordion component on web page more easily.</p>   
	    </div>   
	    <div title="系统管理" data-options="iconCls:'icon-clear',selected:true" style="padding:10px;">   
	        <a href="#" onclick="addtab(this,'${pageContext.request.contextPath}/user/findById.action?sysUserQueryCustom.id=56')" class="easyui-linkbutton" data-options="iconCls:'icon icon-log',plain:true" style="width:90%;text-align: left;  padding-left: 5px;">根据id查询用户</a> 
	        <a href="#" onclick="addtab(this,'http://www.itcast.cn')" class="easyui-linkbutton" data-options="iconCls:'icon icon-log',plain:true" style="width:90%;text-align: left;  padding-left: 5px;">黑马程序员</a> 
	        <a href="#" onclick="addtab(this,'http://www.itheima.com')" class="easyui-linkbutton" data-options="iconCls:'icon icon-log',plain:true" style="width:90%;text-align: left;  padding-left: 5px;">传智播客</a> 
	    </div>   
	    <div title="药品目录">   
	        content3    
	    </div>   
    	
    	<!-- 菜单end -->
    </div>   
    <div id="tt" data-options="region:'center'" style="" class="easyui-tabs">
    
	    <div title="欢迎使用">   
	        tab1    
	    </div>   
    
    </div>   
</body>
</html>