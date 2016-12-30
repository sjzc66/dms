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
    <title>额度审批详情</title>
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

        <input type="hidden" id="orderId" value="${orderId}">
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
                        <h4 class="panel-title">信息详情</h4>
                    </div>
                    <div class="panel-body">
                        <div class="table-responsive">
                            <table width="958" height="150" border="0">
                                <tr>
                                    <td colspan="6">
                                        <div align="center">
                                           <strong>订单详情</strong>
                                        </div>
                                        <div align="right">
                                            <a href="#" onclick="javascript:history.go(-1)">返回</a>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="5">额度申请单号：${approvalDetails.quotaApproval.orderId}                                  </td>
                                    <td>下单时间：<fmt:formatDate type="date" value="${approvalDetails.quotaApproval.orderTime}" /></td>
                                </tr>

                                <tr>
                                    <td width="87">申请人：</td>
                                    <td width="169">${approvalDetails.quotaApproval.proposer}</td>
                                    <td width="105">手机：</td>
                                    <td width="206">${approvalDetails.customer.phone}</td>
                                    <td width="88">身份证：</td>
                                    <td width="262">${approvalDetails.customer.idCard}</td>
                                </tr>
                                <tr>
                                    <td>白条额度：</td>
                                    <td>${approvalDetails.customer.whiteLine}</td>
                                    <td>还款日：</td>
                                    <td> <fmt:formatDate type="date" value="${approvalDetails.quotaApproval.repayDate}"/></td>

                                </tr>

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
<!-- ================== END PAGE LEVEL JS ================== -->
<script>
    $(document).ready(function () {
        App.init();
        TableManageFixedHeader.init();
    });

    //查询
    function search() {
        table.ajax.reload();
    }
</script>
</body>
</html>


