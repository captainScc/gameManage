package cn.sharetimes.controller;

import cn.sharetimes.pojo.Item;
import cn.sharetimes.pojo.User;
import cn.sharetimes.service.UserService;
import cn.sharetimes.utils.EncryptUtils;
import cn.sharetimes.utils.GmHttpUtil;
import cn.sharetimes.utils.JsonUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.sql.Timestamp;
import java.util.*;

/**
 * Created by sharetimes on 2017/11/23.
 */
@Controller
@RequestMapping(value = "user")
public class UserController {

    @Autowired
    private UserService userService;

    /**
     * 跳转查询玩家基本信息页面
     * @return
     */
   @RequestMapping(value = "queryuser")
    public String queryuser() {
        return "jsp/user/queryuser";
    }

    /**
     * 跳转查询玩家背包信息页面
     * @return
     */
   @RequestMapping(value = "queryItem")
    public String queryItem() {
        return "jsp/user/queryItem";
    }

   /**
     * 跳转查询玩家权限管理页面
     * @return
     */
   @RequestMapping(value = "auth")
    public String auth() {
        return "jsp/user/auth";
    }

    /**
     * 查询玩家冻结状态以及禁言状态
     */
    @RequestMapping(value = "check")
    public ModelAndView check(String uid, Integer serverId){
        ModelAndView modelAndView = new ModelAndView();
        if(uid == null || serverId ==null  || uid == ""){
            modelAndView.setViewName("common/error");
            modelAndView.addObject("message", "缺失参数");
            return modelAndView;
        }

        String lock_cmd = "check";
        String speak_cmd = "checkfayan";
        String parameter = uid;

        String lockStatus = null;
        String speakStatus = null;
        try {
            lockStatus = GmHttpUtil.gmHttp(serverId, lock_cmd, parameter);
            speakStatus = GmHttpUtil.gmHttp(serverId, speak_cmd, parameter);
        } catch (Exception e) {
            e.printStackTrace();
        }

        Map<String, Object> map = new HashMap<>();
        String split = lockStatus.split("status")[0];
        lockStatus = split.substring(23, split.length()-2);

        Map speak_result = JsonUtils.readValue(speakStatus, map.getClass());
        Map<String, String> m = (Map<String, String>)speak_result.get("result");
        String speak_message = "";
        for(Map.Entry<String, String> entry : m.entrySet()) {
            if(entry.getKey().equals("status")) {
                continue;
            }
            speak_message = speak_message + entry.getKey() + "-" + entry.getValue() + "  ";
        }

        modelAndView = new ModelAndView("jsp/user/auth");
        modelAndView.addObject("lockStatus", lockStatus);
        modelAndView.addObject("speakStatus", speak_message);
        modelAndView.addObject("uid",uid);
        modelAndView.addObject("serverId",serverId);

        return modelAndView;
    }

    /**
     * 禁言
     */
    @RequestMapping(value = "jinyan")
    public String jinyan(Integer serverId, String cmd, String uid, String utilTime, Model model) throws Exception{
        if(serverId == null || uid == null || uid == ""){
            model.addAttribute("message", "请先查询再修改");
            return "common/error";
        }
        if(utilTime == null || utilTime == ""){
            model.addAttribute("message", "未填写日期");
            return "common/error";
        }
        String replace = utilTime.replace(" ", ",");
        String parameter = uid + "," + replace;
        String result = GmHttpUtil.gmHttp(serverId, cmd, parameter);
        model.addAttribute("message",result);
        model.addAttribute("uid",uid);
        model.addAttribute("serverId",serverId);
        return "jsp/user/auth_success";
    }

    /**
     * 解禁言 解冻
     */
    @RequestMapping(value = "authManage")
    public String authManage(Integer serverId, String cmd, String uid, Model model) throws Exception{
        if(serverId == null || uid == null  || uid == ""){
            model.addAttribute("message", "请先查询再修改");
            return "common/error";
        }

        String parameter = uid;
        String result = GmHttpUtil.gmHttp(serverId, cmd, parameter);
        model.addAttribute("message",result);
        model.addAttribute("uid",uid);
        model.addAttribute("serverId",serverId);
        return "jsp/user/auth_success";
    }

    /**
     * 冻结
     */
    @RequestMapping(value = "lock")
    public String lock(Integer serverId, String cmd, String uid, String lockReason,String lockTime, Model model) throws Exception{
        if(serverId == null || uid == null || uid == ""){
            model.addAttribute("message", "请先查询再修改");
            return "common/error";
        }
        if(lockTime == null || lockTime == ""){
            model.addAttribute("message", "请填写冻结时间，0为永久冻结");
            return "common/error";
        }
        if(lockReason == null || lockReason == "") {
            lockReason = "账号异常";
        }

        String parameter = uid + "," + lockTime + "," + lockReason;
        String result = GmHttpUtil.gmHttp(serverId, cmd, parameter);
        model.addAttribute("message",result);
        model.addAttribute("uid",uid);
        model.addAttribute("serverId",serverId);
        return "jsp/user/auth_success";
    }

    /**
     * 玩家添加、减少 钻石，金币，体力，战力
     * @param serverId
     * @param cmd
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "manage")
    public String manage(Integer serverId, String cmd, String uid, Integer num, Model model) throws Exception{
        if(serverId == null || uid == null  || uid == ""){
            model.addAttribute("message", "请先查询再修改");
            return "common/error";
        }
        if(num == null){
            model.addAttribute("message", "未填写数量");
            return "common/error";
        }
        String parameter = uid + "," + num;
        String result = GmHttpUtil.gmHttp(serverId, cmd, parameter);
        model.addAttribute("message",result);
        model.addAttribute("uid",uid);
        model.addAttribute("serverId",serverId);
        return "jsp/user/user_success";
    }

      /**
     * 玩家添加、减少 物品
     * @param serverId
     * @param cmd
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "itemManage")
    public String itemManage(Integer serverId, String cmd, String uid, Integer num, Integer goodsId, Model model) throws Exception{
        if(serverId == null || uid == null || goodsId == null  || uid == ""){
            model.addAttribute("message", "请先查询再修改");
            return "common/error";
        }
        if(num == null ){
            model.addAttribute("message", "未填写数量");
            return "common/error";
        }
        String parameter = uid + "," + goodsId + ","+ num;
        String result = GmHttpUtil.gmHttp(serverId, cmd, parameter);
        model.addAttribute("message",result);
        model.addAttribute("uid",uid);
        model.addAttribute("serverId",serverId);
        model.addAttribute("goodsId",goodsId);
        return "jsp/user/item_success";
    }

      /**
     * 昵称重命名
     */
    @RequestMapping(value = "rename")
    public String rename(Integer serverId, String cmd, String uid, String newName, Model model) throws Exception{
        if(serverId == null || uid == null  || uid == ""){
            model.addAttribute("message", "请先查询再修改");
            return "common/error";
        }
        if(newName == null || newName == ""){
            model.addAttribute("message", "未填写新昵称");
            return "common/error";
        }
        String parameter = uid + "," + newName;
        String result = GmHttpUtil.gmHttp(serverId, cmd, parameter);
        model.addAttribute("message",result);
        model.addAttribute("uid",uid);
        model.addAttribute("serverId",serverId);
        return "jsp/user/user_success";
    }

    /**
     * 根据UID查询玩家信息
     * 查询ID基本信息   参数 玩家的uid
     * http://106.2.66.50:24001/Netease?username=netease&password=bbb&cmd=showinfobyid&parameter=11002000019
     */
    @RequestMapping(value = "showinfobyid",produces = {"application/json;charset=UTF-8"})
    public ModelAndView showinfobyid(String uid, Integer serverId) {
        ModelAndView modelAndView = new ModelAndView();
        if(uid == null || serverId ==null  || uid == ""){
            modelAndView.setViewName("common/error");
            modelAndView.addObject("message", "缺失参数");
            return modelAndView;
        }

        String cmd = "showinfobyid";
        String parameter = uid;
        String userInfoStr = null;
        try {
            userInfoStr = GmHttpUtil.gmHttp(serverId, cmd, parameter);
        } catch (Exception e) {
            e.printStackTrace();
        }

        Map<String, Object> map = new HashMap<>();
        Map result = JsonUtils.readValue(userInfoStr, map.getClass());
        Map m = (Map<String, String>)result.get("result");

        modelAndView.setViewName("jsp/user/queryuser");
        modelAndView.addAllObjects(m);
        return modelAndView;
    }

    /**
     * 根据uid查询玩家背包
     */
    @RequestMapping(value = "listbagitem",produces = {"application/json;charset=UTF-8"})
    public ModelAndView listbagitem(String uid, String goodsId, Integer serverId) {
        ModelAndView modelAndView = new ModelAndView();
        if(uid == null || goodsId == null || serverId ==null  || uid == "" || goodsId == ""){
            modelAndView.setViewName("common/error");
            modelAndView.addObject("message", "缺失参数");
            return modelAndView;
        }

        String cmd = "listbagitem";
        String parameter = uid;
        String goodsInfoStr = null;
        try {
            goodsInfoStr = GmHttpUtil.gmHttp(serverId, cmd, parameter);
        } catch (Exception e) {
            e.printStackTrace();
        }

        Map<String, Object> map = new HashMap<>();
        Map result = JsonUtils.readValue(goodsInfoStr, map.getClass());
        Map m = (Map<String, String>)result.get("result");

        String itemInfo = (String)m.get("itemInfo");
        List<String> list = new ArrayList();
        List<Map<String,Object>> itemList = JsonUtils.readValue(itemInfo, list.getClass());

        modelAndView.setViewName("jsp/user/queryItem");
        for(Map<String, Object> itemMap : itemList) {
            String id = (String)itemMap.get("goodsId");
            if(goodsId.equals(id)){
                modelAndView.addObject("itemId",goodsId);
                modelAndView.addObject("goodsCount",(String)itemMap.get("goodsCount"));
                break;
            } else {
                modelAndView.addObject("itemId","无");
                modelAndView.addObject("goodsCount","无");
            }

        }

        modelAndView.addObject(itemList);
        modelAndView.addObject("uid",uid);
        modelAndView.addObject("goodsId",goodsId);
        modelAndView.addObject("serverId",serverId);
        return modelAndView;
    }

   /**
     * 根据昵称查询用户信息
     *
     * 通过昵称查询ID  参数 玩家的昵称
     * http://106.2.66.50:24001/Netease?username=netease&password=bbb&cmd=getidbynick&parameter=埃迪刘易斯
     * 根据ID查询玩家信息
     */
    @RequestMapping(value = "getidbynick",produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public ModelAndView getidbynick(String nickname,Integer serverId) {
        ModelAndView modelAndView = new ModelAndView();
        if(nickname == null || serverId ==null || nickname == ""){
            modelAndView.setViewName("common/error");
            modelAndView.addObject("message", "缺失参数");
            return modelAndView;
        }

        String cmd = "getidbynick";
        String parameter = nickname;
        String uidStr = null;
        try {
            uidStr = GmHttpUtil.gmHttp(serverId, cmd, parameter);
        } catch (Exception e) {
            e.printStackTrace();
        }
        Map<String, Object> map = new HashMap<>();
        Map result = JsonUtils.readValue(uidStr, map.getClass());
        Map<String, String> m = (Map<String, String>)result.get("result");
        String uid = m.get("uid");

        modelAndView = showinfobyid(uid, serverId);
        return modelAndView;
    }
}
