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
			
			var url = "${baseurl}/testAction.action";
			/*var params = {
					"username":"jack",
					"password":"1234"
			};*/
			var params = $("#formId").serialize();
			
			/*
				serializeJson() 自定义函数，功能将一个表单中的所有的数据拼凑成 json对象，{k:v,...}
			
				jQuery提供原始函数
					serialize()，功能将一个表单拼凑一个字符串(GET请求支持字符串)，url?k=v&k=v&.... 
					serializeArray() ，功能将一个表单拼凑成一个数组。
						[
						 {"name":"username","value":"jack"},
						 {"name":"password","value":"1234"}
						 ]
			
			
			*/
			
			$.post(url,params,function(data){
				alert("成功");
			},"json");
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