package cn.edu.bnuz.seawas.controller.admin.TotalCount;

import cn.edu.bnuz.seawas.entity.City;
import cn.edu.bnuz.seawas.entity.Sign;
import cn.edu.bnuz.seawas.service.admin.ProductCountService;
import cn.edu.bnuz.seawas.vo.PageVo;
import cn.edu.bnuz.seawas.vo.ProductCountVo;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by wifi on 2017/7/29.
 * 产品统计
 */
@Controller
@RequestMapping("/productCount")
public class ProductCountController {

    @Autowired
    private ProductCountService productCountService;

    /**
     * wifi
     * 获取产品城市分类 + 跳转到产品统计界面
     * @param model
     * @return
     */
    @RequestMapping("/productCountPage")
    public String productCountPage(ProductCountVo productCountVo,Model model,HttpServletRequest request){
        try {
            // 分页设置
            int pageNum = 1;
            int pageSize = 10;

            //分页信息获取
            if (request.getParameter("pageNumber") != null && !"".equals(request.getParameter("pageNumber"))) {
                pageNum = Integer.parseInt(request.getParameter("pageNumber"));
            }
            if (request.getParameter("pageSize") != null && !"".equals(request.getParameter("pageSize"))) {
                pageSize = Integer.parseInt(request.getParameter("pageSize"));
            }

            // 根据查询数据获得对应的产品统计信息
            PageInfo<ProductCountVo> pageInfo = productCountService.selectProductCountVoMessagePageInfo(pageNum,pageSize,productCountVo);

            // 获取城市信息
            List<City> cityList = productCountService.selectCityMessage();

            model.addAttribute("pageInfo",pageInfo);
            model.addAttribute("productCountVo",productCountVo);
            model.addAttribute("cityList",cityList);
            return "admin/productCount";
        }catch (Exception e){
            e.printStackTrace();
            return "admin/error";
        }
    }

    /**
     * 通过产品id获取买过此产品的用户的信息
     * @param productId
     * @return
     */
    @RequestMapping("/checkUsersMessageByProductId")
    public String checkUsersMessageByProductId(String productId, Model model, HttpServletRequest request){
        try {
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

            List<Sign> signList = productCountService.selectSignsByOrdersId(productId);

            // 将list进行分页处理
            List<Sign> signListPage = new ArrayList<Sign>();
            int currIdx = (pageNum > 1 ? (pageNum -1) * pageSize : 0);
            for (int i = 0; i < pageSize && i < signList.size() - currIdx; i++) {
                Sign sign = signList.get(currIdx + i);
                signListPage.add(sign);
            }

            // 生成分页信息
            PageVo pageVo = new PageVo();
            pageVo.setPageSize(pageSize);
            pageVo.setPageNum(pageNum);
            int totalPage = (signList.size() + pageSize - 1) / pageSize;
            pageVo.setTotalPage(totalPage);

            // 分页信息
            model.addAttribute("pageVo",pageVo);
            // 保留产品ID以便分页跳转查询使用
            model.addAttribute("productId",productId);
            // 分页后的list显示
            model.addAttribute("signListPage",signListPage);
            // 总的list完整数据
            model.addAttribute("signList",signList);
            return "admin/productCount-usersInfo";
        }catch (Exception e){
            e.printStackTrace();
            return "admin/error";
        }
    }

    /**
     * wifi
     * 将报名表人的数据导出Excel表格
     * @param signID
     * @return
     */
    @RequestMapping("/putSignMessageExcel")
    public ResponseEntity<byte[]> putSignMessageExcel(String signID){
        try {
            return productCountService.selectSignBySignId(signID);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
