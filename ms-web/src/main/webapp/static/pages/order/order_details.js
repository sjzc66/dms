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
                "url": "/order/queryPlanData",
                "dataSrc": "aaData",
                "data": function (params) {
                    params.orderId = $('#orderId').val();//订单编号
                }
            },
            "columns": [
                {"data": "actualPeriod"},//期数
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
                            case 0:return "未还";     break;
                            case 1:return "正常";     break;
                            case 2:return "提前结清"; break;
                            default:return "未知状态"
                        }
                    }
                }//还款状态
            ]


        });
    });
    //查询
    function search() {
        table.ajax.reload();
    }

    function toInfo(id){
        window.location.href="<%=path%>/order/orderDetails/"+id;
    }
