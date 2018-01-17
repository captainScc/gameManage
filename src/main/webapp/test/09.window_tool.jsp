<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/tag.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<%@ include file="/common/common_css.jsp"%>
	<%@ include file="/common/common_js.jsp"%>
	
	<script type="text/javascript">
	
	
		function openWin(){
			createmodalwindow("黑马程序员",600,300,"http://www.itheima.com");
		}
	</script>
	
<title>Insert title here</title>
</head>
<body>
	<input type="button" value="点我打开窗口" onclick="openWin()" />	
	
</body>
</html>