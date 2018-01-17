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
			$('#win').window({    
			    width:600,    
			    height:400,    
			    modal:true,				//模态(模式)   
			    title:'我是标题党',
			    closed:true,			//创建时是否关闭的
			    collapsible:false,		// boolean 定义是否显示可折叠按钮。 true 
			    minimizable:false,		//  boolean 定义是否显示最小化按钮。 true 
			    maximizable:true,		//  boolean 定义是否显示最大化按钮。 true 
			    closable:true,			//  boolean 定义是否显示关闭按钮。 
			    shadow:true,			//显示阴影
			    content:'<iframe src="http://www.itheima.com"/>'				

			});
		});
	
		function openWin(){
			$('#win').window('open');  
		}
	</script>
	
<title>Insert title here</title>
</head>
<body>
	<input type="button" value="点我打开窗口" onclick="openWin()" />	
	
	<div id="win"></div> 
</body>
</html>