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
    <title>订单详情</title>
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

        <input type="hidden" id="orderId" value="${presentOrderInfo.presentOrder.orderId}">
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
                        <h4 class="panel-title">订单详情列表 </h4>
                    </div>
                    <div class="panel-body">
                        <div>
                            <table class="table">
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
                                    <td colspan="5">订单号：${presentOrderInfo.presentOrder.orderId}             </td>
                                    <td>下单时间：
                                    <fmt:formatDate value="${presentOrderInfo.presentOrder.orderTime}" type="date"/>
                                    </td>
                                </tr>
                                <!--
                              <tr>
                                  <td colspan="6">
                                      <img id="u46_img" class="img " src="/static/images/transparent.gif"/>
                                  </td>
                              </tr>

                              <tr>
                                  <td colspan="6"><form id="form1" name="form1" method="post" action="">
                                      <label></label>
                                      <label>
                                          <div align="right">
                                              <input type="submit" name="Submit" value="取消订单" />
                                          </div>
                                      </label>
                                  </form></td>
                              </tr>-->
                                <tr>
                                    <td width="87">借款申请人：</td>
                                    <td width="169">0000000000</td>
                                    <td width="105">手机：</td>
                                    <td width="206">${presentOrderInfo.customer.phone}</td>
                                    <td width="88">开户行：</td>
                                    <td width="262">${presentOrderInfo.presentOrder.bankName}</td>
                                </tr>
                                <tr>
                                    <td>提现卡号：</td>
                                    <td>${presentOrderInfo.presentOrder.bankCode}</td>
                                    <td>提现金额：</td>
                                    <td>00000000000</td>
                                    <td>身份证号：</td>
                                    <td>${presentOrderInfo.customer.idCard}</td>
                                </tr>
                                <tr>
                                    <td>分期情况：</td>
                                    <td colspan="5">${presentOrderInfo.presentOrder.periods}期,月供：${presentOrderInfo.presentOrder.monthly}(本金:${presentOrderInfo.repayPlan.principal}+利息:${presentOrderInfo.repayPlan.interest})</td>
                                </tr>
                                <tr>
                                    <td >首次还款日：</td>
                                    <td colspan="5">
                                    <fmt:formatDate value="${presentOrderInfo.presentOrder.repayDate}" type="date"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="6">账单详情</td>
                                </tr>
                            </table>

                            <table id="gadtable" class="table table-striped table-bordered">
                                <thead>
                                <tr>
                                    <th>期数</th>
                                    <th>分期本金</th>
                                    <th>服务费</th>
                                    <th>滞纳金</th>
                                    <th>总金额</th>
                                    <th>还款日</th>
                                    <th>实际还款日</th>
                                    <th>还款状态</th>
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
<script src="/static/pages/order/order_details.js"></script>
<!-- ================== END PAGE LEVEL JS ================== -->
</body>
</html>


