<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="zh" class="ie8"> <![endif]-->
<!--[if !IE]><!-->
<html lang="zh">
<%@include file="../common/taglib.jsp"%>
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>页面找不到啦</title>
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
    <meta content="" name="description" />
    <meta content="" name="author" />

    <!-- ================== BEGIN BASE CSS STYLE ================== -->
    <link href="/static/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <link href="/static/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
    <link href="/static/css/animate.min.css" rel="stylesheet" />
    <link href="/static/css/style.min.css" rel="stylesheet" />
    <link href="/static/css/style-responsive.min.css" rel="stylesheet" />
    <link href="/static/css/theme/default.css" rel="stylesheet" id="theme" />
    <!-- ================== END BASE CSS STYLE ================== -->
</head>
<body>
<!-- begin #page-loader -->
<div id="page-loader" class="fade in"><span class="spinner"></span></div>
<!-- end #page-loader -->

<!-- begin #page-container -->
<div id="page-container" class="fade">
    <!-- begin error -->
    <div class="error">
        <div class="error-code m-b-10">404 <i class="fa fa-warning"></i></div>
        <div class="error-content">
            <div class="error-message">我们找不到页面了哦...</div>
            <div class="error-desc m-b-20">
                看到这个页面说明是访问的连接不对。 <br />
                这个页面也许可以帮助你，了解错误原因。
            </div>
            <div>
                <a href="${ctx}/main" class="btn btn-success"> 回到主页 </a>
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
