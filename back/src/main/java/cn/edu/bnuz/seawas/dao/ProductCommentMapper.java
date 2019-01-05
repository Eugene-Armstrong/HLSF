package cn.edu.bnuz.seawas.dao;

import cn.edu.bnuz.seawas.entity.ProductComment;
import cn.edu.bnuz.seawas.vo.ChangeProductGrade;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ProductCommentMapper {
    int deleteByPrimaryKey(String id);

    int insert(ProductComment record);

    int insertSelective(ProductComment record);

    ProductComment selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(ProductComment record);

    int updateByPrimaryKeyWithBLOBs(ProductComment record);

    int updateByPrimaryKey(ProductComment record);

    /*条件查询所有的活动评价*/
    List<ProductComment> selectAllSelective(ProductComment record);

    /*判断用户是否被回复*/
    ProductComment isReply(String id);

    /*批量删除活动评价*/
    int deleteProductComments(@Param("comments") List<ProductComment> comments);

    ProductComment selectByUserIdAndActId(ProductComment productComment);

    int updateProductScore(ChangeProductGrade changeProductGrade);
}