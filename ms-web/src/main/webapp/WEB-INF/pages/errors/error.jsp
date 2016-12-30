
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common/header.jsp"/>
<html>
<head>
    <title>出错啦</title>
</head>
<body>

<!-- begin #page-loader -->
<div id="page-loader" class="fade in"><span class="spinner"></span></div>
<!-- end #page-loader -->

<!-- begin #page-container -->
<div id="page-container" class="fade">
    <!-- begin error -->
    <div class="error">
        <div class="error-code m-b-10">服务器出错了！ <i class="fa fa-frown-o"></i></div>
        <div class="error-content">
            <div class="error-message">我们的服务器太累了...</div>
            <div class="error-desc m-b-20">
                显示此内容代表服务器出错啦。 <br />
                可以尝试返回主页面重新操作
            </div>
            <div>
                <a href="${ctx}main" class="btn btn-success"> 回到主页 </a>
            </div>
        </div>
    </div>
    <!-- end error -->

    <!-- begin scroll to top btn -->
    <a href="javascript:;" class="btn btn-icon btn-circle btn-success btn-scroll-to-top fade" data-click="scroll-top"><i class="fa fa-angle-up"></i></a>
    <!-- end scroll to top btn -->
</div>
<!-- end page container -->


<!-- ================== BEGIN BASE JS ================== -->
<script src="/static/plugins/jquery/jquery-1.9.1.min.js"></script>
<script src="/static/plugins/jquery/jquery-migrate-1.1.0.min.js"></script>
<script src="/static/plugins/jquery-ui/ui/minified/jquery-ui.min.js"></script>
<script src="/static/plugins/bootstrap/js/bootstrap.min.js"></script>
<!--[if lt IE 9]>
<script src="/static/crossbrowserjs/html5shiv.js"></script>
<script src="/static/crossbrowserjs/respond.min.js"></script>
<script src="/static/crossbrowserjs/excanvas.min.js"></script>
<![endif]-->
<script src="/static/plugins/slimscroll/jquery.slimscroll.min.js"></script>
<script src="/static/plugins/jquery-cookie/jquery.cookie.js"></script>
<!-- ================== END BASE JS ================== -->

<!-- ================== BEGIN PAGE LEVEL JS ================== -->
<script src="/static/js/apps.min.js"></script>
<!-- ================== END PAGE LEVEL JS ================== -->

<script>
    $(document).ready(function() {
        App.init();
    });
</script>
</body>
</html>
