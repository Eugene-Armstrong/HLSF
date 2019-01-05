package cn.edu.bnuz.seawas.controller.weChat.mine;

import cn.edu.bnuz.seawas.entity.Contact;
import cn.edu.bnuz.seawas.service.weChat.mine.ContactService;
import cn.edu.bnuz.seawas.utils.UUIDUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * Created by Zrj on 2017/9/12.
 * 常用人相关的Controller
 */
@Controller
@RequestMapping(value = "/wechat/contact")
public class ContactController {
    @Autowired
    ContactService contactService;

    /**
     *  显示常用人列表
     */
    @RequestMapping("/showMineFrequentUsers")
    public String showMineFrequentUsers(String id, Model model) {
        List<Contact> contactsList = null;
        contactsList = contactService.selectContactListByUser(id);
        model.addAttribute("contactsList",contactsList);
        model.addAttribute("userId",id);

        return "wechat/mine/mine-frequentUsers";
    }
    /**
     * 添加常用人
     */
    @RequestMapping("/addFrequentUsers")
    @ResponseBody
    public int addFrequentUsers(Model model, Contact contact) {
        int i = contactService.insertSelective(contact);
        model.addAttribute("id",contact.getUserId());
        return i;
    }
    /**
     * 删除常用人
     */
    @RequestMapping("/deleteFrequentUsers")
    @ResponseBody
    public String deleteFrequentUsers(String conId) {
        int i = contactService.deleteByPrimaryKey(conId);
        return conId;
    }
}
