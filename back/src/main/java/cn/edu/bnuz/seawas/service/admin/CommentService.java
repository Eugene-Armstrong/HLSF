package cn.edu.bnuz.seawas.service.admin;

import cn.edu.bnuz.seawas.dao.ProductCommentMapper;
import cn.edu.bnuz.seawas.dao.ProductMapper;
import cn.edu.bnuz.seawas.dao.TravelCommentMapper;
import cn.edu.bnuz.seawas.entity.Product;
import cn.edu.bnuz.seawas.entity.ProductComment;
import cn.edu.bnuz.seawas.entity.TravelComment;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * 产品、游记评论service
 * Created by tomviss on 2017/7/29.
 */
@Service(value = "commentService")
public class CommentService {
    @Autowired
    private ProductCommentMapper productCommentMapper;
    @Autowired
    private TravelCommentMapper travelCommentMapper;
    @Autowired
    private  ProductMapper productMapper;

    /*通过条件查找所有的产品评论*/
   public  List<ProductComment> selectAllPCSelective(ProductComment record){
        return productCommentMapper.selectAllSelective(record);
    }

    /*分页*/
    public PageInfo<ProductComment> selectALLPCCommentPage(Integer pageNum, Integer pageSize,ProductComment productComment) {
        int count = 0;
        pageNum = pageNum == null ? 1 : pageNum;
        pageSize = pageSize == null ? 10 : pageSize;
        PageHelper.startPage(pageNum,pageSize);

        PageInfo<ProductComment> ProductCommentPageInfo = new PageInfo<ProductComment>(productCommentMapper.selectAllSelective(productComment));

        return ProductCommentPageInfo;
    }
    /*查找得到所有的产品名称*/
    public Map<String,String> selectAllProductName(){
        List<Product> products = productMapper.selectAllProduct();
        Map<String,String> map = new HashMap<String, String>();
        // List<Map<String,String>> proNameAndId = null;
        for (Product p:products) {
            String pName = p.getName();
            String pId   = p.getId();

            map.put(pId,pName);
            //  proNameAndId.add()
        }
        return map;
    }

    /**
     * 批量删除产品评论
     * @param idString
     * @return
     */
    public int deleteComments(String idString){
        String[] Str = idString.split(",");
        int result = 1;
        List<ProductComment> productComments = new ArrayList<ProductComment>();
        for (String s : Str){
            ProductComment productComment = new ProductComment();
            productComment.setId(s);
            productComments.add(productComment);
        }
        result = productCommentMapper.deleteProductComments(productComments);
        return result;
    }


    /**
     * 通过id找到ProductComment对象
     * @param commentId
     * @return comment
     */
    public ProductComment selectByPrimaryKey(String commentId){
        return productCommentMapper.selectByPrimaryKey(commentId);
    }


    /**
     * tom
     * 通过id更新ProductComment
     * @param record
     * @return
     */
    public int updateByPrimaryKey(ProductComment record){
        return productCommentMapper.updateByPrimaryKey(record);
    }

    public List<String> selectPicture(String commentId){
        ProductComment productComment = productCommentMapper.selectByPrimaryKey(commentId);
        String[] urls = productComment.getPicUrl().split(",");

        return Arrays.asList(urls);//String数组转list
    }

    /**
     * 条件查询所有的游记评论
     * @param travelComment
     * @return
     */
   public List<TravelComment> selectAllTCSelective(TravelComment travelComment){
        return travelCommentMapper.selectAllSelective(travelComment);
    }

    public PageInfo<TravelComment> selectAllTCSelectivePage(Integer pageNum, Integer pageSize, TravelComment travelComment){
        int count = 0;
        pageNum = pageNum == null ? 1 : pageNum;
        pageSize = pageSize == null ? 10 : pageSize;
        PageHelper.startPage(pageNum,pageSize);
        PageInfo<TravelComment> travelCommentPageInfo = new PageInfo<TravelComment>(travelCommentMapper.selectAllSelective(travelComment));
        return travelCommentPageInfo;
    }

    /**
     * 批量删除游记评论
     * @param idString
     * @return
     */
    public int deleteJourneyComments(String idString){
        String[] Str = idString.split(",");
        int result = 1;
        List<TravelComment> travelComments = new ArrayList<TravelComment>();
        for (String s : Str){
            TravelComment travelComment = new TravelComment();
            travelComment.setId(s);
            travelComments.add(travelComment);
        }
        result = travelCommentMapper.deleteJourneyComments(travelComments);
        return result;
    }

}
