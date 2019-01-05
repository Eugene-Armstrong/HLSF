package cn.edu.bnuz.seawas.common.resolver;

import cn.edu.bnuz.seawas.utils.EmailUtils;
import cn.edu.bnuz.seawas.utils.NetworkUtil;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 全局异常处理器
 * Created by sjk on 2017-10-12.
 */
public class GlobalExceptionResolver implements HandlerExceptionResolver {

    @Override
    public ModelAndView resolveException(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) {

        //获取异常内容
        StringWriter stringWriter = new StringWriter();
        PrintWriter printWriter = new PrintWriter(stringWriter);
        e.printStackTrace(printWriter);

        //获取IP
        String ip = NetworkUtil.getIp(httpServletRequest);

        //获取时间
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String date = sdf.format(new Date());

        //发送异常信息到邮件
        EmailUtils emailUtils = new EmailUtils("smtp.qq.com", 587, "765352073@qq.com", "alyvqwyiaxnfbecf");
        emailUtils.sendContent("765352073@qq.com", "Seawas_Error - " + date + " - " + ip, stringWriter.toString());

        //未捕获的异常，统一跳转到某一页面
        if (httpServletRequest.getRequestURL().toString().contains("/wechat")) {
            return new ModelAndView("redirect:/wechat/index/");
        } else {
            return new ModelAndView("wechat/error");
        }


    }
}
