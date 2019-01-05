package cn.edu.bnuz.seawas.dao;

import cn.edu.bnuz.seawas.entity.Admin;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AdminMapper {

    /**
     * wifi
     * 获取普通管理员信息
     */
    List<Admin> selectNormalAdminMessage();


    /**
     * wifi
     * 添加管理员（普通管理员、超级管理员）
     */
    int insert(Admin record);

    /**
     * wifi
     * 修改管理员信息
     * @return 成功与否
     */
    int updateByPrimaryKeySelective(Admin record);

    /**
     * wifi
     * 批量删除管理员（假删除）
     * @return 成功与否
     */
    int deleteAdminsByPrimaryKey(@Param("admins") List<Admin> admins);

    /**
     * wifi
     * 通过用户id获取用户信息
     * @param id
     * @return
     */
    Admin selectUsersByPrimaryKey(String id);

    int deleteByPrimaryKey(String id);

    int insertSelective(Admin record);

    int updateByPrimaryKey(Admin record);

    /**
     * 通过用户名和密码获得用户（登陆）
     * tom
     * @param admin
     * @return
     */
    Admin selectAdminByLoginNameAndPassword(Admin admin);
}