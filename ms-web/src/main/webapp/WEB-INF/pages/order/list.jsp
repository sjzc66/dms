<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if !IE]><!-->
<html lang="zh">
<!--<![endif]-->
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>

<head>
    <meta charset="utf-8"/>
    <title>白条订单</title>
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport"/>
    <meta content="" name="description"/>
    <meta content="" name="author"/>
    <!-- ================== BEGIN BASE CSS STYLE ================== -->
    <jsp:include page="../common/header.jsp"></jsp:include>
    <%@include file="../common/taglib.jsp" %>
    <!-- ================== END BASE CSS STYLE ================== -->

    <!-- ================== 单独作用于本页表格td ================== -->
    <style>
        .table > tbody > tr > td {
            padding: 10px 15px;
            padding-top: 7px;
            padding-right: 15px;
            padding-bottom: 7px;
            padding-left: 15px;
        }
    </style>
    <!-- ================== 单独作用于本页表格td ================== -->

</head>
<body>
<!-- begin #page-loader -->
<div id="page-loader" class="fade in"><span class="spinner"></span></div>
<!-- end #page-loader -->

<!-- begin #page-container -->
<div id="page-container" class="fade page-sidebar-fixed page-header-fixed">
    <jsp:include page="../common/top.jsp"/>

    <!-- begin #sidebar -->
    <jsp:include page="../common/sitebar.jsp"/>
    <div class="sidebar-bg"></div>
    <!-- end #sidebar -->

    <!-- begin #content -->
    <div id="content" class="content">
        <div class="row">
            <!-- begin col-12 -->
            <div class="col-md-12">
                <!-- begin panel -->
                <div class="panel panel-inverse">
                    <div class="panel-heading">
                        <div class="panel-heading-btn">
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-default"
                               data-click="panel-expand"><i class="fa fa-expand"></i></a>
                            <a href="javascript:search();" class="btn btn-xs btn-icon btn-circle btn-success"><i
                                    class="fa fa-repeat"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger"
                               data-click="panel-remove"><i class="fa fa-times"></i></a>
                        </div>
                        <h4 class="panel-title">白条订单列表 </h4>
                    </div>
                    <div class="panel-body">
                        <div>
                            <table class="table">
                                <tr>
                                    <td width="74" height="70"><strong>订单号：</strong></td>
                                    <td width="140">
                                        <label>
                                            <input id="orderId" name="orderId" type="text" size="20"/>
                                        </label>
                                        </form>    </td>
                                    <td width="61"><strong>手机号：</strong></td>
                                    <td width="151"><input id="phone" name="phone" type="text" size="20"/></td>
                                    <td width="61"><strong>姓名：</strong></td>
                                    <td width="163"><input id="username" name="username" type="text" size="20"/></td>
                                    <td width="77"><strong>订单状态：</strong></td>
                                    <td width="195">
                                        <select id="orderStatus" name="orderStatus">
                                            <option value="">请选择</option>
                                            <spring:eval expression="T(com.jzfq.fms.common.enums.PresentOrderStatus).values()" var="presentOrderStatus"></spring:eval>
                                            <c:forEach items="${presentOrderStatus}" var="orderStatus">
                                                <option value="${orderStatus.ordinal()}">${orderStatus.presentOrderStatusName}</option>
                                            </c:forEach>
                                        </select>

                                    </td>
                                </tr>
                                <tr>
                                    <td height="40"><strong>下单时间：</strong></td>
                                    <td colspan="3"><input id="orderTime" name="orderTime" type="text" size="20"/>--
                                        <input id="orderTimeEnd" name="orderTimeEnd" type="text" size="20"/></td>
                                    <td><strong>来源：</strong></td>
                                    <td>
                                        <select id="source" name="source">
                                            <option value="">请选择</option>
                                            <spring:eval expression="T(com.jzfq.fms.common.enums.PresentOrderSource).values()" var="presentOrderSource"></spring:eval>
                                            <c:forEach items="${presentOrderSource}" var="orderSource">
                                                <option value="${orderSource.ordinal()}">${orderSource.presentOrderSourceName}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                    <td colspan="2">
                                        <button type="button" class="btn btn-primary" onclick="search()"
                                                style="position: relative;top:-1px;left:70px;">查询
                                        </button>
                                    </td>
                                </tr>
                            </table>


                            <table id="gadtable" class="table table-striped table-bordered">
                                <thead>
                                <tr>

                                    <th>订单号</th>
                                    <th>下单时间</th>
                                    <th>用户名</th>
                                    <th>手机号</th>
                                    <th>产品名称</th>
                                    <th>月供</th>
                                    <th>来源</th>
                                    <th>订单状态</th>
                                    <th>市场推荐码</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                            </table>

                        </div>
                    </div>
                </div>
                <!-- end panel -->
            </div>
            <!-- end col-12 -->
        </div>
        <!-- end row -->
    </div>
    <!-- end #content -->

</div>
<!-- end page container -->
<jsp:include page="../common/footer.jsp"/>
<script src="/static/pages/order/list.js"></script>
<script>
    //订单详情
    function toInfo(orderId,id){
        window.location.href="<%=path%>/order/orderDetails?orderId="+orderId+"&id="+id;
    }
</script>
</body>
</html>


