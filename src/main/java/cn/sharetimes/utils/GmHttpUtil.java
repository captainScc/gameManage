package cn.sharetimes.utils;

import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import java.net.URI;
import java.util.Map;

public class GmHttpUtil {

    public static String gmHttp(int serverId, String cmd, String parameter) throws Exception{
// 创建Httpclient对象
        CloseableHttpClient httpclient = HttpClients.createDefault();

        String path = null;
        String gmName = null;
        String gmPwd = null;
        if(serverId == 1001) {
            path = "http://103.240.16.6:21001/Netease";
            gmName = "netease";
            gmPwd = "123456";
        }
        // 定义请求的参数
        URI uri = new URIBuilder(path)
                .setParameter("username", gmName)
                .setParameter("password", gmPwd)
                .setParameter("cmd", cmd)
                .setParameter("parameter",parameter)
                .build();

        // 创建http GET请求
        HttpGet httpGet = new HttpGet(uri);

        CloseableHttpResponse response = null;
        String content = null;
        try {
            // 执行请求
            response = httpclient.execute(httpGet);
            // 判断返回状态是否为200
            if (response.getStatusLine().getStatusCode() == 200) {
                content = EntityUtils.toString(response.getEntity(), "UTF-8");
            }
        } finally {
            if (response != null) {
                response.close();
            }
            httpclient.close();
        }

        return content;



    }
}
