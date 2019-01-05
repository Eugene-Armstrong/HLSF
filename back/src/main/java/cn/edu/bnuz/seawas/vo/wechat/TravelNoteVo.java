package cn.edu.bnuz.seawas.vo.wechat;

import cn.edu.bnuz.seawas.entity.TravelNote;

/**
 * Created by Zrj on 2017/11/28.
 */
public class TravelNoteVo extends TravelNote{
    private String mediaIds;

    public String getMediaIds() {
        return mediaIds;
    }

    public void setMediaIds(String mediaIds) {
        this.mediaIds = mediaIds;
    }
}
