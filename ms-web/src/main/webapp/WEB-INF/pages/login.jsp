<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if !IE]><!-->
<html lang="zh">
<!--<![endif]-->
<head>
	<meta charset="utf-8" />
	<title>登录页面</title>
	<jsp:include page="common/header.jsp"/>
    <%@include file="common/taglib.jsp"%>
</head>
<body>
	<!-- begin #page-loader -->
	<div id="page-loader" class="fade in"><span class="spinner"></span></div>
	<!-- end #page-loader -->
	
	<!-- begin #page-container -->
	<div id="page-container" class="fade">
	    <!-- begin login -->
        <div class="login bg-black animated fadeInDown">
            <!-- begin brand -->
            <div class="login-header">
                <div class="brand">
                    <span class="logo"></span> 桔子分期
                    <small>财务管理系统</small>
                </div>
                <div class="icon">
                    <i class="fa fa-sign-in"></i>
                </div>
            </div>
            <!-- end brand -->
            <div class="login-content">
                <form:form action="dologin" method="POST" class="margin-bottom-0" data-parsley-validate="true">
                    <div class="form-group m-b-20">
                        <input type="text" class="form-control input-lg" placeholder="用户名" name="username" data-parsley-required="true" 
                        data-parsley-required-message="用户名不能为空" value="${user.username}"/>
                       </div>
                    <div class="form-group m-b-20">
                        <input type="password" class="form-control input-lg" placeholder="密码" name="password" 
                        data-parsley-required-message="密码不能为空" data-parsley-required="true" value="${user.password}"/>
                    </div>
                  
          <div class="form-inline m-b-20">
            <div class="form-group">
               <input type="text" style="width: 220px;"  class="form-control input-lg" placeholder="验证码" name="captcha" data-parsley-required="true" data-parsley-required-message="验证码不能为空"/>
               <img style="position: relative;top:-48px;left: 233px;"  src="./Kaptcha" class="form-group" alt="点击更换" id="kaptchaImage"/>
            </div>
         </div>
           <span style="position: relative;top: -36px;left: 131px;color: #E5603B;">${loginMessage.msg}</span>
                    <%--<div class="checkbox m-b-20">--%>
                        <%--<label>--%>
                            <%--<input type="checkbox" /> 记住我--%>
                        <%--</label>--%>
                    <%--</div>--%>
                    <div class="login-buttons">
                        <button type="submit"  style="position: relative;top:-30px" class="btn btn-success btn-block btn-lg">点击登录</button>
                    </div>
                </form:form>
            </div>
        </div>
        <!-- end login -->
	</div>
	<!-- end page container -->
	
	<!-- ================== BEGIN BASE JS ================== -->
	<script src="static/plugins/jquery/jquery-1.9.1.min.js"></script>
	<script src="static/plugins/jquery/jquery-migrate-1.1.0.min.js"></script>
	<script src="static/plugins/jquery-ui/ui/minified/jquery-ui.min.js"></script>
	<script src="static/plugins/bootstrap/js/bootstrap.min.js"></script>
	<!--[if lt IE 9]>
		<script src="static/crossbrowserjs/html5shiv.js"></script>
		<script src="static/crossbrowserjs/respond.min.js"></script>
		<script src="static/crossbrowserjs/excanvas.min.js"></script>
	<![endif]-->
	<script src="static/plugins/slimscroll/jquery.slimscroll.min.js"></script>
	<script src="static/plugins/jquery-cookie/jquery.cookie.js"></script>
    <script src="static/plugins/parsley/dist/parsley.js"></script>
	<!-- ================== END BASE JS ================== -->
	
	<!-- ================== BEGIN PAGE LEVEL JS ================== -->
	<script src="static/js/apps.min.js"></script>
	<!-- ================== END PAGE LEVEL JS ================== -->
	
	<script>
		$(document).ready(function() {
			App.init();
            $('#kaptchaImage').click(function() {$(this).attr('src','Kaptcha?' + Math.floor(Math.random() * 100));});
		});		
    </script>
</body>
</html>
