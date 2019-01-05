package cn.edu.bnuz.seawas.service.admin;

import cn.edu.bnuz.seawas.dao.CustomMapper;
import cn.edu.bnuz.seawas.entity.Custom;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * 定制表service
 * Created by tomviss on 2017/8/16.
 */
@Service(value = "customService")
public class CustomService {
    @Autowired
    private CustomMapper customMapper;

    /**
     * 条件搜索
     * @param custom
     * @return
     */
    public List<Custom> selectCustomSelective(Custom custom){
        return customMapper.selectCustomSelective(custom);
    }

    public PageInfo<Custom> selectCustomSelectivePage(Integer pageNum, Integer pageSize,Custom custom){
        int count = 0;
        pageNum = pageNum == null ? 1 : pageNum;
        pageSize = pageSize == null ? 10 : pageSize;
        PageHelper.startPage(pageNum,pageSize);
        PageInfo<Custom> customPageInfo = new PageInfo<Custom>(customMapper.selectCustomSelective(custom));
      return customPageInfo;
    }

    public Custom get(String id){
        Custom custom = new Custom();
        custom.setId(id);
        return customMapper.get(custom);
    }

    public int update(Custom custom){
        return  customMapper.update(custom);
    }

    public int insert(Custom custom){
        return customMapper.insertSelective(custom);
    }

    /*批量删除定制*/
    public int deleteCustoms(String idString){
        String[] Str = idString.split(",");
        int result = 1;
        List<Custom> customs = new ArrayList<Custom>();
        for (String s : Str){
            Custom custom = new Custom();
            custom.setId(s);
            customs.add(custom);
        }
        result = customMapper.deleteCustoms(customs);
        return result;
    }

}
