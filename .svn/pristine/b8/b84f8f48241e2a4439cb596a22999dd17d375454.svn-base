package cn.edu.bnuz.seawas.sysconfig;

import com.foxinmy.weixin4j.jssdk.JSSDKConfigurator;
import com.foxinmy.weixin4j.mp.WeixinProxy;
import com.foxinmy.weixin4j.payment.WeixinPayProxy;
import com.foxinmy.weixin4j.token.TokenManager;
import com.foxinmy.weixin4j.type.TicketType;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;

/**
 * 微信公众号配置接口
 * Created by sjk on 2017-09-08.
 */
@Component
public class Weixin4jConfig {

    /**
     * 获取WeixinProxy对象
     */
    @Bean
    public WeixinProxy getWeixinProxy() {
        return new WeixinProxy();
    }

    /**
     * 通过WeixinProxy对象获取Jsapi的票据管理对象
     */
    @Bean
    public TokenManager getTokenManager() {
        return getWeixinProxy().getTicketManager(TicketType.jsapi);
    }

    /**
     * 获取JSSDK配置工具
     */
    @Bean
    public JSSDKConfigurator getJSSDKConfigurator() {
        return new JSSDKConfigurator(getTokenManager());
    }

    /**
     * 获取WeixinPayProxy对象
     */
    @Bean
    public WeixinPayProxy getWeixinPayProxy() { return new WeixinPayProxy(); }
}
