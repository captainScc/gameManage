package cn.sharetimes.pojo;

import javax.persistence.Table;
import java.sql.Timestamp;

/**
 * Created by sharetimes on 2017/11/23.
 */
@Table(name = "user")
public class User {
    private String uid;
    private String exp;
    private String level;
    private String status;
    private String account_id;
    private String nickname;
    private String strength;
    private String diamond;
    private String power;
    private String societyName;
    private String gold;
    private String serverId;

    public String getUid() {
        return uid;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public String getExp() {
        return exp;
    }

    public void setExp(String exp) {
        this.exp = exp;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public String getAccount_id() {
        return account_id;
    }

    public void setAccount_id(String account_id) {
        this.account_id = account_id;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getStrength() {
        return strength;
    }

    public void setStrength(String strength) {
        this.strength = strength;
    }

    public String getDiamond() {
        return diamond;
    }

    public void setDiamond(String diamond) {
        this.diamond = diamond;
    }

    public String getPower() {
        return power;
    }

    public void setPower(String power) {
        this.power = power;
    }

    public String getSocietyName() {
        return societyName;
    }

    public void setSocietyName(String societyName) {
        this.societyName = societyName;
    }

    public String getGold() {
        return gold;
    }

    public void setGold(String gold) {
        this.gold = gold;
    }

    public String getServerId() {
        return serverId;
    }

    public void setServerId(String serverId) {
        this.serverId = serverId;
    }
}
