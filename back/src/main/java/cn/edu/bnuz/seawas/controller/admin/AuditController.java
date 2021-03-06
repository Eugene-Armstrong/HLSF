package cn.edu.bnuz.seawas.controller.admin;

import cn.edu.bnuz.seawas.entity.*;
import cn.edu.bnuz.seawas.service.admin.*;
import cn.edu.bnuz.seawas.service.admin.product.ProductService;
import cn.edu.bnuz.seawas.service.weChat.mine.AlbumService;
import cn.edu.bnuz.seawas.utils.Condition;
import cn.edu.bnuz.seawas.utils.WebUtil;
import com.github.pagehelper.PageInfo;
import com.google.gson.Gson;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 管理员端审核Controller
 * Created by sjk on 2017-07-31.
 */
@Controller
@RequestMapping(value = "/admin/audit")
public class AuditController {
    @Autowired
    private ProductService productService;
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private CityService cityService;
    @Autowired
    private EquipmentService equipmentService;
    @Autowired
    private AuditService auditService;
    @Autowired
    private TravelNoteService travelNoteService;
    @Autowired
    private CustomService customService;

    @Autowired
    private AlbumService albumService;

    //------------------------------相片审核----------------------------------------------------------
    /**
     * 跳转到照片审核界面
     */
    @RequestMapping(value = "/photo")
    public String photoPage(Model model, Photo photo) {
        try {
            //默认查询未审核状态
            if (photo.getState() == null || StringUtils.isBlank(photo.getState())) {
                photo.setState("1");
            }

            int pageNum = 1;
            int pageSize = 10;

            //分页信息获取
            if (WebUtil.getRequestAttribute("pageNumber") != null && !"".equals(WebUtil.getRequestAttribute("pageNumber"))) {
                pageNum = Integer.parseInt((String) WebUtil.getRequestAttribute("pageNumber"));
            }
            if (WebUtil.getRequestAttribute("pageSize") != null && !"".equals(WebUtil.getRequestAttribute("pageSize"))) {
                pageSize = Integer.parseInt((String) WebUtil.getRequestAttribute("pageSize"));
            }

            //查询数据
            PageInfo<User> pageInfo = auditService.showPhotoUserPage(pageNum, pageSize, photo);

            //向前端传输数据
            model.addAttribute("pageInfo", pageInfo);

            return "/admin/auditMng/auditMng-photo";
        } catch (Exception e) {
            e.printStackTrace();
            return "admin/error";
        }
    }

    /**
     * 跳转到用户相册列表
     */
    @RequestMapping(value = "/photo/album")
    public String showAlbumPage(Model model, Album album) {
        try {
            int pageNum = 1;
            int pageSize = 10;

            //分页信息获取
            if (WebUtil.getRequestAttribute("pageNumber") != null && !"".equals(WebUtil.getRequestAttribute("pageNumber"))) {
                pageNum = Integer.parseInt((String) WebUtil.getRequestAttribute("pageNumber"));
            }
            if (WebUtil.getRequestAttribute("pageSize") != null && !"".equals(WebUtil.getRequestAttribute("pageSize"))) {
                pageSize = Integer.parseInt((String) WebUtil.getRequestAttribute("pageSize"));
            }

            //查询数据
            PageInfo<Album> pageInfo = auditService.showAlbumPage(pageNum, pageSize, album);

            //如果该用户没有相册，就跳转到相册审核的首页，这是为了应对管理员删除相册后，刷新相册列表页面但是没有相册的情况
            if (pageInfo == null || pageInfo.getList() == null || pageInfo.getList().size() == 0) {
                return "redirect:/admin/audit/photo";
            }

            model.addAttribute("album", pageInfo.getList().get(0));
            model.addAttribute("pageInfo", pageInfo);

            return "admin/auditMng/auditMng-seeAlbum";
        } catch (Exception e) {
            e.printStackTrace();
            return "admin/error";
        }
    }

    /**
     * 查看相册中的图片
     */
    @RequestMapping(value = "/photo/show")
    public String showUserPhoto(Model model, Photo photo) {
        try {
            model.addAttribute("photoList", auditService.findPhotoByAlbum(photo));
            model.addAttribute("album", albumService.get(photo.getAlbum()));
            return "/admin/auditMng/auditMng-seePhoto";
        } catch (Exception e) {
            e.printStackTrace();
            return "admin/error";
        }
    }

    /**
     * 删除相册
     */
    /*@RequestMapping(value = "/deleteAlbum")
    @ResponseBody
    public String deleteAlbum(Album album) {
        try {
            Condition condition = albumService.deleteAlbum(album);
            return new Gson().toJson(condition);
        } catch (Exception e) {
            e.printStackTrace();
            return new Gson().toJson(new Condition(Condition.ERROR_CODE, "系统繁忙"));
        }
    }*/

    /**
     * 批量删除相册
     */
    @RequestMapping(value = "/deleteAlbum")
    public String deleteBatch(String[] albumIds, String userId) {
        try {
            for (String albumId : albumIds) {
                albumService.deleteAlbum(new Album(albumId));
            }
            return "redirect:/admin/audit/photo/album?user.id=" + userId;
        } catch (Exception e) {
            e.printStackTrace();
            return "admin/error";
        }
    }

    /**
     * 审核照片
     */
    @RequestMapping(value = "/photo/audit",
            method = RequestMethod.POST)
    @ResponseBody
    public String auditPhoto(String[] photoIds, String state, HttpServletRequest request) {
        try {
            for (String photoId : photoIds) {
                auditService.auditPhoto(new Photo(photoId), request, state);
            }
            return new Gson().toJson(new Condition(Condition.SUCCESS_CODE, "操作成功"));
        } catch (Exception e) {
            e.printStackTrace();
            return new Gson().toJson(new Condition(Condition.ERROR_CODE, "系统繁忙"));
        }
    }
//--------------------------------游记审核-------------------------------------------------------------------
    /**
     * tomviss
     * 查询所有的游记
     * @return
     */
    @RequestMapping(value = "/journey")
    public String journey(Model model, HttpServletRequest request,TravelNote travelNote){
     try {
         //查询得到未审核的游记
         if (travelNote.getState() == null){
             travelNote = new TravelNote();
             travelNote.setState("0");
         }

         // 默认当前页为1，每页数量为2
         int pageNum = 1;
         int pageSize = 10;

         //分页信息获取
         if (request.getParameter("pageNumber") != null && !"".equals(request.getParameter("pageNumber"))) {
             pageNum = Integer.parseInt(request.getParameter("pageNumber"));
         }
         if (request.getParameter("pageSize") != null && !"".equals(request.getParameter("pageSize"))) {
             pageSize = Integer.parseInt(request.getParameter("pageSize"));
         }
         PageInfo<TravelNote> travelNotePageInfo = travelNoteService.selectAllNoteSelectivePage(pageNum, pageSize, travelNote);
         model.addAttribute("pageInfo", travelNotePageInfo);
         model.addAttribute("travelNote",travelNote);

         return "/admin/auditMng/auditMng-journey";
     } catch (Exception e) {
         e.printStackTrace();
         return "admin/error";
     }
    }

    /**
     * 批量删除游记
     * @param idSelected
     * @return
     */
    @RequestMapping("/journey/delete")
    public @ResponseBody  int delete(String idSelected){
        System.out.println("删除id"+idSelected);
        return  travelNoteService.delete(idSelected);
    }

    /**
     * 发送不通过的原因
     * @param rejectId
     * @param managerReplyContent
     * @return
     */
    @RequestMapping("/journey/sendReason")
    public  @ResponseBody int sendReason(String rejectId, String managerReplyContent,HttpServletRequest request){
        System.out.println("回复id"+rejectId);
        Admin a = (Admin) request.getSession().getAttribute("admin");
        String adminId = a.getId();
        return travelNoteService.sendReason(rejectId,managerReplyContent,adminId);
    }

    /**
     * 更多详情
     * @param noteId
     * @param model
     * @return
     */
    @RequestMapping("/journey/moreDetail")
    public String moreDetail (String noteId, Model model){
        try {
            TravelNote travelNote = new TravelNote();
            travelNote.setId(noteId);
            List<TravelNote> travelNotes = travelNoteService.selectAllNoteSelective(travelNote);//获取相应id的游记

            model.addAttribute("travelNote", travelNotes);

            return "admin/auditMng/auditMng-journeyDetail";
        } catch (Exception e) {
            e.printStackTrace();
            return "admin/error";
        }
    }

    /**
     * 游记审核通过
     * @param noteId
     * @param request
     * @return
     */
    @RequestMapping("/journey/pass")
    public  String pass(String noteId,HttpServletRequest request){
        try {
            //得到当前管理员的id
            Admin a = (Admin) request.getSession().getAttribute("admin");
            String adminId = a.getId();

            travelNoteService.auditPass(noteId, adminId);
            return "redirect:/admin/audit/journey";
        } catch (Exception e) {
                e.printStackTrace();
                return "admin/error";
            }
    }

    //------------------------------企业定制审核----------------------------------------------------------
    @RequestMapping("/company")
    public String company(Model model,HttpServletRequest request){
        try {

            //得到所有的未审核的企业定制申请
            Custom custom = new Custom();
            custom.setType("0");//0表示企业定制、1表示约伴
            custom.setState("0");//0表示未审核、1审核通过、2审核未通过
            //-----------------------------------分页开始------------------------------------------------------
            // 默认当前页为1，每页数量为2
            int pageNum1 = 1;
            int pageSize1 = 10;

            //分页信息获取
            if (request.getParameter("pageNumber1") != null && !"".equals(request.getParameter("pageNumber1"))) {
                pageNum1 = Integer.parseInt(request.getParameter("pageNumber1"));
            }
            if (request.getParameter("pageSize1") != null && !"".equals(request.getParameter("pageSize1"))) {
                pageSize1 = Integer.parseInt(request.getParameter("pageSize1"));
            }
            PageInfo<Custom> customPageInfo = customService.selectCustomSelectivePage(pageNum1, pageSize1, custom);
            //------------------------------------分页结束-------------------------------------------------------
            model.addAttribute("customs", customPageInfo);




            //得到审核通过的企业定制申请
            Custom passCustom = new Custom();
            passCustom.setType("0");
            passCustom.setState("1");
            //-----------------------------------分页开始------------------------------------------------------
            // 默认当前页为1，每页数量为2
            int pageNum2 = 1;
            int pageSize2 = 10;

            //分页信息获取
            if (request.getParameter("pageNumber2") != null && !"".equals(request.getParameter("pageNumber2"))) {
                pageNum1 = Integer.parseInt(request.getParameter("pageNumber2"));
            }
            if (request.getParameter("pageSize2") != null && !"".equals(request.getParameter("pageSize2"))) {
                pageSize1 = Integer.parseInt(request.getParameter("pageSize2"));
            }
            PageInfo<Custom> passCustomPageInfo = customService.selectCustomSelectivePage(pageNum2, pageSize2, passCustom);
            //------------------------------------分页结束-------------------------------------------------------
            model.addAttribute("passCustoms", passCustomPageInfo);




            //得到审核不通过的企业定制申请
            Custom unpassCustom = new Custom();
            unpassCustom.setType("0");
            unpassCustom.setState("2");
            //-----------------------------------分页开始------------------------------------------------------
            // 默认当前页为1，每页数量为2
            int pageNum3 = 1;
            int pageSize3 = 10;

            //分页信息获取
            if (request.getParameter("pageNumber3") != null && !"".equals(request.getParameter("pageNumber3"))) {
                pageNum1 = Integer.parseInt(request.getParameter("pageNumber3"));
            }
            if (request.getParameter("pageSize3") != null && !"".equals(request.getParameter("pageSize3"))) {
                pageSize1 = Integer.parseInt(request.getParameter("pageSize3"));
            }
            PageInfo<Custom> unpassCustomPageInfo = customService.selectCustomSelectivePage(pageNum3, pageSize3, unpassCustom);
           //------------------------------------分页结束-------------------------------------------------------
            model.addAttribute("unpassCustoms", unpassCustomPageInfo);

            return "admin/auditMng/auditMng-company";
        } catch (Exception e) {
            e.printStackTrace();
            return "admin/error";
        }
    }

    /*获取定制详情*/
    @RequestMapping("/company/detail")
    public String detail(String customId,Model model){
        try {
            Custom custom = customService.get(customId);

            model.addAttribute("custom", custom);
            return "admin/auditMng/auditMng-companyDetail";
        } catch (Exception e) {
            e.printStackTrace();
            return "admin/error";
        }
    }

     /*发送否决理由*/
    @RequestMapping("/company/sendReason")
    public @ResponseBody int companySendReason(String rejectId,String replyContent,HttpServletRequest request){
        Custom custom = customService.get(rejectId);
        custom.setState("2");//0表示未审核、1审核通过、2审核未通过
        custom.setRemark(replyContent);
        Admin a = (Admin)request.getSession().getAttribute("admin");
        custom.setAdmin(a);

        return customService.update(custom);
    }

    /*通过并发布成一个产品*/
    @RequestMapping("/company/pass")
    public String pass(String customId,Model model,HttpServletRequest request){
        try {
            Custom custom = customService.get(customId);
            custom.setState("1");
            Admin a = (Admin) request.getSession().getAttribute("admin");
            custom.setAdmin(a);
            customService.update(custom);

            List<Classification> sortList = categoryService.findList();
            List<City> cityList = cityService.findList();
            List<Equipment> equipmentList = equipmentService.selectEquipmentsMessage();
            model.addAttribute("cityList", cityList);
            model.addAttribute("sortList", sortList);
            model.addAttribute("equipmentList", equipmentList);
            model.addAttribute("customizedId", customId);

            return "admin/productMng/productMng-add";
        } catch (Exception e) {
            e.printStackTrace();
            return "admin/error";
        }
    }

    /*查看已通过的详情*/
    @RequestMapping("/company/showPassDetail")
    public String showPassDetail(String customizedId,Model model){
        try {
            String id = productService.findIdByCustom(customizedId);
            model.addAttribute("id", id);
            return "admin/auditMng/auditMng-passDetail";
        } catch (Exception e) {
            e.printStackTrace();
            return "admin/error";
        }

    }

    /*批量删除企业定制*/
    @RequestMapping("/company/deleteCustoms")
    public @ResponseBody int deleteCustoms(String idSelected){
        return customService.deleteCustoms(idSelected);
    }



    //--------------------------------------约伴审核------------------------------------------------------------
    @RequestMapping("/partner")
    public String partner(Model model,HttpServletRequest request) {
        try {
            //得到所有的未审核的约伴申请
            Custom custom = new Custom();
            custom.setType("1");//0表示企业定制、1表示约伴
            custom.setState("0");//0表示未审核、1审核通过、2审核未通过
            //-----------------------------------分页开始------------------------------------------------------
            // 默认当前页为1，每页数量为2
            int pageNum1 = 1;
            int pageSize1 = 10;

            //分页信息获取
            if (request.getParameter("pageNumber1") != null && !"".equals(request.getParameter("pageNumber1"))) {
                pageNum1 = Integer.parseInt(request.getParameter("pageNumber1"));
            }
            if (request.getParameter("pageSize1") != null && !"".equals(request.getParameter("pageSize1"))) {
                pageSize1 = Integer.parseInt(request.getParameter("pageSize1"));
            }
            PageInfo<Custom> customPageInfo = customService.selectCustomSelectivePage(pageNum1, pageSize1, custom);
          //------------------------------------分页结束-------------------------------------------------------
            model.addAttribute("customs", customPageInfo);




            //得到审核通过的约伴申请
            Custom passCustom = new Custom();
            passCustom.setType("1");
            passCustom.setState("1");
            //-----------------------------------分页开始------------------------------------------------------
            // 默认当前页为1，每页数量为2
            int pageNum2 = 1;
            int pageSize2 = 10;

            //分页信息获取
            if (request.getParameter("pageNumber2") != null && !"".equals(request.getParameter("pageNumber2"))) {
                pageNum1 = Integer.parseInt(request.getParameter("pageNumber2"));
            }
            if (request.getParameter("pageSize2") != null && !"".equals(request.getParameter("pageSize2"))) {
                pageSize1 = Integer.parseInt(request.getParameter("pageSize2"));
            }
            PageInfo<Custom> passCustomPageInfo = customService.selectCustomSelectivePage(pageNum2, pageSize2, passCustom);
           //------------------------------------分页结束-------------------------------------------------------
            model.addAttribute("passCustoms", passCustomPageInfo);



            //得到审核不通过的约伴申请
            Custom unpassCustom = new Custom();
            unpassCustom.setType("1");
            unpassCustom.setState("2");
            //-----------------------------------分页开始------------------------------------------------------
            // 默认当前页为1，每页数量为2
            int pageNum3 = 1;
            int pageSize3 = 10;

            //分页信息获取
            if (request.getParameter("pageNumber3") != null && !"".equals(request.getParameter("pageNumber3"))) {
                pageNum1 = Integer.parseInt(request.getParameter("pageNumber3"));
            }
            if (request.getParameter("pageSize3") != null && !"".equals(request.getParameter("pageSize3"))) {
                pageSize1 = Integer.parseInt(request.getParameter("pageSize3"));
            }
            PageInfo<Custom> unpassCustomPageInfo = customService.selectCustomSelectivePage(pageNum3, pageSize3, unpassCustom);
            //------------------------------------分页结束-------------------------------------------------------
            model.addAttribute("unpassCustoms", unpassCustomPageInfo);


            return "admin/auditMng/auditMng-partner";
        } catch (Exception e) {
            e.printStackTrace();
            return "admin/error";
        }
    }


    /**
     * 获取游记内容通过id
     * @return
     */
    @RequestMapping("/journey/Content")
    @ResponseBody
    public TravelNote selectContent(String id){
        TravelNote travelNote = travelNoteService.selectContent(id);
        return travelNote;
    }
}
