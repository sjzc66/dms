<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!-- begin #header -->
<div id="header" class="header navbar navbar-default navbar-fixed-top">
    <!-- begin container-fluid -->
    <div class="container-fluid">
        <!-- begin mobile sidebar expand / collapse button -->
        <div class="navbar-header">
            <a href="#" class="navbar-brand"><span class="navbar-logo"></span> 财务系统 </a>
            <button type="button" class="navbar-toggle" data-click="sidebar-toggled">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
        </div>
        <!-- end mobile sidebar expand / collapse button -->

        <!-- begin header navigation right -->
        <ul class="nav navbar-nav navbar-right">
            <li class="dropdown navbar-user">
                <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown">
                    <img src="/static/img/user-13.jpg" alt="" />
                    <span class="hidden-xs"> <shiro:principal property="realName" /> </span> <b class="caret"></b>
                </a>
                <ul class="dropdown-menu animated fadeInLeft">
                    <li class="arrow"></li>
                    <li><a href="javascript:modifyPassword();" >修改密码</a></li>
                    <li class="divider"></li>
                    <li><a href="/logout">退出</a></li>
                </ul>
            </li>
        </ul>
        <!-- end header navigation right -->
    </div>
    <!-- end container-fluid -->
</div>

<!-- begin dialog -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <form role="form" action="/sysuser/modifyPassword" method="get" data-parsley-validate="true" id="dialogForm">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                    <h4 class="modal-title" id="myModalLabel">修改密码</h4>
                </div>
                <div class="modal-body">

                    <div class="form-group">
                        <label for="txt_departmentname">您的账号</label>
                        <input type="text" class="form-control input-lg" id="txt_departmentname" disabled="true" value="<shiro:principal property='realName' />">
                    </div>
                    <div class="form-group">
                        <label for="txt_parentdepartment">新的密码<span id="spanMessage1"></span></label>
                        <input type="password" id="password1"  placeholder="新的密码" class="form-control input-lg" data-parsley-required="true" data-parsley-required-message="新的密码不能为空">
                    </div>
                    <div class="form-group">
                        <label for="txt_departmentlevel">确认密码<span id="spanMessage2"></span></label>
                        <input type="text" name="newPassword" id="password2" placeholder="确认密码" class="form-control input-lg" data-parsley-required="true" data-parsley-required-message="确认密码不能为空" onblur="same()">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
                    <button type="button" onclick="doSubmit()" class="btn btn-primary"><span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>保存</button>
                </div>
            </div>
        </div>
    </form>
</div>
<!-- end dialog -->

<!-- end #header -->

<script>
    //修改密码
    function modifyPassword() {
        $("#myModalLabel").text("修改密码");
        $('#myModal').modal();
    }

    function same() {
        var password1 = $("#password1").val();
        var password2 = $("#password2").val();
        //alert("password1:"+password1);
        //alert("password2:"+password2);
        if(password1!=password2){
            $("#spanMessage1").css("color","red");
            $("#spanMessage1").html("(两次密码不同)");
            $("#spanMessage2").css("color","red");
            $("#spanMessage2").html("(两次密码不同)");
            $("#password2").attr("value","");
        }else{
            $("#spanMessage1").html("");
            $("#spanMessage2").html("");
        }
    }

    function doSubmit() {
        $("#dialogForm").submit();
    }

</script>