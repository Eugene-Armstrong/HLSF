package cn.edu.bnuz.seawas.dao;

import cn.edu.bnuz.seawas.entity.Contact;

import java.util.List;

public interface ContactMapper {
    int deleteByPrimaryKey(String id);

    int insert(Contact record);

    int insertSelective(Contact record);

    Contact selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Contact record);

    int updateByPrimaryKey(Contact record);

    List<Contact> selectContactListByUser(String userId);

    int checkIsContactExist(Contact contact);
}