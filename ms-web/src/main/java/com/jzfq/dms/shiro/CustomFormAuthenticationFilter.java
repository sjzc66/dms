package com.jzfq.dms.shiro;

/**
 * Created by zhishuo on 10/28/16.
 */

import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.apache.shiro.web.util.WebUtils;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;


public class CustomFormAuthenticationFilter extends FormAuthenticationFilter {

    /**
     * 验证码参数名
     */
    public static final String CAPTCHA_PARAM_NAME = "captcha";

    protected String getCaptcha(ServletRequest request) {
        return WebUtils.getCleanParam(request, CAPTCHA_PARAM_NAME);
    }

    /* 创建登陆认证token传值传递给UserRealm的shiro认证
     * @see org.apache.shiro.web.filter.authc.FormAuthenticationFilter#createToken(javax.servlet.ServletRequest, javax.servlet.ServletResponse)
     */
    @Override
    protected AuthenticationToken createToken(ServletRequest request, ServletResponse response) {
        String username = getUsername(request);
        String password = getPassword(request);
        String captcha = getCaptcha(request);//获取验证码
        boolean rememberMe = isRememberMe(request);
        String host = getHost(request);
        CaptchaUsernamePasswordToken token = new CaptchaUsernamePasswordToken(username, password, rememberMe, host, captcha);
        token.setRequest(request);
        return token;
    }


}
