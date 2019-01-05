package cn.edu.bnuz.seawas.controller.admin.comment;

import cn.edu.bnuz.seawas.entity.TravelComment;
import cn.edu.bnuz.seawas.service.admin.CommentService;
import cn.edu.bnuz.seawas.service.admin.TravelNoteService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by tomviss on 2017/8/3.
 */
@Controller
@RequestMapping("/admin/journeyComment")
public class JourneyCommentController {

    @Autowired
    private TravelNoteService travelNoteService;
    @Autowired
    private CommentService commentService;

    /**
     * 显示游记评论数据
     * @param noteId
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/show")
    public String show(String noteId, Model model,HttpServletRequest request) {
        try {
            TravelComment travelComment = new TravelComment();
            travelComment.setTravelId(noteId);

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
            PageInfo<TravelComment> travelCommentPageInfo = commentService.selectAllTCSelectivePage(pageNum, pageSize, travelComment);
           //------------------------------------分页结束-------------------------------------------------------

            model.addAttribute("travelCommentList", travelCommentPageInfo);
            model.addAttribute("noteId", noteId);

            return "admin/auditMng/auditMng-journeyComment";
        }catch (Exception e){
            e.printStackTrace();
            return "admin/error";
        }
    }

    /**
     * 批量删除游记
     * @param idSelected
     * @return
     */
    @RequestMapping("/delete")
    public @ResponseBody
    int delete(String idSelected) {
        System.out.println("游记评论删除"+idSelected);
        return commentService.deleteJourneyComments(idSelected);
    }
}