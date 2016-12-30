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
        "processing": true, //打开数据加载时的等待效果
        "serverSide": true,//打开后台分页
        "ajax": {
            "url": "/order/queryTableData",
            "dataSrc": "aaData",
            "data": function (params) {
                params.orderId = $('#orderId').val();//订单编号
                params.phone=$('#phone').val();//手机号
                params.username=$('#username').val();//用户名
                params.orderStatus=$('#orderStatus').val();//订单状态
                params.orderTime=$('#orderTime').val();//下单开始时间
                params.orderTimeEnd=$('#orderTimeEnd').val();//下单结束时间
                params.source=$('#source').val();//来源
            }
        },
        "columns": [
            {"data": "orderId"},
            {"data": "orderTime"},
            {"data": "username"},
            {"data": "phone"},
            {"data": "productName"},
            {"data": "monthly"},
            {"data": "source",
                "render":function(data) {
                    switch (data){
                        case 0:return "pc";     break;
                        case 1:return "微信";     break;
                        case 2:return "桔子苹果APP"; break;
                        case 3:return "桔子安卓APP"; break;
                        default:return "未知状态"
                    }
                }
            },
            {"data": "orderStatus",
                "render":function(data) {
                    switch (data){
                        case 0:return "已提交，待确认";     break;
                        case 1:return "待打款";     break;
                        case 2:return "已打款，待到账"; break;
                        case 3:return "已到账，分期还款中"; break;
                        case 4:return "分期还款结束";     break;
                        case 5:return "打款失败";     break;
                        case 6:return "订单取消"; break;
                        default:return "未知状态"
                    }
                }
            },
            {"data": "recommendCode"}
        ],
        "columnDefs" : [ {
            "targets" : 9,
            "data" : null,
            "render" : function(data, type,row) {
                var orderId = '"' + row.orderId + '"';
                var id='"'+data.id+'"';
                var html =  "<a  href='javascript:void(0);' onclick='toInfo("+ orderId + ","+id+")' class='btn-link'>查看详情</a>"
                return html;
            }

        } ]

    });
});
//查询
function search() {
    table.ajax.reload();
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