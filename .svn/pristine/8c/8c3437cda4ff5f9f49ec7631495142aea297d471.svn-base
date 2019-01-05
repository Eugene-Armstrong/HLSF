package cn.edu.bnuz.seawas.interceptor;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by tomviss on 2017/7/18.
 */
public class LoginInterceptor implements HandlerInterceptor {


    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object arg2) throws Exception {
        String url = request.getRequestURL()+"";
        Object o = request.getSession().getAttribute("admin");
        System.out.println(url);
        //已经登陆后或者访问通知的都放行
        if(o != null ||url.indexOf("login")>=0)
            return true;
        else{
            //否则去登陆
            response.sendRedirect(request.getContextPath() + "/a/login");
            return false;
        }
    }


    public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
            throws Exception {

    }


    public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
            throws Exception {

    }
}
