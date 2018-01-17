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
		function submitForm(){
			var a="1234";
			//提交表单
			//jquerySubByFId("formId" ,submitForm_callback ,a,"json",true);
			jquerySubByFId("formId" ,submitForm_callback);
			
		}
		// 提交回调函数
		function submitForm_callback(data,a){
			alert(data)
		}
	</script>
	
<title>Insert title here</title>
</head>
<body>
	<form id="formId" action="${baseurl}/testAction.action" >
		<input type="text" name="username" value="jack" /> <br/>
		<input type="password" name="password" value="1234" /> <br/>
		<input onclick="submitForm()" type="button" value="提交" /> 
	</form>
	
</body>
</html>