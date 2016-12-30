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
    <title>补充证件</title>
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
    <meta content="" name="description" />
    <meta content="" name="author" />
    <!-- ================== BEGIN BASE CSS STYLE ================== -->
    <jsp:include page="../common/header.jsp"/>
    <%@include file="../common/taglib.jsp"%>
    <!-- ================== END BASE CSS STYLE ================== -->

    <!-- ================== 单独作用于本页表格td ================== -->
    <style>
        #gadtable>tr>td {
            padding: 10px 15px;
            padding-top: 7px;
            padding-right: 15px;
            padding-bottom: 7px;
            padding-left: 15px;
        }
    </style>
    <!-- ================== 单独作用于本页表格td ================== -->

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
        <%--<h1 class="page-header"> 在很久很久以前 <small>......</small></h1>--%>
        <!-- end page-header -->

        <!-- begin row -->
        <div class="row">
            <!-- begin col-12 -->
            <div class="col-md-12">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">补充证件</h3>
                    </div>
                    <div class="panel-body">

                        <table class="table">
                            <tr>
                                <td><div style="position: relative;width: 200px;left:100px;">
                                    <h5>额度申请单号:${facePatch.orderId}</h5></div></td>
                                <td><div style="position: relative;">
                                    <h5>申请时间:${facePatch.applicationTimeStr}</h5>
                                </div></td>
                            </tr>
                        </table>

                        <table class="table">
                            <tr>
                                <td>申请人:${facePatch.username}</td>
                                <td>手机:${facePatch.phone}</td>
                                <td>身份证:${facePatch.idNumber}</td>
                            </tr>
                            <tr>
                                <td>白条额度激活:${facePatch.productType}</td>
                                <td colspan="2">还款日:${facePatch.repaymentDateStr}</td>
                            </tr>
                            <tr><td colspan="3"></td></tr>
                        </table>

                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">
                                    <h5>补充证件</h5>
                                </h3>
                            </div>
                            <div class="panel-body">
                                <form method="post" enctype="multipart/form-data" action="/facepatch/uploadimg">
                                    <input name="id" type="hidden" value="${facePatch.id}">
                                    <table class="table">
                                        <tr>
                                            <td>
                                                <input name="file" type="file" id="txtSrc" onChange="setImagePreview(this,imgDiv,img);">
                                                <div id="img0001">
                                                    <img alt="" src="/static/img/favicon_1.ico" width="200" height="160" >
                                                </div>
                                                <div style="display:none" id="imgDiv">
                                                    <img alt="" src="" id="img" name="图片预览" width="200" height="160" id="图片预览">
                                                </div>
                                            </td>
                                        </tr>
                                        <tr><td><font color="red">(申请人手持身份证及借款合同与经办人合照要求看清身份证)</font></td></tr>
                                        <tr><td><button type="submit" class="btn btn-primary m-r-5 m-b-5">上传</button></td></tr>
                                    </table>
                                </form>
                            </div>
                        </div>

                    </div>
                </div>


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
    $(document).ready(function() {
        App.init();
        Dashboard.init();
    });

    function setImagePreview(docObj,localImagId,imgObjPreview)
    {

        var name=docObj.value;
        var type=name.split(".");
        type=type[type.length-1];
        if("jpg"!=type &&"png"!=type &&"jpeg"!=type&&"gif"!=type){
            alert("错误的类型，请选择图片");
            document.getElementById("txtSrc").value=null;//防止将非图片类型上传
            return ;
        }

        if(docObj.files && docObj.files[0])
        {

            //alert("hello"+docObj.files[0]);
            //火狐7以上版本不能用上面的getAsDataURL()方式获取，需要一下方式
            document.getElementById("imgDiv").style.display="block";
            document.getElementById("img").src= window.URL.createObjectURL(docObj.files[0]);
        }
        else
        {
            //IE下，使用滤镜
            docObj.select();
            var imgSrc = document.selection.createRange().text;

            //必须设置初始大小
            localImagId.style.width = "300px";
            localImagId.style.height = "200px";

            //图片异常的捕捉，防止用户修改后缀来伪造图片
            try
            {
                localImagId.style.filter="progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";
                localImagId.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = imgSrc;
            }
            catch(e)
            {
                alert("您上传的图片格式不正确，请重新选择!");
                return false;
            }
            imgObjPreview.style.display = 'none';
            document.selection.empty();
        }
        $("#img0001").hide();
        return true;
    }

</script>

</body>
</html>
