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
    <title>还款订单</title>
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
                            <a href="javascript:back();" class="btn btn-xs btn-icon btn-circle btn-default"
                               ><i class="fa fa-expand"></i></a>
                            <a href="javascript:search();" class="btn btn-xs btn-icon btn-circle btn-success"><i
                                    class="fa fa-repeat"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger"
                               data-click="panel-remove"><i class="fa fa-times"></i></a>
                        </div>
                        <h4 class="panel-title"> 表格 </h4>
                    </div>
                    <div class="panel-body">
                        <div>

                            <table class="table" >
                                <tr>
                                    <td><span style="position: relative;top: 22px;">订单号</span>
                                        <input type="text" class="form-control" id="orderId" placeholder="查询条件：订单号"
                                               style="width: 150px;height: 30px;position: relative;left:40px;"></td>

                                    <td><span style="position: relative; top: 22px;">砍头息</span>
                                        <select id ="behead" class="form-control" style="width: 120px;height: 30px;position: relative;left:40px;">
                                            <option value="">请选择</option>
                                            <option value="1">是</option>
                                            <option value="0">否</option>
                                        </select>
                                    </td>

                                    <td><span style="position: relative; top: 22px;">是否免息</span>
                                        <select id ="freeInterest" class="form-control" style="width: 120px;height: 30px;position: relative;left:50px;">
                                            <option value="">请选择</option>
                                            <option value="1">是</option>
                                            <option value="0">否</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <span style="position: relative;top: 18px;">下单时间</span>
                                        <input type="text" class="form-control" id="orderTime"
                                               style="width: 200px;top: 18px;position: relative;display:inline">&nbsp;&nbsp;
                                        <input type="text" class="form-control" id="orderTimeEnd"
                                               style="width: 200px;top: 18px;position: relative;display:inline">
                                    </td>
                                    <td>
                                        <button type="button" class="btn btn-primary" onclick="search()"
                                                style="position: relative;top: 12px;">查询
                                        </button>
                                    </td>
                                </tr>
                            </table>

                            <table id="gadtable" class="table table-striped table-bordered">
                                <thead>
                                <tr>
                                    <th>订单号</th>
                                    <th>下单时间</th>
                                    <th>金额</th>
                                    <th>月数/天数</th>
                                    <th>产品类型</th>
                                    <th>还款日</th>
                                    <th>利率</th>
                                    <th>是否砍头息</th>
                                    <th>是否免息</th>
                                    <th>来源</th>
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
<%--<script src="/static/pages/repayplan/list.js"></script>--%>
<%--<script src="/static/js/bootstrap-table.min.js"></script>--%>
<%--<script src="/static/js/bootstrap-table-zh-CN.js"></script>--%>
<!-- ================== END PAGE LEVEL JS ================== -->

<script>

    $(document).ready(function () {
        App.init();
        TableManageFixedHeader.init();
        datainit();
    });

    var table;
    $(document).ready(function () {
        table = $("#gadtable").DataTable({
            "pagingType": "simple_numbers",//设置分页控件的模式
            searching: false,//屏蔽datatales的查询框
            aLengthMenu: [10],//设置一页展示10条记录
            "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
            "oLanguage": {  //对表格国际化
                "sLengthMenu": "每页显示 _MENU_条",
                "sZeroRecords": "没有找到符合条件的数据",
                "sInfo": "当前第 _START_ - _END_ 条　共计 _TOTAL_ 条",
                "sInfoEmpty": "木有记录",
                "sInfoFiltered": "(从 _MAX_ 条记录中过滤)",
                "sSearch": "搜索：",
                "oPaginate": {
                    "sFirst": "首页",
                    "sPrevious": "前一页",
                    "sNext": "后一页",
                    "sLast": "尾页"

                }
            },
            "serverSide": true,//打开后台分页
            "ajax": {
                "url": "/validorder/queryTableData",
                "dataSrc": "aaData",
                "data": function (params) {
                    params.orderId = $('#orderId').val();
                    params.behead = $('#behead').val();
                    params.freeInterest = $('#freeInterest').val();
                    params.orderTime = $('#orderTime').val();
                    params.orderTimeEnd = $('#orderTimeEnd').val();

                }
            },
            "columns": [
                {"data": "orderId"},
                {"data": "storeOrderTime"},
                {"data": "amount"},
                {"data": "period"},
                {"data": "type",
                    "render":function(data) {
                        switch (data){
                            case 1:return "随手借";   break;
                            case 2:return "白条";     break;
                            case 3:return "商城";     break;
                            default:return "未知状态"
                        }
                    }
                },//产品类型
                {"data": "repayDate"},
                {"data": "rate"},
                {"data": "behead",
                    "render":function(data) {
                        switch (data){
                            case 0:return "否"; break;
                            case 1:return "是"; break;
                            default:return "未知状态"
                        }
                    }
                },//是否砍头息
                {"data": "freeInterest",
                    "render":function(data) {
                        switch (data){
                            case 0:return "否"; break;
                            case 1:return "是"; break;
                            default:return "未知状态"
                        }
                    }
                },//是否免息
                {"data": "source",
                    "render":function(data) {
                        switch (data){
                            case 0:return "PC"; break;
                            case 1:return "微信"; break;
                            case 2:return "商城"; break;
                            default:return "未知状态"
                        }
                    }
                }//来源
            ],
            "order": [[ 1, "desc" ]],
            "columnDefs": [{
                // 定义操作列
                "targets":10,//操作按钮目标列标
                "data": null,
                "render": function (data, type, row) {
                    var orderId = '"' + row.orderId + '"';
                    var html = "<a href='javascript:void(0);' onclick='todetail(" + orderId + ")' class='btn-link'>查看还款计划详情</a>&nbsp;&nbsp;&nbsp;&nbsp;"
                    return html;
                }
            }]

        });
    });


    //去往查看还款计划详情
    function todetail(orderId){
        window.location.href="<%=path%>/validorder/todetail/"+orderId;
    }

    function search() {
        table.ajax.reload();
    }

    function back(){
        history.go(-1);
    }

    //时间控件
    function datainit(){
        $("#orderTime,#orderTimeEnd").datepicker({
            language: "zh-CN",
            format:"yyyy-mm-dd",
            autoclose: true,
            todayHighlight: true,
            endDate : new Date(),
            todayBtn:'linked'
        });
    }

</script>
</body>
</html>
