package cn.edu.bnuz.seawas.controller.weChat.mine;

import cn.edu.bnuz.seawas.entity.Album;
import cn.edu.bnuz.seawas.service.weChat.mine.AlbumService;
import cn.edu.bnuz.seawas.utils.Condition;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 微信端相册操作Controller
 * Created by sjk on 2017-09-07.
 */
@Controller
@RequestMapping(value = "/wechat/album")
public class AlbumController {

    @Autowired
    private AlbumService albumService;

    /**
     * 删除相册
     */
    @RequestMapping(value = "/deleteAlbum")
    @ResponseBody
    public String deleteAlbum(String albumId) {
        Condition condition = albumService.deleteAlbum(new Album(albumId));
        return new Gson().toJson(condition);
    }

    /**
     * 修改相册名称
     */
    @RequestMapping(value = "/updateName")
    @ResponseBody
    public String updateAlbumName(Album album) {
        Condition condition = albumService.updateName(album);
        return new Gson().toJson(condition);
    }

    /**
     * 添加相册
     */
    @RequestMapping(value = "/addAlbum")
    @ResponseBody
    public String addAlbum(Album album) {
        Condition<Album> condition = albumService.addAlbum(album);
        return new Gson().toJson(condition);
    }
}
