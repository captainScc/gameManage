<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/tag.jsp"%>
<html>
<head>
<title>玩家基本信息查询</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<style>
		td{
			text-align: center;
		}
		
	</style>
<%@ include file="/common/common_css.jsp"%>
<%@ include file="/common/common_js.jsp"%>
	
<script type="text/javascript">
	$(function(){
		//下拉框回显
        $("#server").change(function() {
            gameType = $("#server option:selected").html();
        });
        $("#server2").change(function() {
            gameType = $("#server2 option:selected").html();
        });
        $("#server").val("${serverId}");
        $("#server2").val("${serverId}");
	});

	function submit_sure(){
        var gnl=confirm("确定要提交?");
        if (gnl==true){
            return true;
        }else{
            return false;
        }
    }
</script>
</head>
<body>
<%--根据玩家UID查询用户信息--%>
<form id="showinfobyidForm" name="showinfobyidForm" method="post" action="${baseurl}/user/showinfobyid">
	<TABLE class="table_search">
		<TBODY>
			<TR>
				<TD class="left">玩家UID：</td>
				<td><INPUT type="text" name="uid" value="${uid}"/></TD>
				<TD class="left">选择区服：</TD>
				<td>
					<select id="server" name="serverId">
						<option value="">请选择</option>
						<option value="1001">测试服</option>
						<%--<c:forEach items="${userGroupList}" var="dictinfo">
							<option value="${dictinfo.id}">${dictinfo.info}</option>
						</c:forEach>--%>
					</select>
				</TD>
				<td>
					<button type="submit" id="btn" href="#" class="easyui-linkbutton" iconCls='icon-search'>按UID查询</button>
				</td>
			</TR>
		</TBODY>
	</TABLE>
</form>
<%--根据玩家昵称查询玩家信息--%>
<form id="getidbynickForm" name="getidbynickForm" method="post" action="${baseurl}/user/getidbynick">
	<TABLE class="table_search">
		<TBODY>
			<TR>
				<TD class="left">玩家昵称：</td>
				<td><INPUT type="text" name="nickname" value="${nickname}" /></TD>
				<TD class="left">选择区服：</TD>
				<td>
					<select id="server2" name="serverId">
						<option value="">请选择</option>
						<option value="1001">测试服</option>
						<%--<c:forEach items="${userGroupList}" var="dictinfo">
							<option value="${dictinfo.id}">${dictinfo.info}</option>
						</c:forEach>
	--%>
					</select>
				</TD>
				<td>
					<button type="submit" id="btn2" href="#" class="easyui-linkbutton" iconCls='icon-search'>按昵称查询</button>
				</td>
			</TR>
		</TBODY>
	</TABLE>
</form>

<%--信息展示--%>
<div style="height: 300px">
	<div class="list">列表：</div>
	<table border="0" cellspacing="0" cellpadding="0" width="80%" >
		<thead>
			<tr>
				<th>区服</th>
				<th>UID</th>
				<th>账号</th>
				<th>昵称</th>
				<th>经验值</th>
				<th>等级</th>
				<th>体力</th>
				<th>钻石</th>
				<th>战力</th>
				<th>金币</th>
				<th>公会</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>${serverId}</td>
				<td>${uid}</td>
				<td>${account_id}</td>
				<td>${nickname}</td>
				<td>${exp}</td>
				<td>${level}</td>
				<td>${strength}</td>
				<td>${diamond}</td>
				<td>${power}</td>
				<td>${gold}</td>
				<td>${societyName}</td>
			</tr>
		</tbody>
	</table>
</div>

<table>
	<tr>
		<td width="20%">
			<form id="renameForm" name="renameForm" method="post" action="${baseurl}/user/rename"
				  onsubmit="return submit_sure()">
				<TABLE class="table_search">
					<TBODY>
					<TR>
						<td>昵称重命名</td>
						<td>
							<INPUT type="text" name="serverId" value="${serverId}" style="display:none"/>
							<INPUT type="text" name="cmd" value="rename" style="display:none"/>
							<INPUT type="text" name="uid" value="${uid}" style="display:none"/>
							<INPUT type="text" style="width: 120px" name="newName" value="${newName}" placeholder="玩家新昵称"/>
						</td>
						<td>
							<button type="submit"  href="#" class="easyui-linkbutton" iconCls="icon-edit">修改</button>
						</td>
					</TR>
					</TBODY>
				</TABLE>
			</form>
		</td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td width="20%">
			<%--给玩家加钻石--%>
			<form id="addpayingotForm" name="addpayingotForm" method="post" action="${baseurl}/user/manage"
				  onsubmit="return submit_sure()">
				<TABLE class="table_search">
					<TBODY>
					<TR>
						<td>钻石</td>
						<td>
							<INPUT type="text" name="serverId" value="${serverId}" style="display:none"/>
							<INPUT type="text" name="cmd" value="addpayingot" style="display:none"/>
							<INPUT type="text" name="uid" value="${uid}" style="display:none"/>
							<INPUT type="text" name="num" value="" placeholder="数量"/>
							<button type="submit"  href="#" class="easyui-linkbutton" iconCls="icon-add">增加</button>
						</td>
					</TR>
					</TBODY>
				</TABLE>
			</form>
		</td>
		<td width="10%"></td>
		<td width="20%">
			<%--给玩家减钻石--%>
			<form id="delpayingotForm" name="delpayingotForm" method="post" action="${baseurl}/user/manage"
				  onsubmit="return submit_sure()">
				<TABLE class="table_search">
					<TBODY>
					<TR>
						<td>钻石</td>
						<td>
							<INPUT type="text" name="serverId" value="${serverId}" style="display:none"/>
							<INPUT type="text" name="cmd" value="delpayingot" style="display:none"/>
							<INPUT type="text" name="uid" value="${uid}" style="display:none"/>
							<INPUT type="text" name="num" value="" placeholder="数量"/>
							<button type="submit"  href="#" class="easyui-linkbutton" iconCls="icon-remove">减少</button>
						</td>
					</TR>
					</TBODY>
				</TABLE>
			</form>
		</td>
	</tr>

	<tr>
		<td>
			<%--给玩家加金币--%>
			<form id="addmoneyForm" name="addmoneyForm" method="post" action="${baseurl}/user/manage"
				  onsubmit="return submit_sure()">
				<TABLE class="table_search">
					<TBODY>
					<TR>
						<td>金币</td>
						<td>
							<INPUT type="text" name="serverId" value="${serverId}" style="display:none"/>
							<INPUT type="text" name="cmd" value="addmoney" style="display:none"/>
							<INPUT type="text" name="uid" value="${uid}" style="display:none"/>
							<INPUT type="text" name="num" value="" placeholder="数量"/>
							<button type="submit"  href="#" class="easyui-linkbutton" iconCls="icon-add">增加</button>
						</td>
					</TR>
					</TBODY>
				</TABLE>
			</form>
		</td>
		<td></td>
		<td>
			<%--给玩家减金币--%>
			<form id="delmoneyForm" name="delmoneyForm" method="post" action="${baseurl}/user/manage"
				  onsubmit="return submit_sure()">
				<TABLE class="table_search">
					<TBODY>
					<TR>
						<td>金币</td>
						<td>
							<INPUT type="text" name="serverId" value="${serverId}" style="display:none"/>
							<INPUT type="text" name="cmd" value="delmoney" style="display:none"/>
							<INPUT type="text" name="uid" value="${uid}" style="display:none"/>
							<INPUT type="text" name="num" value="" placeholder="数量"/>
							<button type="submit"  href="#" class="easyui-linkbutton" iconCls="icon-remove">减少</button>
						</td>
					</TR>
					</TBODY>
				</TABLE>
			</form>
		</td>
	</tr>

	<tr>
		<td>
			<%--给玩家加体力--%>
			<form id="addmoneyForm" name="addmoneyForm" method="post" action="${baseurl}/user/manage"
				  onsubmit="return submit_sure()">
				<TABLE class="table_search">
					<TBODY>
					<TR>
						<td>体力</td>
						<td>
							<INPUT type="text" name="serverId" value="${serverId}" style="display:none"/>
							<INPUT type="text" name="cmd" value="addenergy" style="display:none"/>
							<INPUT type="text" name="uid" value="${uid}" style="display:none"/>
							<INPUT type="text" name="num" value="" placeholder="数量"/>
							<button type="submit"  href="#" class="easyui-linkbutton" iconCls="icon-add">增加</button>
						</td>
					</TR>
					</TBODY>
				</TABLE>
			</form>
		</td>
		<td></td>
		<td>
			<%--给玩家减体力--%>
			<form id="delmoneyForm" name="delmoneyForm" method="post" action="${baseurl}/user/manage"
				  onsubmit="return submit_sure()">
				<TABLE class="table_search">
					<TBODY>
					<TR>
						<td>体力</td>
						<td>
							<INPUT type="text" name="serverId" value="${serverId}" style="display:none"/>
							<INPUT type="text" name="cmd" value="delenergy" style="display:none"/>
							<INPUT type="text" name="uid" value="${uid}" style="display:none"/>
							<INPUT type="text" name="num" value="" placeholder="数量"/>
							<button type="submit"  href="#" class="easyui-linkbutton" iconCls="icon-remove">减少</button>
						</td>
					</TR>
					</TBODY>
				</TABLE>
			</form>
		</td>
	</tr>

	<tr>
		<td>
			<%--给玩家加活力--%>
			<form id="addmoneyForm" name="addmoneyForm" method="post" action="${baseurl}/user/manage"
				  onsubmit="return submit_sure()">
				<TABLE class="table_search">
					<TBODY>
					<TR>
						<td>活力</td>
						<td>
							<INPUT type="text" name="serverId" value="${serverId}" style="display:none"/>
							<INPUT type="text" name="cmd" value="addvitality" style="display:none"/>
							<INPUT type="text" name="uid" value="${uid}" style="display:none"/>
							<INPUT type="text" name="num" value="" placeholder="数量"/>
							<button type="submit"  href="#" class="easyui-linkbutton" iconCls="icon-add">增加</button>
						</td>
					</TR>
					</TBODY>
				</TABLE>
			</form>
		</td>
		<td></td>
		<td>
			<%--给玩家减活力--%>
			<form id="delmoneyForm" name="delmoneyForm" method="post" action="${baseurl}/user/manage"
				  onsubmit="return submit_sure()">
				<TABLE class="table_search">
					<TBODY>
					<TR>
						<td>活力</td>
						<td>
							<INPUT type="text" name="serverId" value="${serverId}" style="display:none"/>
							<INPUT type="text" name="cmd" value="delvitality" style="display:none"/>
							<INPUT type="text" name="uid" value="${uid}" style="display:none"/>
							<INPUT type="text" name="num" value="" placeholder="数量"/>
							<button type="submit"  href="#" class="easyui-linkbutton" iconCls="icon-remove">减少</button>
						</td>
					</TR>
					</TBODY>
				</TABLE>
			</form>
		</td>
	</tr>
</table>
</div>
</body>

</html>