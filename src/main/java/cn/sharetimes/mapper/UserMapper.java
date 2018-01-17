package cn.sharetimes.mapper;

import cn.sharetimes.pojo.User;
import com.github.abel533.mapper.Mapper;

/**
 * Created by sharetimes on 2017/11/23.
 */
public interface UserMapper extends Mapper<User>{
    String getDate();

    int updateUser(User u);

    void updateUserByTelephone(User user);
}
