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
            $("#serverId").change(function() {
                gameType = $("#serverId option:selected").html();
            });
            $("#serverId").val("${serverId}");
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
<%--根据玩家UID查询玩家权限状态--%>
<form id="checkForm" name="checkForm" method="post" action="${baseurl}/user/check">
    <TABLE class="table_search">
        <TBODY>
        <TR>
            <TD class="left">玩家UID：</td>
            <td><INPUT type="text" name="uid" value="${uid}"/></TD>
            <TD class="left">选择区服：</TD>
            <td>
                <select id="serverId" name="serverId">
                    <option value="">请选择</option>
                    <option value="1001">测试服</option>
                    <%--<c:forEach items="${userGroupList}" var="dictinfo">
                        <option value="${dictinfo.id}">${dictinfo.info}</option>
                    </c:forEach>--%>
                </select>
            </TD>
            <td>
                <button type="submit" id="btn" href="#" class="easyui-linkbutton" iconCls='icon-search'>查询当前状况</button>
            </td>
        </TR>
        </TBODY>
    </TABLE>
</form>
<div id="cc" class="easyui-calendar"></div>
<table>
    <tr>
        <td>
            <%--信息展示--%>
            <div style="height: 30px">
                <div>停封状况：${lockStatus}</div>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <%--给玩家加物品--%>
            <form id="addpayingotForm" name="addpayingotForm" method="post" action="${baseurl}/user/lock"
                  onsubmit="return submit_sure()">

                <INPUT type="text" name="serverId" value="${serverId}" style="display:none"/>
                <INPUT type="text" name="cmd" value="lock" style="display:none"/>
                <INPUT type="text" name="uid" value="${uid}" style="display:none"/>
                冻结结束时间（秒，0：为永久冻结）:
                <INPUT type="text" name="lockTime" value=""/><br/>
                冻结理由（不填为默认理由:账号异常）:
                <INPUT type="text" name="lockReason" value=""/><br/>
                <button type="submit"  href="#" class="easyui-linkbutton" iconCls="icon-no">冻结</button>
                <a href="${baseurl}/user/authManage?uid=${uid}&serverId=${serverId}&cmd=unlock"
                   class="easyui-linkbutton" data-options="iconCls:'icon-ok'">解冻</a>
                <a href="${baseurl}/user/authManage?uid=${uid}&serverId=${serverId}&cmd=kick"
                   class="easyui-linkbutton" data-options="iconCls:'icon-remove'">强制下线</a>
            </form>
        </td>
    </tr>
    <tr style="height: 50px">
        <td></td>
    </tr>
    <tr><%--信息展示--%>
        <td>
            <div style="height: 30px">
                <div class="list">禁言状况：${speakStatus}</div>
            </div>
        </td>
    </tr>

    <tr>
        <td>
            <%--给玩家加物品--%>
            <form id="addpayingotForm" name="addpayingotForm" method="post" action="${baseurl}/user/jinyan"
                  onsubmit="return submit_sure()">
                <INPUT type="text" name="serverId" value="${serverId}" style="display:none"/>
                <INPUT type="text" name="cmd" value="jinyan" style="display:none"/>
                <INPUT type="text" name="uid" value="${uid}" style="display:none"/>
                公聊屏蔽截止日期：
                <INPUT id="utilTime" name="utilTime"
                       class="easyui-datetimebox"  data-options="sharedCalendar:'#cc'"/>
                <button type="submit"  href="#" class="easyui-linkbutton" iconCls="icon-no">禁言</button>
                <a href="${baseurl}/user/authManage?uid=${uid}&serverId=${serverId}&cmd=unjinyan" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">解禁</a>
            </form>
        </td>
    </tr>
</table>
</div>
</body>
</html>