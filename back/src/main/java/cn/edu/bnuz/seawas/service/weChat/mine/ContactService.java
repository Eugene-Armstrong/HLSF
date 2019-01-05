package cn.edu.bnuz.seawas.service.weChat.mine;

import cn.edu.bnuz.seawas.dao.ContactMapper;
import cn.edu.bnuz.seawas.entity.Contact;
import cn.edu.bnuz.seawas.utils.UUIDUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 常用人的相关操作
 * Created by Zrj on 2017/9/12.
 */

@Service
public class ContactService {
    @Autowired
    ContactMapper contactMapper;

    /**
     * 获取用户常用人列表
     * @param userId 用户id
     * @return
     */
    public List<Contact> selectContactListByUser(String userId){
        return contactMapper.selectContactListByUser(userId);
    }

    /**
     * 添加常用人
     * @param record 添加的记录
     * @return
     */
    public int insertSelective(Contact record){
        if (!checkIsContactExist(record)){
            record.setId(UUIDUtil.createUUID());
            return contactMapper.insertSelective(record);
        }
        else{
            return -2;
        }
    }

    public int deleteByPrimaryKey(String id){
        return contactMapper.deleteByPrimaryKey(id);
    }

    /**
     * 常用人是否存在
     * @param contact 常用人信息
     * @return
     */
    public boolean checkIsContactExist(Contact contact){
        if (contactMapper.checkIsContactExist(contact) != 0){
            return true;
        }
        return false;
    }
}
