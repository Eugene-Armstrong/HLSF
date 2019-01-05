package cn.edu.bnuz.seawas.JUnit;

import cn.edu.bnuz.seawas.dao.DictMapper;
import cn.edu.bnuz.seawas.entity.Dict;
import cn.edu.bnuz.seawas.utils.UUIDUtil;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


/**
 * 数据字典录入
 * Created by sjk on 2017-08-14.
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:spring/applicationContext-*.xml"})
public class DictTest {

    @Autowired
    private DictMapper dictMapper;

    @Test
    public void insert() throws Exception {

        Dict dict = new Dict();

        dict.setId(UUIDUtil.createUUID());

        dict.setType("payment");

        dict.setLabel("银联");

        dict.setValue("3");

        dict.setDescription("支付方式");

        dictMapper.insert(dict);
    }
}
