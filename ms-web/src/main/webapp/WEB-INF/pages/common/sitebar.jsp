
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<div id="sidebar" class="sidebar">
    <!-- begin sidebar scrollbar -->
    <div data-scrollbar="true" data-height="100%">
        <!-- begin sidebar nav -->
        <ul class="nav">
            <li class="nav-header">Navigation</li>

            <shiro:hasPermission name="商户管理">
                <li class="has-sub">
                    <a href="javascript:;">
                        <b class="caret pull-right"></b>
                        <i class="fa fa-pie-chart"></i>
                        <span>商户管理</span>
                    </a>
                    <ul class="sub-menu">
                        <li><a href="/product/list">配置月息产品</a></li>
                        <li><a href="/product/daylist">配置日息产品</a></li>
                    </ul>
                </li>
            </shiro:hasPermission>

            <shiro:hasPermission name="订单管理">
                <li class="has-sub">
                    <a href="javascript:;">
                        <b class="caret pull-right"></b>
                        <i class="fa fa-pie-chart"></i>
                        <span>订单管理</span>
                    </a>
                    <ul class="sub-menu">
                        <li><a href="/quotaApproval/list">额度审批单</a></li>
                        <li><a href="/order/list">白条订单</a></li>
                    </ul>
                </li>
            </shiro:hasPermission>

            <shiro:hasPermission name="市场管理">
                <li class="has-sub">
                    <a href="javascript:;">
                        <b class="caret pull-right"></b>
                        <i class="fa fa-suitcase"></i>
                        <span>市场管理</span>
                    </a>
                    <ul class="sub-menu">
                        <li><a href="/order/list">白条订单</a></li>
                        <li><a href="/facepatch/tolist">面签补件</a></li>
                    </ul>
            </li>
            </shiro:hasPermission>

            <shiro:hasPermission name="财务管理">
                <li class="has-sub">
                    <a href="javascript:;">
                        <b class="caret pull-right"></b>
                        <i class="fa fa-cny"></i>
                        <span>财务管理</span>
                    </a>
                    <ul class="sub-menu">
                        <li><a href="/order/list">白条订单</a></li>
                        <li><a href="/validorder/tolist">还款订单</a></li>
                        <li><a href="/product/list">产品列表</a></li>
                    </ul>
                </li>
            </shiro:hasPermission>

            <shiro:hasPermission name="系统管理">
                <li class="has-sub">
                    <a href="javascript:;">
                        <b class="caret pull-right"></b>
                        <i class="fa fa-wrench"></i>
                        <span>系统管理</span>
                    </a>
                    <ul class="sub-menu">
                        <li><a href="/sysuser/tolist">用户管理</a></li>
                        <li><a href="/sysrole/tolist">角色管理</a></li>
                         <li><a href="/sysauth/tolist">资源管理</a></li>
                    </ul>
                </li>
            </shiro:hasPermission>

            <shiro:hasPermission name="京东支付">
                <li class="has-sub">
                    <a href="javascript:;">
                        <b class="caret pull-right"></b>
                        <i class="fa fa-wrench"></i>
                        <span>京东支付</span>
                    </a>
                    <ul class="sub-menu">
                        <li><a href="/test/topaylist">京东支付测试页面</a></li>
                    </ul>
                </li>
            </shiro:hasPermission>

            <!-- begin sidebar minify button -->
            <li><a href="javascript:;" class="sidebar-minify-btn" data-click="sidebar-minify"><i class="fa fa-angle-double-left"></i></a></li>
            <!-- end sidebar minify button -->
        </ul>
        <!-- end sidebar nav -->
    </div>
    <!-- end sidebar scrollbar -->
</div>
