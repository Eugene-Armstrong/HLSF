package cn.edu.bnuz.seawas.service.admin;

import cn.edu.bnuz.seawas.dao.TravelNoteMapper;
import cn.edu.bnuz.seawas.entity.TravelNote;
import cn.edu.bnuz.seawas.vo.ActivityDetailsVo;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by tomviss on 2017/8/3.
 */
@Service
public class TravelNoteService {
    @Autowired
    TravelNoteMapper travelNoteMapper;

   public List<TravelNote> selectAllNoteSelective(TravelNote travelNote){
        return  travelNoteMapper.selectAllNoteSelective(travelNote);
    }

    public PageInfo<TravelNote> selectAllNoteSelectivePage(Integer pageNum, Integer pageSize, TravelNote travelNote){
        int count = 0;
        pageNum = pageNum == null ? 1 : pageNum;
        pageSize = pageSize == null ? 10 : pageSize;
        PageHelper.startPage(pageNum,pageSize);
        PageInfo<TravelNote> travelNotePageInfo = new PageInfo<TravelNote>(travelNoteMapper.selectAllNoteSelective(travelNote));

        return travelNotePageInfo;

    }

   public List<TravelNote> selectAll(){
        return  travelNoteMapper.selectAll();
    }

    public  int delete(String idString){
        String[] Str = idString.split(",");
        int result = 1;
        List<TravelNote> travelNotes = new ArrayList<TravelNote>();
        for (String s : Str){
            TravelNote travelNote = new TravelNote();
            travelNote.setId(s);
            travelNotes.add(travelNote);
        }
        return  travelNoteMapper.delete(travelNotes);
    }

    /*添加否决理由*/
    public  int sendReason(String rejectId, String managerReplyContent,String adminId){
        TravelNote travelNote = new TravelNote();
        travelNote.setId(rejectId);
        List<TravelNote> travelNotes = travelNoteMapper.selectAllNoteSelective(travelNote);
        travelNote = travelNotes.get(0);
        travelNote.setRemark(managerReplyContent);
        travelNote.setState("2");//2表示已审核但未通过
        travelNote.setAdminId(adminId);
        return  travelNoteMapper.updateByPrimaryKey(travelNote);
    }

    /**
     * 审核通过
     * @param noteId
     * @param adminId
     * @return
     */
    public  int auditPass(String noteId,String adminId){
        TravelNote travelNote = new TravelNote();
        travelNote.setId(noteId);
        List<TravelNote> travelNotes = travelNoteMapper.selectAllNoteSelective(travelNote);
        travelNote = travelNotes.get(0);
        travelNote.setAdminId(adminId);
        travelNote.setState("1");
        return travelNoteMapper.updateByPrimaryKey(travelNote);
    }
    /*通过id找到游记*/
    public TravelNote selectByPriamryKey(String noteId){
        TravelNote travelNote = new TravelNote();
        travelNote.setId(noteId);
        List<TravelNote> travelNotes = travelNoteMapper.selectAllNoteSelective(travelNote);
        return travelNotes.get(0);
    }

    /**
     * 通过id拿到游记内容
     */
    public TravelNote selectContent(String id){
        return travelNoteMapper.selectContent(id);
    }
}
