package cn.edu.bnuz.seawas.dao;

import cn.edu.bnuz.seawas.entity.Media;
import cn.edu.bnuz.seawas.entity.Product;
import cn.edu.bnuz.seawas.vo.ProductDetail;
import cn.edu.bnuz.seawas.vo.ProductVo;
import cn.edu.bnuz.seawas.vo.wechat.ProductAndActivityVo;
import cn.edu.bnuz.seawas.vo.wechat.ProductForSort;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 产品表DAO接口
 * Created by sjk on 2017-07-28.
 */
public interface ProductMapper {

    /**
     * 逻辑删除
     * @param id id
     */
    int delete(String id);

    /**
     * 插入数据
     * @param product product
     */
    int insert(Product product);

    /**
     * 非空插入
     * @param product product
     */
    int insertSelective(Product product);

    /**
     * 获取单条数据
     * @param product product
     */
    Product get(Product product);

    ProductDetail selectbyid(String id);

    /**
     * 非空更新
     * @param product product
     */
    int updateByPrimaryKeySelective(Product product);

    /**
     * 更新数据
     * @param product product
     */
    int update(Product product);

    /**
     * 列表查询
     * @param product product
     */
    List<Product> findList(Product product);

    /**
     * 查询得到所有的产品
     * @return List product
     */
    List<Product> selectAllProduct();

    /**
     * 有条件查询产品
     * @param productVo
     * @return
     */
    List<ProductVo> findAllProduct(ProductVo productVo);

    /**
     * 产品详情
     * @param id
     * @return
     */
    ProductDetail selectProductById(String id);

    /**
     * 媒体管理
     * 通过城市
     * 选择产品列表
     */
    List<Product> findMediaProductList(Media media);

    /**
     * 获取下架产品列表
     * @param productVo
     * @return
     */
    List<ProductVo> showOffSaleProductPage(ProductVo productVo);

    /**
     * 重新上架
     * @param id id
     */
    int onSale(String id);

    /**
     * 通过定制id找产品id
     * @param customizedId
     * @return
     */
    String findIdByCustom(String customizedId);

    /**
     * wifi
     * 通过产品id获得产品信息
     * @param productId
     * @return
     */
    Product selectProductByProductId(@Param("productId") String productId);

    /**
     * tangshihui
     * 通过userid获取用户收藏的product
     * @param userId
     * @return
     */
    List<Product> selectProductByUserId(String userId);

    /**
     * 通过分类得到所有更多分类页面二级页面产品
     */
    List<ProductVo> findAllProductBySort(Product product);

    /**
     * 通过难度得到所有更多分类页面二级页面产品
     */
    List<ProductVo> findAllProductByDiff(Product product);

    /**
     * 通过目的地得到所有更多分类页面二级页面产品
     */
    List<ProductForSort> findAllProductByDist(ProductVo productVo);

}