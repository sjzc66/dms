<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if !IE]><!-->
<html lang="zh">
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>主页面</title>
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
    <meta content="" name="description" />
    <meta content="" name="author" />
    <!-- ================== BEGIN BASE CSS STYLE ================== -->
    <jsp:include page="../common/header.jsp"/>
    <%@include file="../common/taglib.jsp"%>
    <link href="/static/css/bootstrap-table.min.css" rel="stylesheet" />
    <!-- ================== END BASE CSS STYLE ================== -->

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
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-default" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                            <a href="javascript:search();" class="btn btn-xs btn-icon btn-circle btn-success"><i class="fa fa-repeat"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a>
                        </div>
                        <h4 class="panel-title"> 还款计划 </h4>
                    </div>
                     
                    <div class="panel-body">
                        <div class="table-responsive">
                            <table width="974" border="0">
                                <tr>
                                    <td width="74" height="70"><strong>订单号：</strong></td>
                                    <td width="100">
                                        <label>
                                            <input id="orderId" name="orderId" type="text" size="20"/>
                                        </label>
                                        </form>
                                    </td>

                                    <td width="30"><strong>砍头息：</strong></td>
                                    <td width="100">
                                        <select id="behead" name="behead">
                                            <option value="">请选择</option>
                                            <option value="1">是</option>
                                            <option value="0">否</option>
                                        </select>
                                    </td>
                                    <td width="40"><strong>是否免息：</strong></td>
                                    <td width="195">
                                        <select id="freeInterest" name="freeInterest">
                                            <option value="">请选择</option>
                                            <option value="1">是</option>
                                            <option value="0">否</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="40"><strong>下单时间：</strong></td>
                                    <td colspan="3"><input id="orderTime" name="orderTime" type="text" size="20"/>--
                                        <input id="orderTimeEnd" name="orderTimeEnd" type="text" size="20"/></td>
                                    <td colspan="2">
                                        <button type="button" class="btn btn-primary" onclick="search()"
                                                style="position: relative;top:-1px;left:70px;">查询
                                        </button>
                                    </td>
                                </tr>
                            </table>

                            <table id="planTable" class="table table-striped table-bordered">
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

<script src="/static/js/bootstrap-table.min.js"></script>
<script src="/static/js/bootstrap-table-zh-CN.js"></script>
<!-- ================== END PAGE LEVEL JS ================== -->

<script>

    $(document).ready(function() {
        App.init();
        init();
        datainit();
    });
    function search(){
        $('#planTable').bootstrapTable('refresh',{url:'/repay/query'});
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
    function init(){
        $('#planTable').bootstrapTable({
            url: '/repay/query',         //请求后台的URL（*）
            method: 'get',                      //请求方式（*）
            pagination: true,                   //是否显示分页（*）
            paginationLoop:true,
            sidePagination:"server",
            pageNumber:1,                       //初始化加载第一页，默认第一页
            pageSize: 10,                       //每页的记录行数（*）
            queryParamsType:"limit",
            contentType:"application/text",
            queryParams: function (params) {//表示每次发送给服务器的参数，可以添加自己需要的参数；
                return {
                    limit: params.limit,
                    offset:  params.offset,
                    pageSize:params.limit,
                    currentPage:(params.offset/params.limit)+1,
                    orderId:$("#orderId").val(),
                    freeInterest:$("#freeInterest").val(),
                    behead:$("#behead").val(),
                    startCreateTime:$("#orderTime").val(),
                    endCreateTime:$("#orderTimeEnd").val()
                }
            },
            searchOnEnterKey:true,
            showRefresh:true,
            columns: [{
                field: 'orderId',
                title: '订单号'
            }, {
                field: 'createTime',
                title: '创建时间'
            }, {
                field: 'amount',
                title: '金额'
            }, {
                field: 'actualPeriod',
                title: '期数（天数）'
            }, {
                field: 'productType',
                title: '产品类型'
            }, {
                field: 'repayday',
                title: '还款日'
            }, {
                field: 'storeMonthRate',
                title: '利率'
            },{
                field: 'source',
                title: '来源'
            }, {
                field: 'behead',
                title: '是否砍头'
            },{
                field: 'freeInterest',
                title: '是否免息'
            },{
                title: '操作',
                field: 'orderId',
                align:'center',
                formatter: function (value, row, index) {
                    return "<a href=/repay/repayDetailList?orderId="+value+">查看还款计划详情</a>";
                }
            }]
        });
    }
</script>
</body>
</html>
