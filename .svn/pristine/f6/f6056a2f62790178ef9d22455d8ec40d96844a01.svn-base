package cn.edu.bnuz.seawas.interceptor;

import com.foxinmy.weixin4j.mp.WeixinProxy;
import com.foxinmy.weixin4j.mp.api.OauthApi;
import com.foxinmy.weixin4j.util.Weixin4jConfigUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.lang.reflect.Method;

/**
 * 微信用户拦截器
 * Created by sjk on 2017-08-31.
 */
public class WeChatInterceptor implements HandlerInterceptor {

    @Autowired
    private WeixinProxy weixinProxy;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        //请求的地址
        String requestURL = request.getRequestURI();

        //获取请求当中携带的参数
        if (request.getQueryString() != null && !request.getQueryString().equals("null")) {
            requestURL = requestURL + "?" + request.getQueryString();
        }

        //判断session中是否存在用户信息
        if (request.getSession().getAttribute("userInfo") == null) {
            //不存在就请求用户授权并获取信息
            OauthApi oauthApi = weixinProxy.getOauthApi();
            String redirectUrl = Weixin4jConfigUtil.getValue("user.oauth.redirect.uri") + "?requestURL=" + requestURL;
            //重定向要回调函数
            response.setStatus(301);
            response.setHeader("Location", oauthApi.getUserAuthorizationURL(redirectUrl, "1", "snsapi_userinfo"));
            return false;
        }

        return true;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {
    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {
    }
}
