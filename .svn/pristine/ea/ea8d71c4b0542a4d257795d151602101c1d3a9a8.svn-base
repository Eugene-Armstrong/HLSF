package cn.edu.bnuz.seawas.controller.weChat.mine;

import cn.edu.bnuz.seawas.entity.Album;
import cn.edu.bnuz.seawas.entity.Photo;
import cn.edu.bnuz.seawas.entity.User;
import cn.edu.bnuz.seawas.service.weChat.mine.AlbumService;
import cn.edu.bnuz.seawas.service.weChat.mine.PhotoService;
import cn.edu.bnuz.seawas.utils.Condition;
import com.foxinmy.weixin4j.jssdk.JSSDKAPI;
import com.foxinmy.weixin4j.jssdk.JSSDKConfigurator;
import com.foxinmy.weixin4j.mp.WeixinProxy;
import com.foxinmy.weixin4j.token.TokenManager;
import com.foxinmy.weixin4j.type.TicketType;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;

/**
 * 微信端图片Controller
 * Created by sjk on 2017-09-05.
 */
@Controller
@RequestMapping(value = "/wechat/photo")
public class PhotoController {

    @Autowired
    private PhotoService photoService;

    @Autowired
    private AlbumService albumService;

    /**
     * 添加图片
     * 从微信服务器上面下载已经上传的图片
     */
    @RequestMapping(value = "/add")
    @ResponseBody
    public String addPhoto(Album album, String[] mediaIds) {
        Condition condition = photoService.uploadPhoto(album, mediaIds);
        return new Gson().toJson(condition);
    }

    /**
     * 删除图片
     */
    @RequestMapping(value = "/delete")
    @ResponseBody
    public String deletePhoto(String[] photoIds) {

        try {

            for (String photoId : photoIds) {
                photoService.deletePhoto(new Photo(photoId));
            }

            return new Gson().toJson(new Condition(Condition.SUCCESS_CODE, "删除成功"));

        } catch (Exception e) {

            e.printStackTrace();

            return new Gson().toJson(new Condition(Condition.ERROR_CODE, "系统繁忙"));
        }
    }

    /**
     * 显示添加图片页面
     */
    @RequestMapping(value = "/addPage")
    public String addPage(Model model, Album album) {

        album = albumService.get(album);

        model.addAttribute("album", album);

        return "wechat/mine/add-photo";
    }

    /**
     * 点赞
     */
    @RequestMapping(value = "/like")
    @ResponseBody
    public String like(Photo photo, HttpServletRequest request) {
        Condition condition = photoService.like(photo, (User) request.getSession().getAttribute("userInfo"));
        return new Gson().toJson(condition);
    }
}
