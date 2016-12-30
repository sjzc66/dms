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
                "url": "/product/queryMonthProduct",
                "dataSrc": "aaData",
                "data": function (params) {
                    params.prductId=$('#prductId').val();//产品编号
                    params.productName=$('#productName').val();//产品名称
                }
            },
            "columns": [
                {"data": "prductId"},
                {"data": "productName"},
                {"data": "parentName"},
                {"data": "period"},
                {"data": "monthRate"},
                {"data": "yearRate"},
                {"data": "createTime"},
                {"data": "creater"},
                {"data": "productDesc"}
            ],
            "columnDefs" : [ {
                // 定义操作列,######以下是重点########
                "targets" : 8,//是操作按钮目标列
                "data" : null,
                "render" : function(data, type,row) {
                    var id = '"' + row.id + '"';
                    var html =  "<a href='javascript:void(0);' onclick='toedit("+ id + ")' class='btn-link'>编辑</a>&nbsp;&nbsp;&nbsp;&nbsp;"
                    html += "<a href='javascript:void(0);'   onclick='del("+ id + ")'  class='btn-link'>删除</a>"
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



