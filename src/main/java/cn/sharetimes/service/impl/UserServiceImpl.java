package cn.sharetimes.service.impl;

import cn.sharetimes.mapper.UserMapper;
import cn.sharetimes.pojo.User;
import cn.sharetimes.redis.RedisUtils;
import cn.sharetimes.service.UserService;
import cn.sharetimes.utils.EncryptUtils;
import cn.sharetimes.utils.GmHttpUtil;
import cn.sharetimes.utils.JsonUtils;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.net.URI;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by sharetimes on 2017/11/23.
 */
@Service
@Transactional
public class UserServiceImpl implements UserService{

    @Autowired
    private UserMapper userMapper;

    @Override
    public String getDate() {
        String date = userMapper.getDate();
        return date;
    }

    @Override
    public String showinfobyid(String uid, int server) throws Exception {

        String user = GmHttpUtil.gmHttp(server, "showinfobyid", uid);
        return user;
    }

    @Override
    public String getidbynick(String nick, int server) throws Exception{
        String uidStr = GmHttpUtil.gmHttp(server, "getidbynick", nick);
        Map<String, Object> map = new HashMap<>();
        Map result = JsonUtils.readValue(uidStr, map.getClass());
        Map<String, String> m = (Map<String, String>)result.get("result");
        String user = GmHttpUtil.gmHttp(server, "showinfobyid", m.get("uid"));
        return user;
    }

    @Override
    public String itemManage(String uid, int server, String cmd, int goodsId, int num) throws Exception {
        String parameter;
        if(cmd == "additem" || cmd == "delitem") {
            parameter = uid + "," + goodsId + "," + num;
        } else {
            parameter = uid + "," + num;
        }

        String result = GmHttpUtil.gmHttp(server, cmd, parameter);

        return result;
    }


}
