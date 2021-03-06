package cn.edu.bnuz.seawas.controller.admin.product;

import cn.edu.bnuz.seawas.dto.AddProductDto;
import cn.edu.bnuz.seawas.entity.*;
import cn.edu.bnuz.seawas.service.admin.CategoryService;
import cn.edu.bnuz.seawas.service.admin.CityService;
import cn.edu.bnuz.seawas.service.admin.CommentService;
import cn.edu.bnuz.seawas.service.admin.EquipmentService;
import cn.edu.bnuz.seawas.service.admin.product.DestinationService;
import cn.edu.bnuz.seawas.service.admin.product.ProductService;
import cn.edu.bnuz.seawas.vo.ProductDetail;
import cn.edu.bnuz.seawas.vo.ProductVo;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageInfo;
import com.google.gson.Gson;
import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * Created by Zrj on 2017/7/24.
 * 产品管理
 */
@Controller
@RequestMapping("/product")
public class ProductController {
    @Autowired
    private ProductService productService;
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private CityService cityService;
    @Autowired
    private EquipmentService equipmentService;
    @Autowired
    private CommentService commentService;
    @Autowired
    private DestinationService destinationService;

    @RequestMapping("/showProduct")
    public String showProduct(ProductVo productVo, Model model, HttpServletRequest request) {
        try {
            //获取检索对象
            if (productVo == null) {
                productVo = new ProductVo();
            }
            //设置分页设置
            int pageNum = 1;
            int pageSize = 10;

            //分页信息获取
            if (request.getParameter("pageNumber") != null && !"".equals(request.getParameter("pageNumber"))) {
                pageNum = Integer.parseInt(request.getParameter("pageNumber"));
            }
            if (request.getParameter("pageSize") != null && !"".equals(request.getParameter("pageSize"))) {
                pageSize = Integer.parseInt(request.getParameter("pageSize"));
            }

            //查询数据
            PageInfo<ProductVo> productLiset = productService.showProductPage(pageNum, pageSize, productVo);
            List<Classification> sortList = categoryService.findList();
            List<City> cityList = cityService.findList();


            //向前端传输数据
            model.addAttribute("pageInfo", productLiset);
            model.addAttribute("productVo", productVo);
            model.addAttribute("cityList", cityList);
            model.addAttribute("sortList", sortList);



            return "admin/productMng/productMng";
        } catch (Exception e) {
            //异常跳转
            e.printStackTrace();
            return "admin/error";
        }
    }

    //删除一个产品
    @RequestMapping("/deleteProduct")
    @ResponseBody
    public String deleteProduct(String[] productId) throws Exception {
        for (int i = 0; i < productId.length; i++) {
            productService.delete(productId[i]);
        }
        Map<String, String> a = new HashedMap();
        a.put("name", "aaaa");
        return new Gson().toJson(a);
    }

    /**
     * 显示添加产品界面
     * @param model
     * @return
     */
    @RequestMapping("/showAddProduct")
    public String showAddProduct(Model model) {
        List<Classification> sortList = categoryService.findList();
        List<City> cityList = cityService.findList();
        List<Equipment> equipmentList = equipmentService.selectEquipmentsMessage();
        List<Destination> destinationList = destinationService.findList();

        model.addAttribute("cityList", cityList);
        model.addAttribute("sortList", sortList);
        model.addAttribute("equipmentList", equipmentList);
        model.addAttribute("destinationList", destinationList);
        return "admin/productMng/productMng-add";
    }

    @RequestMapping("/addProduct")
    @ResponseBody
    public String addProduct(AddProductDto webData) throws IOException {

        System.out.println("webData"+webData);

        String productId = productService.CreateComProduct(webData);

        Map<String, String> a = new HashedMap();
        a.put("productId", productId);
        return new Gson().toJson(a);
    }


    @RequestMapping("/showProductDetailData")
    @ResponseBody
    public String showProductDetail(String id) {
        ProductDetail productDetail = productService.selectProductById(id);
        System.out.print(productDetail);
        String jsonData = new Gson().toJson(productDetail);
        JSONObject jsonObject = JSON.parseObject(jsonData);
        jsonObject.remove("equipmentMessage");
        return jsonObject.toJSONString();
    }


    @RequestMapping("/showProductDetail")
    public String showProductDetail(Model model, String id) {
        model.addAttribute("id", id);
        return "admin/productMng/productMng-productDetail";
    }

    /**
     * 显示修改产品界面
     * @param model
     * @param id
     * @return
     */
    @RequestMapping("/showProductChange")
    public String showProductChange(Model model, String id) {
        model.addAttribute("id", id);
        List<Classification> sortList = categoryService.findList();
        List<City> cityList = cityService.findList();
        List<Equipment> equipmentList = equipmentService.selectEquipmentsMessage();
        List<Destination> destinationList = destinationService.findList();
        model.addAttribute("cityList", cityList);
        model.addAttribute("sortList", sortList);
        model.addAttribute("equipmentList", equipmentList);
        model.addAttribute("destinationList", destinationList);
        return "admin/productMng/productMng-change";
    }

    @RequestMapping("/updateProduct")
    @ResponseBody
    public String updateProduct(AddProductDto webData, String product_id) throws IOException {

        System.out.print(webData);

        String productId = productService.UpdateComProduct(webData, product_id);

        Map<String, String> a = new HashedMap();
        a.put("productId", productId);
        return new Gson().toJson(a);
    }

    /*找到对应产品的评论*/
    @RequestMapping("/findComment")
    public String findComment(String productId, Model model, HttpServletRequest request) {
        try {
             ProductComment productComment = new ProductComment();
              productComment.setProductId(productId);
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

            return "admin/productMng/productMng-comment";
        }catch (Exception e){
            e.printStackTrace();
            return "admin/error";
        }
    }

    @RequestMapping("/ShowOffSaleProduct")
    public String ShowOffSaleProduct(ProductVo productVo, Model model, HttpServletRequest request) {
//        try {
            //获取检索对象
            if (productVo == null) {
                productVo = new ProductVo();
            }
            //设置分页设置
            int pageNum = 1;
            int pageSize = 10;

            //分页信息获取
            if (request.getParameter("pageNumber") != null && !"".equals(request.getParameter("pageNumber"))) {
                pageNum = Integer.parseInt(request.getParameter("pageNumber"));
            }
            if (request.getParameter("pageSize") != null && !"".equals(request.getParameter("pageSize"))) {
                pageSize = Integer.parseInt(request.getParameter("pageSize"));
            }

            //查询数据
            PageInfo<ProductVo> productList = productService.showOffSaleProductPage(pageNum, pageSize, productVo);

            model.addAttribute("productVo", productVo);
            model.addAttribute("pageInfo", productList);

            return "admin/productMng/productMng-offSale";
//        } catch (Exception e) {
//            //异常跳转
//            e.printStackTrace();
//            return "error";
//        }
    }

    //上架一个产品
    @RequestMapping("/onSalProduct")
    @ResponseBody
    public String onSalProduct(String[] productId) throws Exception {
        for (int i = 0; i < productId.length; i++) {
            productService.onSale(productId[i]);
        }
        Map<String, String> a = new HashedMap();
        a.put("name", "aaaa");
        return new Gson().toJson(a);
    }
}
