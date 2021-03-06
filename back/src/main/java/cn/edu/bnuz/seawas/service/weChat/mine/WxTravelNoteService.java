package cn.edu.bnuz.seawas.service.weChat.mine;

import cn.edu.bnuz.seawas.dao.AppreciationMapper;
import cn.edu.bnuz.seawas.dao.TravelNoteMapper;
import cn.edu.bnuz.seawas.entity.Appreciation;
import cn.edu.bnuz.seawas.entity.TravelNote;
import cn.edu.bnuz.seawas.entity.User;
import cn.edu.bnuz.seawas.utils.Condition;
import cn.edu.bnuz.seawas.utils.DateUtils;
import cn.edu.bnuz.seawas.utils.PropertiesUtil;
import cn.edu.bnuz.seawas.utils.UUIDUtil;
import cn.edu.bnuz.seawas.vo.wechat.PicUrlVo;
import cn.edu.bnuz.seawas.vo.wechat.TravelNoteAndUser;
import cn.edu.bnuz.seawas.vo.wechat.TravelNoteVo;
import com.foxinmy.weixin4j.model.media.MediaDownloadResult;
import com.foxinmy.weixin4j.mp.WeixinProxy;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by Zrj on 2017/11/23.
 */
@Service
public class WxTravelNoteService {
    @Autowired
    private TravelNoteMapper travelNoteMapper;

    @Autowired
    private AppreciationMapper appreciationMapper;

    @Autowired
    private WeixinProxy weixinProxy;

    /**
     * 微信端根据id查询游记
     * 更改游记
     */
    public TravelNote selectByPrimaryKey(String id){
        return travelNoteMapper.selectByPrimaryKey(id);
    }

    /**
     * 微信端根据id查询游记
     * 查看游记
     */
    public TravelNoteAndUser selectNoteAndUser(String id){
        TravelNote travelNote = new TravelNote();
        travelNote.setId(id);
        travelNote.setState("1");

        return travelNoteMapper.WxgetNote(travelNote);
    }

    /**
     * 社区模块中的游记显示
     */
    public PageInfo<TravelNoteAndUser> getNoteAtSociety(Integer pageNum, Integer pageSize){
        //设置查询条件
        TravelNote travelNote = new TravelNote();
        travelNote.setState("1");

        pageNum = pageNum == null ? 1 : pageNum;
        pageSize = pageSize == null ? 1 : pageSize;
        PageHelper.startPage(pageNum, pageSize);
        List<TravelNoteAndUser>  travelNoteAndUserList = travelNoteMapper.WxgetAllNoteSelective(travelNote);

        return new PageInfo<TravelNoteAndUser>(travelNoteAndUserList);
    }

    /**
     * 个人页面的草稿游记
     */
    public PageInfo<TravelNoteAndUser> getDraftAtMine(User user,Integer pageNum, Integer pageSize){
        TravelNote travelNote = new TravelNote();
        travelNote.setState("0");
        travelNote.setUserId(user.getId());

        pageNum = pageNum == null ? 1 : pageNum;
        pageSize = pageSize == null ? 1 : pageSize;
        PageHelper.startPage(pageNum, pageSize);
        return new PageInfo<TravelNoteAndUser>(travelNoteMapper.WxgetAllNoteSelective(travelNote));
    }

    /**
     * 个人页面的已审核游记
     */
    public PageInfo<TravelNoteAndUser> getNoteAtMine(User user,Integer pageNum, Integer pageSize){
        TravelNote travelNote = new TravelNote();
        travelNote.setState("1");
        travelNote.setUserId(user.getId());

        pageNum = pageNum == null ? 1 : pageNum;
        pageSize = pageSize == null ? 1 : pageSize;
        PageHelper.startPage(pageNum, pageSize);

        List<TravelNoteAndUser> travelNoteAndUserList = travelNoteMapper.WxgetAllNoteSelective(travelNote);
        return new PageInfo<TravelNoteAndUser>(travelNoteAndUserList);
    }

    /**
     * 用户点赞
     * @param id  游记id
     * @param userId
     * @return 返回0表示失败，1表示成功
     */
    public int insertAppreciation(String id, String userId){
        Appreciation appreciation = new Appreciation();
        appreciation.setId(UUIDUtil.createUUID());
        appreciation.setTravelnoteId(id);
        appreciation.setUserId(userId);
        try {
            appreciation.setAppreciatdTime(DateUtils.getCurrDate());
            appreciationMapper.insertSelective(appreciation);
            travelNoteMapper.updateAppreciation(id);  //游记总赞数+1
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
        return 1;
    }

    /**
     * 判断该用户有没有给指定的游记点过赞
     * @param id 游记id
     * @param userId
     * @return 返回0表示没有记录，1表示有记录
     */
    public int isAppreciated(String id, String userId){
        Appreciation appreciation = new Appreciation();
        appreciation.setTravelnoteId(id);
        appreciation.setUserId(userId);
        int count = appreciationMapper.selectByUserIdAndTravelnoteId(appreciation);
        return count == 0 ? 0 : 1;
    }

    /**
     * 游记浏览次数+1
     */
    public void updateBrowseTimes(String id){
        travelNoteMapper.updateBrowseTimes(id);
    }

    /**
     * 新增游记
     */
    public Condition addJourney(TravelNoteVo travelNoteVo){

        //数据校验
        if (StringUtils.isBlank(travelNoteVo.getMediaIds())) {
            return new Condition(Condition.ERROR_CODE, "请选择图片");
        }

        MediaDownloadResult downloadResult;
        FileOutputStream outputStream = null;
        BufferedOutputStream bufferedOutputStream = null;

        try {
            //从微信服务器下载图片
            downloadResult = weixinProxy.downloadMedia(travelNoteVo.getMediaIds(), false);

            //重命名上传的图片
            String newPicName = UUIDUtil.createUUID() + downloadResult.getFileName().substring(downloadResult.getFileName().lastIndexOf("."));

            //上传图片
            outputStream = new FileOutputStream(PropertiesUtil.getProperty("TravelNote.realPath") + newPicName);
            bufferedOutputStream = new BufferedOutputStream(outputStream);
            bufferedOutputStream.write(downloadResult.getContent());

            //保存进数据库
            travelNoteVo.setId(UUIDUtil.createUUID());
            travelNoteVo.setCreateTime(new Date());
            travelNoteVo.setPicUrl(newPicName);
            travelNoteMapper.insertSelective(travelNoteVo);

        } catch (Exception e) {
            e.printStackTrace();
            return new Condition(Condition.ERROR_CODE, "系统繁忙");

        } finally {

            if (bufferedOutputStream != null) {
                try {
                    bufferedOutputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (outputStream != null) {
                try {
                    outputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        if (travelNoteVo.getState().equals("3")){
            return new Condition(Condition.SUCCESS_CODE, "草稿保存成功");
        }else {
            return new Condition(Condition.SUCCESS_CODE, "发布成功，等待审核");
        }

    }

    /**
     * 修改草稿
     */
    public Condition editJourney(TravelNoteVo travelNoteVo){

        //数据校验
        if (StringUtils.isBlank(travelNoteVo.getMediaIds())) {
        }else{
            MediaDownloadResult downloadResult;
            FileOutputStream outputStream = null;
            BufferedOutputStream bufferedOutputStream = null;
            try {
                //从微信服务器下载图片
                downloadResult = weixinProxy.downloadMedia(travelNoteVo.getMediaIds(), false);

                //重命名上传的图片
                String newPicName = UUIDUtil.createUUID() + downloadResult.getFileName().substring(downloadResult.getFileName().lastIndexOf("."));

                //上传图片
                outputStream = new FileOutputStream(PropertiesUtil.getProperty("TravelNote.realPath") + newPicName);
                bufferedOutputStream = new BufferedOutputStream(outputStream);
                bufferedOutputStream.write(downloadResult.getContent());

                //删除老图片
                File file = new File(PropertiesUtil.getProperty("TravelNote.realPath") + travelNoteVo.getPicUrl());
                if (file.exists() && file.isFile()) {
                    file.delete();
                }

                //设置新的封面地址
                travelNoteVo.setPicUrl(newPicName);
            } catch (Exception e) {
                e.printStackTrace();
                return new Condition(Condition.ERROR_CODE, "系统繁忙");

            } finally {

                if (bufferedOutputStream != null) {
                    try {
                        bufferedOutputStream.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
                if (outputStream != null) {
                    try {
                        outputStream.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        }

        //保存进数据库
        travelNoteVo.setCreateTime(new Date());
        travelNoteMapper.updateByPrimaryKeySelective(travelNoteVo);

        if (travelNoteVo.getState().equals("3")){
            return new Condition(Condition.SUCCESS_CODE, "草稿保存成功");
        }else {
            return new Condition(Condition.SUCCESS_CODE, "发布成功，等待审核");
        }

    }

    /**
     * 草稿状态调整
     */
    public Condition changDraft(TravelNote travelNote){
        if (travelNote.getState().equals("3")){
            try{
                travelNote.setState("0");
                travelNoteMapper.updateByPrimaryKeySelective(travelNote);
                return new Condition(Condition.SUCCESS_CODE,"发布成功，耐心等待审核");
            }catch (Exception e){
                e.printStackTrace();
                return new Condition(Condition.ERROR_CODE,"失败，请稍后再试");
            }
        }else{
            return new Condition(Condition.SUCCESS_CODE,"失败，请稍后再试");
        }
    }

    /**
     * 草稿删除
     */
    public Condition deleteDraft(TravelNote travelNote){
       try{
            travelNoteMapper.deleteByPrimaryKey(travelNote.getId());
            return new Condition(Condition.SUCCESS_CODE,"删除成功");
        }catch (Exception e){
           e.printStackTrace();
            return new Condition(Condition.ERROR_CODE,"失败，请稍后再试");
        }
    }

    /**
     * 微信端插入图片后批量下载
     * @return
     */
    public List<PicUrlVo> insertPicBtn(String[] mediaIds){
        List<PicUrlVo> picUrlVoList= new ArrayList<PicUrlVo>();
        PicUrlVo picUrlVo = null;
        //数据校验
        if (mediaIds == null || mediaIds.length == 0) {
            picUrlVo = new PicUrlVo();
            picUrlVo.setCondition(new Condition(Condition.NOTFOUND_CODE, "请选择图片"));
            picUrlVoList.add(picUrlVo);
            return picUrlVoList;
        }

        MediaDownloadResult downloadResult;

        try {
            for (String mediaId : mediaIds) {
                FileOutputStream fileOutputStream = null;
                BufferedOutputStream bufferedOutputStream = null;
                try {
                    //从微信服务器下载图片
                    downloadResult = weixinProxy.downloadMedia(mediaId, false);
                    //重命名上传的图片
                    String newPicName = UUIDUtil.createUUID() + "_" + System.currentTimeMillis() + downloadResult.getFileName().substring(downloadResult.getFileName().lastIndexOf("."));
                    //上传图片
                    fileOutputStream = new FileOutputStream(PropertiesUtil.getProperty("TravelNote.realPath") + newPicName);
                    bufferedOutputStream = new BufferedOutputStream(fileOutputStream);
                    bufferedOutputStream.write(downloadResult.getContent());

                    picUrlVo = new PicUrlVo();
                    picUrlVo.setPicUrl(newPicName);
                    picUrlVo.setCondition(new Condition(Condition.SUCCESS_CODE, "上传成功"));
                    //保存进数据库
                    picUrlVoList.add(picUrlVo);

                } catch (Exception e) {

                    e.printStackTrace();
                    picUrlVo = new PicUrlVo();
                    picUrlVo.setCondition(new Condition(Condition.ERROR_CODE, "上传失败"));
                    picUrlVoList.add(picUrlVo);
                    return picUrlVoList;

                } finally {

                    if (bufferedOutputStream != null) {
                        bufferedOutputStream.close();
                    }
                    if (fileOutputStream != null) {
                        fileOutputStream.close();
                    }
                }
            }

            return picUrlVoList;

        } catch (Exception e) {
            e.printStackTrace();
            picUrlVo = new PicUrlVo();
            picUrlVo.setCondition(new Condition(Condition.ERROR_CODE, "上传失败"));
            picUrlVoList.add(picUrlVo);
            return picUrlVoList;
        }
    }
}
