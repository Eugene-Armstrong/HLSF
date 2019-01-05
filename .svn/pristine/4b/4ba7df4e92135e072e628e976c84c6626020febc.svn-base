package cn.edu.bnuz.seawas.interceptor;

import cn.edu.bnuz.seawas.common.annotation.LeaderAuthority;
import cn.edu.bnuz.seawas.entity.User;
import cn.edu.bnuz.seawas.utils.Condition;
import com.google.gson.Gson;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.lang.reflect.Method;

/**
 * 领队权限拦截器
 * Created by sjk on 2017-09-21.
 */
public class LeaderInterceptor implements HandlerInterceptor {

    private Logger logger = LoggerFactory.getLogger(LeaderInterceptor.class);

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        logger.info("进入领队权限拦截器");

        //判断是否有注解
        if (handler instanceof HandlerMethod) {
            HandlerMethod handlerMethod = (HandlerMethod) handler;
            Method method = handlerMethod.getMethod();
            LeaderAuthority leaderAuthority = method.getAnnotation(LeaderAuthority.class);
            if (leaderAuthority != null) {
                User user = (User) request.getSession().getAttribute("userInfo");
                if (user == null || user.getType().equals("1")) {
                    //返回未授权信息
                    logger.info("操作未授权");
                    String data = new Gson().toJson(new Condition(Condition.NOALLOW_CODE, "身份异常"));
                    response.setHeader("content-type", "text/html;charset=UTF-8");
                    OutputStream outputStream = response.getOutputStream();
                    outputStream.write(data.getBytes("UTF-8"));
                    return false;
                }
            }
        }

        logger.info("领队权限正常");
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
