package cn.sharetimes.service;

import cn.sharetimes.pojo.User;

/**
 * Created by sharetimes on 2017/11/23.
 */
public interface UserService {
    String getDate();

    String showinfobyid(String uid, int server) throws Exception;

    String getidbynick(String nick, int server) throws Exception;

    String itemManage(String uid, int server, String cmd, int goodsId, int num) throws Exception;
}
