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
<%--根据玩家UID查询用户信息--%>
<form id="showinfobyidForm" name="showinfobyidForm" method="post" action="${baseurl}/user/listbagitem">
    <TABLE class="table_search">
        <TBODY>
        <TR>
            <TD class="left">玩家UID：</td>
            <td><INPUT type="text" name="uid" value="${uid}"/></TD>
            <TD class="left">装备ID：</td>
            <td><INPUT type="text" name="goodsId" value="${goodsId}"/></TD>
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
                <button type="submit" id="btn" href="#" class="easyui-linkbutton" iconCls='icon-search'>查询装备</button>
            </td>
        </TR>
        </TBODY>
    </TABLE>
</form>

<%--信息展示--%>
<div style="height: 300px">
    <div class="list">背包列表：</div>
    <table border="0" cellspacing="0" cellpadding="0" width="80%" >
        <thead>
        <tr>
            <th>goodsId</th>
            <th>数量</th>
        </tr>
        </thead>
        <tbody>
            <tr>
                <td>${itemId}</td>
                <td>${goodsCount}</td>
            </tr>
        </tbody>
    </table>
</div>

<table>
    <tr>
        <td>
            <%--给玩家加物品--%>
            <form id="addpayingotForm" name="addpayingotForm" method="post" action="${baseurl}/user/itemManage"
                  onsubmit="return submit_sure()">
                <TABLE class="table_search">
                    <TBODY>
                    <TR>
                        <td>物品</td>
                        <td>
                            <INPUT type="text" name="serverId" value="${serverId}" style="display:none"/>
                            <INPUT type="text" name="cmd" value="additem" style="display:none"/>
                            <INPUT type="text" name="uid" value="${uid}" style="display:none"/>
                            <INPUT type="text" name="goodsId" value="${goodsId}" style="display:none"/>
                            <INPUT type="text" name="num" value="" placeholder="数量"/>
                            <button type="submit"  href="#" class="easyui-linkbutton" iconCls="icon-add">增加</button>
                        </td>
                    </TR>
                    </TBODY>
                </TABLE>
            </form>
        </td>
        <td width="10%"></td>
        <td>
            <%--给玩家减物品--%>
            <form id="delpayingotForm" name="delpayingotForm" method="post" action="${baseurl}/user/itemManage"
                  onsubmit="return submit_sure()">
                <TABLE class="table_search">
                    <TBODY>
                    <TR>
                        <td>物品</td>
                        <td>
                            <INPUT type="text" name="serverId" value="${serverId}" style="display:none"/>
                            <INPUT type="text" name="cmd" value="delitem" style="display:none"/>
                            <INPUT type="text" name="uid" value="${uid}" style="display:none"/>
                            <INPUT type="text" name="goodsId" value="${goodsId}" style="display:none"/>
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