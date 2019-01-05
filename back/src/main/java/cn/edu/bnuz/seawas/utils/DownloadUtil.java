package cn.edu.bnuz.seawas.utils;

import com.foxinmy.weixin4j.util.StringUtil;
import com.sun.istack.internal.Nullable;
import org.apache.commons.io.FileUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import java.io.File;

/**
 * 下载工具类
 * Created by sjk on 2017-09-25.
 */
public class DownloadUtil {

    /**
     * 下载文件
     * @param path 路径（包括文件名称）
     * @param fileName 新的文件名，若空，则默认提取路径中的文件名
     * @return ResponseEntity字节数组
     * @throws Exception 异常信息
     */
    public static ResponseEntity<byte[]> downloadFile(String path, String fileName) throws Exception {
        File file = new File(path);
        HttpHeaders headers = new HttpHeaders();
        String name;
        if (fileName == null || fileName.equals("")) {
            name = new String(path.substring(path.lastIndexOf("/")).getBytes("UTF-8"), "iso-8859-1");
        } else {
            name = new String(fileName.getBytes("UTF-8"), "iso-8859-1");
        }
        headers.setContentDispositionFormData("attachment", name);
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers ,HttpStatus.CREATED);
    }
}
