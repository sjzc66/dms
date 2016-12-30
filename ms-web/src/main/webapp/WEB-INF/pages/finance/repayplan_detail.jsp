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

        <input type="hidden" id="orderId" value="${orderId}">
        <div class="row">
            <!-- begin col-12 -->
            <div class="col-md-12">
                <!-- begin panel -->
                <div class="panel panel-inverse">
                    <div class="panel-heading">
                        <div class="panel-heading-btn">
                            <a href="javascript:back();" class="btn btn-xs btn-icon btn-circle btn-default">
                                <i class="fa fa-expand"></i></a>
                            <a href="javascript:search();" class="btn btn-xs btn-icon btn-circle btn-success"><i
                                    class="fa fa-repeat"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger"
                               data-click="panel-remove"><i class="fa fa-times"></i></a>
                        </div>
                        <h4 class="panel-title">订单号:<font color="blue">${orderId}</font> ===>还款计划 </h4>
                    </div>
                    <div class="panel-body">
                        <div>
                            <table id="gadtable" class="table table-striped table-bordered">
                                <thead>
                                <tr>
                                    <th>期数</th>
                                    <th>月供</th>
                                    <th>分期本金</th>
                                    <th>服务费(利息)</th>
                                    <th>滞纳金</th>
                                    <th>总金额</th>
                                    <th>还款日</th>
                                    <th>实际还款日</th>
                                    <th>还款状态</th>
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

    <!-- begin dialog -->
    <div class="modal fade" id="repayMyModal" tabindex="-1" role="dialog" aria-labelledby="repayMyModalLabel">
        <form role="form" action="/transflow/add" method="get" data-parsley-validate="true" id="repayDialogForm">

            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                        <h4 class="modal-title" id="myModalLabel">确认还款</h4>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" name="customerId" id="customerId">
                        <input type="hidden" name="orderId2" id="orderId2">
                        <input type="hidden" name="period" id="period">
                        <input type="hidden" name="amount" id="amount">
                        <input type="hidden" name="planid" id="planid">
                        <div class="form-group">
                            <label>本期应还</label>
                            <input type="text" class="form-control input-lg" disabled="disabled" id="sum">
                        </div>
                        <div class="form-group">
                            <label>还款方式</label>
                            <select id="pattern" name="pattern" class="form-control input-lg" data-parsley-required="true" data-parsley-required-message="还款方式不能为空">
                                <option value="">请选择</option>
                                <spring:eval expression="T(com.jzfq.fms.common.enums.RepayPattern).values()" var="repayPattern"></spring:eval>
                                <c:forEach items="${repayPattern}" var="pattern">
                                    <option value="${pattern.ordinal()}">${pattern.pattern}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>交易流水号<span id="spanMessage1"></span></label>
                            <input type="text" name="payid" id="payid" class="form-control input-lg" data-parsley-required="true" data-parsley-required-message="交易流水号不能为空">
                        </div>
                        <div class="form-group">
                            <label>实际还款时间<span id="spanMessage2"></span></label>
                            <input type="text" name="flowTime" id="flowTime" class="form-control input-lg"  data-parsley-required="true" data-parsley-required-message="实际还款时间不能为空">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
                        <button type="button" onclick="add()" class="btn btn-primary"><span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>保存</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <!-- end dialog -->

    <!-- end #content -->

</div>
<!-- end page container -->
<jsp:include page="../common/footer.jsp"/>
<script>

    Date.prototype.Format = function (fmt) {
        var o = {
            "M+": this.getMonth() + 1, //月份
            "d+": this.getDate(), //日
            "h+": this.getHours(), //小时
            "m+": this.getMinutes(), //分
            "s+": this.getSeconds(), //秒
            "q+": Math.floor((this.getMonth() + 3) / 3), //季度
            "S": this.getMilliseconds() //毫秒
        };
        if (/(y+)/.test(fmt)) {
            fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        }
        for (var k in o) {
            if (new RegExp("(" + k + ")").test(fmt)) {
                fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
            }
        }
        return fmt;
    }
    $(document).ready(function () {
        App.init();
        TableManageFixedHeader.init();
        datainit();
    });
    //分页展示
    var table;
    $(document).ready(function () {
        table = $("#gadtable").DataTable({

            "bAutoWidth": false,
            "pagingType": "simple_numbers",//设置分页控件的模式
            searching: false,//屏蔽datatales的查询框
            aLengthMenu: [100],//设置一页展示10条记录
            "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
            "oLanguage": {  //对表格国际化
                "sLengthMenu": "每页显示 _MENU_条",
                "sZeroRecords": "没有找到符合条件的数据",
                "sInfo": "当前第 _START_ - _END_ 期　共计 _TOTAL_ 期",
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
            //"bPaginate": false, // 禁止分页
            //"paging": false, // 禁止分页
            "processing": true, //打开数据加载时的等待效果
            "serverSide": true,//打开后台分页
            "ajax": {
                "url": "/validorder/queryTableDataDetail",
                "dataSrc": "aaData",
                "data": function (params) {
                    params.orderId = $('#orderId').val();//订单编号
                }
            },
            "columns": [
                {"data": "period"},//期数
                {"data": "repayMoney"},//本期应还金额
                {"data": "principal"},//本金
                {"data": "interest"},//服务费
                {"data": "overDueFee"},//滞纳金
                {"data": "amount"},//总金额
                {"data": "repayday",
                    "render": function(data) {
                        if(data!=null){
                            return (new Date(data)).Format("yyyy-MM-dd");
                        }
                        return "";
                    }
                },//还款日
                {"data": "repidTime",
                    "render":function(data){
                        if(data!=null){
                            return (new Date(data)).Format("yyyy-MM-dd");
                        }
                        return "";
                    }},//实际还款日
                {"data": "state",
                    "render":function(data) {
                        switch (data){
                            case 0:return "未还款";     break;
                            case 1:return "已还款";    break;
                            case 2:return "提前结清";  break;
                            case 10:return "逾期";    break;
                            default:return "未知状态"
                        }
                    }
                }//还款状态
            ],

            "columnDefs": [{
                // 定义操作列
                "targets":9,//操作按钮目标列标
                "data": null,
                "render": function (data, type, row) {
                    var customerId = '"' + row.customerId + '"';
                    var orderId = '"' + row.orderId + '"';
                    var period = '"' + row.period + '"';

                    var principal = '"' + row.principal + '"';
                    var interest = '"' + row.interest + '"';
                    var overDueFee = '"' + row.overDueFee + '"';
                    var planid='"' + row.id + '"';
                    if(row.state==1) {
                        var html = "<font color='red'>不可操作</font>&nbsp;&nbsp;&nbsp;&nbsp;"
                        return html;
                    }
                    if(row.state!==1) {
                        var html = "<a href='javascript:void(0);' onclick='todo(" + planid + ',' + customerId + ',' + orderId + ',' + period + ',' + principal + ',' + interest + ',' + overDueFee + ")' class='btn-link'>确认还款</a>&nbsp;&nbsp;&nbsp;&nbsp;"
                         return html;
                    }
                    return "";
                }
            }]

        });
    });
    //查询
    function search() {
        table.ajax.reload();
    }

    function back(){
        history.go(-1);
    }
    //去往确认还款弹框
    function todo(planid,customerId,orderId,period,principal,interest,overDueFee) {
        $("#customerId").val(customerId);
        $("#orderId2").val(orderId);
        $("#period").val(period);
        $("#planid").val(planid);

        var sum = Number(principal)+Number(interest)+Number(overDueFee);

        $("#sum").val(sum.toFixed(2)+ "(含本金"+principal+"+利息"+interest+"+滞纳金"+overDueFee+")");

        $("#amount").val(sum);
        $("#repayMyModalLabel").text("确认还款");
        $('#repayMyModal').modal();
    }

    function doSubmit() {
        $("#repayDialogForm").submit();
    }

            //时间控件
            function datainit(){
            $("#flowTime").datepicker({
            language: "zh-CN",
            format:"yyyy-mm-dd",
            autoclose: true,
            todayHighlight: true,
            endDate : new Date(),
            todayBtn:'linked'
        });
    }


    function add() {
      var customerId=$("#customerId").val();
      var orderId=$("#orderId2").val();
      var period=$("#period").val();
      var principal=$("#principal").val();
        var interest=$("#interest").val();
        var overDueFee=$("#overDueFee").val();
        var flowTime=$("#flowTime").val();
        var pattern=$("#pattern").val();
        var amount=$("#amount").val();
        var planid=$("#planid").val();
        var payid=$("#payid").val();
        if(pattern==''){
            alert("请选择还款方式");
            return;
        }
        if(payid==''){
            alert("请填写交易流水号");
            return;
        }
        if(flowTime==''){
            alert("请填写实际还款时间");
            return;
        }
        Ewin.confirm({message: "确认要保存还款数据吗？"}).on(function (e) {
            if (!e) {
                return;
            }
            jQuery.ajax({
                type: "GET",
                url: "<%=path%>/transflow/add?customerId=" + customerId+"&orderId="+orderId+"&period="+period+"&principal="+principal+"&interest="+interest+"&overDueFee="+overDueFee+"&flowTime="+flowTime+"&pattern="+pattern+"&amount="+amount+"&planid="+planid+"&payid="+payid,
                dataType: "json",
                success: function (data) {
                    if(data.success){
                        alert(data.result);
                    }else {
                        alert(data.msg);
                    }

                    $("#payid").val('');
                    $("#pattern").val('');
                    $("#flowTime").val('')
                    $('#repayMyModal').modal('hide');
                    table.ajax.reload();

                }
            });
        });
    }

</script>
<!-- ================== END PAGE LEVEL JS ================== -->
</body>
</html>


