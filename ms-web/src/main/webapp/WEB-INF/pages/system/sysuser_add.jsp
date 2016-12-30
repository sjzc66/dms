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
    <meta charset="utf-8" />
    <title>新增用户</title>
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
    <meta content="" name="description" />
    <meta content="" name="author" />
    <!-- ================== BEGIN BASE CSS STYLE ================== -->
    <jsp:include page="../common/header.jsp"/>
    <%@include file="../common/taglib.jsp"%>
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
        <!-- begin breadcrumb -->
        <ol class="breadcrumb pull-right">
            <li><a href="javascript:;">Home</a></li>
            <li><a href="javascript:;">Tables</a></li>
            <li class="active">Managed Tables</li>
        </ol>
        <!-- end breadcrumb -->
        <!-- begin page-header -->
        <h1 class="page-header"> 在很久很久以前 <small>......</small></h1>
        <!-- end page-header -->

        <!-- begin row -->
        <div class="row">
            <!-- begin col-12 -->
            <div class="col-md-12">
                <!-- begin panel -->
                <div class="panel panel-inverse">
                        <div class="panel-heading">
                            <c:choose>
                                <c:when test="${user.id!=null}">
                                    <h3 class="panel-title">编辑</h3>
                                </c:when>
                                <c:otherwise>
                                    <h3 class="panel-title">新增</h3>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="panel-body">

                            <form role="form" action="/sysuser/add" method="post" data-parsley-validate="true">
                                <input type="hidden" class="form-control" name="id" value="${user.id}">
                                <div class="form-group">
                                    <label for="name">
                                        账号<span id="spanMessage"></span>
                                    </label>
                                    <c:choose>
                                        <c:when test="${user.id!=null}">
                                            <input type="text" class="form-control input-lg" name="username" value="${user.username}" disabled="ture">
                                        </c:when>
                                        <c:otherwise>
                                            <input type="text" class="form-control input-lg" id="username" name="username" placeholder="请输入账号" data-parsley-required="true" data-parsley-required-message="账号不能为空" onblur="only()">
                                        </c:otherwise>
                                    </c:choose>

                                </div>

                                <div class="form-group">
                                    <label for="name">密码</label>
                                    <input type="text" class="form-control input-lg" name="password" value="${user.password}" placeholder="请输入密码"  data-parsley-required="true" data-parsley-required-message="密码不能为空">
                                </div>

                                <div class="form-group">
                                    <label for="name">真实姓名</label>
                                    <input type="text" class="form-control input-lg" name="realName" value="${user.realName}" placeholder="请输入真实姓名">
                                </div>

                                <div class="form-group">
                                    <label for="name">所在岗位</label>
                                    <input type="text" class="form-control input-lg" name="position" value="${user.position}" placeholder="请输入所在岗位">
                                </div>


                                <c:choose>
                                    <c:when test="${user.id!=null}">
                                        <div class="form-group">
                                            <label for="name">勾选角色</label>
                                            <table id="gadtable0" class="table table-striped table-bordered">
                                                <tr>
                                                    <c:forEach items="${list}" var="role">
                                                        <td>
                                                            <div class="checkbox">
                                                                <label>
                                                                    <input type="checkbox" name="roleIdList" value="${role.id}"  <c:if test="${role.delFlag == 1}" >checked="checked"</c:if>/>${role.name}
                                                                </label>
                                                            </div>
                                                        </td>
                                                    </c:forEach>
                                                </tr>
                                            </table>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="form-group">
                                            <label for="name">勾选角色</label>
                                            <table id="gadtable1" class="table table-striped table-bordered">
                                                <tr>
                                                    <c:forEach items="${list}" var="role">
                                                        <td>
                                                            <div class="checkbox">
                                                                <label>
                                                                    <input type="checkbox" name="roleIdList" value="${role.id}"/>${role.name}
                                                                </label>
                                                            </div>
                                                        </td>
                                                    </c:forEach>
                                                </tr>
                                            </table>
                                        </div>
                                    </c:otherwise>
                                </c:choose>

                                <button type="submit" class="btn btn-primary m-r-5 m-b-5">提交</button>
                            </form>

                        </div>
                </div>
                <!-- end panel -->
            </div>
            <!-- end col-12 -->
        </div>
        <!-- end row -->
    </div>
    <!-- end #content -->

    <!-- begin scroll to top btn -->
    <a href="javascript:;" class="btn btn-icon btn-circle btn-success btn-scroll-to-top fade" data-click="scroll-top"><i class="fa fa-angle-up"></i></a>
    <!-- end scroll to top btn -->
</div>
<!-- end page container -->
<jsp:include page="../common/footer.jsp"/>


<!-- ================== END PAGE LEVEL JS ================== -->


<script>
    if(${user.id!=null}){
        document.title='编辑用户';
    }

    $(document).ready(function() {
        App.init();
        Dashboard.init();

        var flag = true;
        $(":checkbox").each(function(){
            if($(this).attr("checked")){
                flag = false;
            }
        })
        if(flag){
            $('table input[type=checkbox]').eq(0).attr("checked",true);
        }
    });

    function only() {
        var username = $("#username").val();
        jQuery.ajax({
            type:"GET",
            url:"<%=path%>/sysuser/only/"+username,
            dataType:"json",
            success : function(data) {
                if (data.success == false) {
                    $("#username").focus();
                    $("#username").attr("value","");
                    $("#spanMessage").css("color","red");
                    $("#spanMessage").html("(抱歉,此处账号已经注册)");

                }else{
                    $("#spanMessage").html("");
                }
            }
        });
    }

</script>
</body>
</html>
