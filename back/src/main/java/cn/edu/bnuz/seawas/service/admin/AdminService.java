package cn.edu.bnuz.seawas.service.admin;

import cn.edu.bnuz.seawas.dao.AdminMapper;
import cn.edu.bnuz.seawas.entity.Admin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by PVer on 2017/7/28.
 */
@Service("AdminService")
public class AdminService {

    @Autowired
    private AdminMapper adminMapper;

    /**
     * wifi
     * 获得普通管理员信息
     */
    public List<Admin> selectNormalAdminMessage(){
        return adminMapper.selectNormalAdminMessage();
    }

    /**
     * wifi
     * 添加普通管理员
     */
    public void insert(Admin admin){
        adminMapper.insert(admin);
    }

    /**
     * wifi
     * 修改管理员信息（超级管理员、普通管理员）
     */
    public int updateByPrimaryKeySelective(Admin admin){
        int result = adminMapper.updateByPrimaryKeySelective(admin);
        return result;
    }

    /**
     * wifi
     * 删除管理员（假删除）
     */
    @Transactional
    public int deleteAdminsByPrimaryKey(String adminId){
        String[] Str = adminId.split(",");
        int result = 1;
        List<Admin> admins = new ArrayList<Admin>();
        for (String s : Str){
            Admin admin = new Admin();
            admin.setId(s);
            admins.add(admin);
        }
        result = adminMapper.deleteAdminsByPrimaryKey(admins);
        return result;
    }

    /**
     * tom
     * 通过登录名和密码获取用户
     * @param admin
     * @return
     */
    public Admin checkUser(Admin admin) {
        Admin admin1 = adminMapper.selectAdminByLoginNameAndPassword(admin);
        return admin1;
    }

    /**
     * wifi
     * 通过用户id获取用户信息
     * @param id
     * @return
     */
    public Admin selectUsersByPrimaryKey(String id){
        return adminMapper.selectUsersByPrimaryKey(id);
    }
}
