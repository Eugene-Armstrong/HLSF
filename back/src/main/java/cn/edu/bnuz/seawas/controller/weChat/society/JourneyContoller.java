package cn.edu.bnuz.seawas.controller.weChat.society;

import cn.edu.bnuz.seawas.entity.TravelNote;
import cn.edu.bnuz.seawas.entity.User;
import cn.edu.bnuz.seawas.service.weChat.mine.WxTravelNoteService;
import cn.edu.bnuz.seawas.utils.Condition;
import cn.edu.bnuz.seawas.vo.wechat.PicUrlVo;
import cn.edu.bnuz.seawas.vo.wechat.TravelNoteAndUser;
import cn.edu.bnuz.seawas.vo.wechat.TravelNoteVo;
import com.github.pagehelper.PageInfo;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Created by Zrj on 2017/8/31.
 */
@Controller
@RequestMapping("/wechat/journey")
public class JourneyContoller {
    @Autowired
    WxTravelNoteService wxTravelNoteService;

    /**
     * 显示游记列表数据
     * @return
     */
    @RequestMapping("/showJourneyList")
    @ResponseBody
    public PageInfo<TravelNoteAndUser> showJourneyList(Integer pageNum, Integer pageSize){
        try {
        PageInfo<TravelNoteAndUser> travelNoteAndUserList = wxTravelNoteService.getNoteAtSociety(pageNum,pageSize);
        return travelNoteAndUserList;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 通过游记id查看相应草稿游记
     * @return
     */
    @RequestMapping("showDraftJourneyById")
    public String showDraftJourneyById(String id, Model model){
        //通过id获取页面
        TravelNote travelNote = wxTravelNoteService.selectByPrimaryKey(id);
        model.addAttribute("travelNote",travelNote);
        return "wechat/society/editJourney";
    }

    /**
     * 通过游记id查看相应游记
     * @return
     */
    @RequestMapping("/showJourneyById")
    public String showJourneyById(String id, Model model){
        //通过id获取页面（已通过审核）
        TravelNoteAndUser travelNoteAndUser = wxTravelNoteService.selectNoteAndUser(id);
        wxTravelNoteService.updateBrowseTimes(id);
        model.addAttribute("travelNoteAndUser",travelNoteAndUser);
        return "wechat/society/society-journey";
    }

    /**
     * 社区显示游记列表
     * @return
     */
    @RequestMapping("/showJourneyIndex")
    public String showJourneyindex(){
        return "wechat/society/society-journeyList";
    }

    /**
     * 社区显示游记列表
     * @return
     */
    @RequestMapping("/showAddJourney")
    public String showAddJourneyindex(){
        return "wechat/society/addJourney";
    }

    /**
     * 用户点赞
     * @param id  游记id
     * @param userId
     * @return
     */
    @RequestMapping(value = "/journeyAppreciatied")
    @ResponseBody
    public int journeyAppreciatied(String id, String userId){
        return wxTravelNoteService.insertAppreciation(id, userId);
    }

    /**
     * 判断该用户有没有给指定的游记点过赞
     * @return 返回0表示没有，1表示有
     */
    @RequestMapping(value = "/isAppreciated")
    @ResponseBody
    public int isAppreciated(String id, String userId){
        return wxTravelNoteService.isAppreciated(id, userId);
    }


    /**
     * 显示游记列表数据(已审核)
     * userId,pageNum,,pageSize
     * @return
     */
    @RequestMapping("/showJourneyListAtMine")
    @ResponseBody
    public PageInfo<TravelNoteAndUser> showJourneyListAtMine(User user,Integer pageNum, Integer pageSize){
        try {
            PageInfo<TravelNoteAndUser> travelNoteAndUserList = wxTravelNoteService.getNoteAtMine(user,pageNum,pageSize);
            return travelNoteAndUserList;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 显示草稿列表数据(未审核)
     * userId,pageNum,,pageSize
     * @return
     */
    @RequestMapping("/showDraftListAtMine")
    @ResponseBody
    public PageInfo<TravelNoteAndUser> showDraftListAtMine(User user,Integer pageNum, Integer pageSize){
        try {
            PageInfo<TravelNoteAndUser> travelNoteAndUserList = wxTravelNoteService.getDraftAtMine(user,pageNum,pageSize);
            return travelNoteAndUserList;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 新增个游记
     */
    @RequestMapping("/addJourney")
    @ResponseBody
    public String setQRCode(TravelNoteVo travelNoteVo, HttpServletRequest request) {
//        HttpSession session = request.getSession();
//
//        User user = (User) session.getAttribute("userInfo");
//        travelNoteVo.setUserId(user.getId());
        Condition condition = wxTravelNoteService.addJourney(travelNoteVo);
        return new Gson().toJson(condition);
    }


    /**
     * 修改草稿
     */
    @RequestMapping("/editJourney")
    @ResponseBody
    public String editJourney(TravelNoteVo travelNoteVo, HttpServletRequest request) {
//        HttpSession session = request.getSession();
//
//        User user = (User) session.getAttribute("userInfo");
//        travelNoteVo.setUserId(user.getId());
        Condition condition = wxTravelNoteService.editJourney(travelNoteVo);
        return new Gson().toJson(condition);
    }

    /**
     * 插入图片时下载图片
     * @return
     */
    @RequestMapping("/insertPicBtn")
    @ResponseBody
    public List<PicUrlVo> insertPicBtn(String[] serverIds) {
        List<PicUrlVo> picUrlVoList = wxTravelNoteService.insertPicBtn(serverIds);
        return picUrlVoList;
    }

    /**
     * 修改草稿状态
     * @param travelNote
     * @return
     */
    @RequestMapping("/changeDraftState")
    @ResponseBody
    public Condition changeDraftState(TravelNote travelNote){
        Condition condition = wxTravelNoteService.changDraft(travelNote);
        return condition;
    }

    /**
     * 删除草稿
     * @param travelNote
     * @return
     */
    @RequestMapping("/deleteDraft")
    @ResponseBody
    public Condition deleteDraft(TravelNote travelNote){
        Condition condition = wxTravelNoteService.deleteDraft(travelNote);
        return condition;
    }
}
