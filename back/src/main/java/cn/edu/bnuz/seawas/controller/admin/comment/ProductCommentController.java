package cn.edu.bnuz.seawas.controller.admin.comment;

import cn.edu.bnuz.seawas.entity.Admin;
import cn.edu.bnuz.seawas.entity.ProductComment;
import cn.edu.bnuz.seawas.service.admin.CommentService;
import cn.edu.bnuz.seawas.utils.JsonMapper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * 产品评论controller
 * Created by tomviss on 2017/7/29.
 */
@Controller
@RequestMapping("/admin/productComment")
public class ProductCommentController {
    @Autowired
    public CommentService commentService;

    /**
     * 显示产品评论数据
     * @param productComment
     * @param objectId
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/showData")
    public String showData(ProductComment productComment, String objectId, Model model, HttpServletRequest request){
        try {
        //查询得到所有的活动名称（选择查询）
        Map<String,String> allProductName = commentService.selectAllProductName();
        model.addAttribute("allProductName", allProductName);

        if(objectId != null&&!(objectId.equals(""))){
            productComment.setProductId(objectId);
        }
        //-----------------------------------分页开始------------------------------------------------------
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
        PageInfo<ProductComment> productCommentPageInfo = commentService.selectALLPCCommentPage(pageNum,pageSize,productComment);
       //------------------------------------分页结束-------------------------------------------------------
        model.addAttribute("allComment", productCommentPageInfo);
        model.addAttribute("objectId",objectId);

        return "admin/activityMng-comment";
        }catch (Exception e){
            e.printStackTrace();
            return "admin/error";
        }
    }

    /**
     * 批量删除
     * @param idSelected
     * @return
     */
    @RequestMapping("delete")
    public @ResponseBody
    int delete(String idSelected) {
        System.out.println("selectedCommentid:" + idSelected);
        int result = commentService.deleteComments(idSelected);
        return result;
    }

    /**
     * 系统回复用户
     * @param managerReplyContent
     * @param commentId
     * @param request
     * @return
     */
    @RequestMapping("managerReply")
    public @ResponseBody
    int managerReply(String managerReplyContent, String commentId, HttpServletRequest request) {
        System.out.println("系统回复用户【开始】 回复内容:" + managerReplyContent + "被回复评论的id:" + commentId);

        Admin a = (Admin) request.getSession().getAttribute("admin");

        ProductComment productComment = commentService.selectByPrimaryKey(commentId);
        productComment.setSysReply(managerReplyContent);
        int result = commentService.updateByPrimaryKey(productComment);

        return result;
    }

    @RequestMapping("showPicture")
    public @ResponseBody
    void showPicture(String commentId, HttpServletRequest request, HttpServletResponse response, Model model) {
        List<String> picUrl = commentService.selectPicture(commentId);
        String jsonObj = JsonMapper.toJsonString(picUrl);
        try {
            response.getWriter().print(jsonObj);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
