package cn.edu.bnuz.seawas.controller.weChat.product;

import cn.edu.bnuz.seawas.dao.OrdersMapper;
import cn.edu.bnuz.seawas.entity.Orders;
import cn.edu.bnuz.seawas.entity.ProductComment;
import cn.edu.bnuz.seawas.service.weChat.WCommentService;
import cn.edu.bnuz.seawas.utils.UUIDUtil;
import cn.edu.bnuz.seawas.vo.ChangeProductGrade;
import cn.edu.bnuz.seawas.vo.ProductCommentVo;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;

/**
 * Created by Zrj on 2017/9/24.
 */
@Controller
@RequestMapping("/wechat/comment")
public class CommentController {
    @Autowired
    WCommentService commentService;
    @Autowired
    OrdersMapper ordersMapper;

    @RequestMapping("/ShowProductComment")
    @ResponseBody
    public PageInfo<ProductComment> ShowProductComment(ProductComment productComment,Integer pageNum, Integer pageSize){
        try {
            PageInfo<ProductComment> productCommentList = commentService.selectAllPCSelective(pageNum,pageSize,productComment);
            return productCommentList;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @RequestMapping("/ShowCommentIndex")
    public String ShowCommentIndex(String id, Model model){
        Orders orders = new Orders();
        orders.setId(id);
        model.addAttribute("orders",commentService.getOrder(orders));
        return "/wechat/index/activity-comment";
    }

    @RequestMapping("/AddommentIndex")
    @ResponseBody
    public int AddommentIndex(int productScore,int leaderScore,String textarea
            ,String userId,String productId,String activityId,String orderId){
        ProductComment productComment = new ProductComment();
        productComment.setActivityId(activityId);
        productComment.setUserId(userId);
        productComment.setGrade(productScore);
        productComment.setCommentContent(textarea);
        productComment.setProductId(productId);
        productComment.setId(UUIDUtil.createUUID());
        productComment.setCreateTime(new Date());
        productComment.setOrderId(orderId);
        commentService.insertSelective(productComment);

        commentService.addLeaderScore(userId,activityId,leaderScore);

        Orders orders = new Orders();
        orders.setId(orderId);
        orders.setIsComment("1");
        ordersMapper.updateByPrimaryKeySelective(orders);

        ChangeProductGrade changeProductGrade = new ChangeProductGrade();
        changeProductGrade.setId(productId);
        changeProductGrade.setScore(productScore);
        commentService.updateProductScore(changeProductGrade);
        return 1;
    }

    @RequestMapping("/ShowCommentIndexDetail")
    public String ShowCommentIndexDetail(Model model,ProductComment productComment){
        Orders orders = new Orders();
        orders.setId(productComment.getOrderId());

        model.addAttribute("orders",commentService.getOrder(orders));
        model.addAttribute("productComment",commentService.selectByUserIdAndActId(productComment));
        return "/wechat/index/activity-commentDetail";
    }
}
