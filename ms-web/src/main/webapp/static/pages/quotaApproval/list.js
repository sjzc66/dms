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
                "url": "/quotaApproval/queryTableData",
                "dataSrc": "aaData",
                "data": function (params) {
                    params.orderId = $('#orderId').val();//订单编号
                    params.phone=$('#phone').val();//手机号
                    params.username=$('#username').val();//用户名
                    params.auditStatus=$('#auditStatus').val();//审核状态
                    params.applicationTime=$('#applicationTime').val();//申请开始时间
                    params.applicationTimeEnd=$('#applicationTimeEnd').val();//申请结束时间
                    params.recommendationCode=$('#recommendationCode').val();//推荐码
                }
            },
            "columns": [
                {"data": "orderId"},
                {"data": "applicationTime"},
                {"data": "phone"},
                {"data": "incomingProduct"},
                {"data": "username"},
                {"data": "idCard"},
                {"data": "customerType",
                    "render":function(data) {
                        switch (data){
                            case "0":return "学生";     break;
                            case "1":return "工薪";     break;
                            default:return "未知"
                        }
                    }
                },
                {"data": "auditStatus",
                   "render":function(data){
                      switch (data){
                          case "0":return "已激活"; break;
                          case "1":return "待资料上传";break;
                          case "2":return "激活失败"; break;
                          case "3":return "资料重传";break;
                          case "4":return "初审中";break;
                          case "5":return "终审中";break;
                          default:return "未知状态";
                      }
                   }
                },
                {"data": "recommendationCode"}
            ],
            "columnDefs" : [ {
                "targets" : 9,
                "data" : null,
                "render" : function(data, type,row) {
                    var id = '"' + row.id + '"';
                    var html =  "<a  href='javascript:void(0);' onclick='toInfo("+ id + ")' class='btn-link'>查看详情</a>"
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
        $("#applicationTime,#applicationTimeEnd").datepicker({
            language: "zh-CN",
            format:"yyyy-mm-dd",
            autoclose: true,
            todayHighlight: true,
            endDate : new Date(),
            todayBtn:'linked'
        });
    }



