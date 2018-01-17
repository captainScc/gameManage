package cn.sharetimes.redis.impl;

import cn.sharetimes.redis.RedisUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

import java.util.Map;

/**
 * Created by sharetimes on 2017/4/23.
 */
@Service
public class RedisPool implements RedisUtils {
    @Autowired
    private JedisPool jedisPool;

    @Override
    public void set(String key, String value) {
        Jedis jedis = this.jedisPool.getResource();

        jedis.set(key, value);
        jedis.close();
    }

    @Override
    public String get(String key) {
        Jedis jedis = this.jedisPool.getResource();

        String result = jedis.get(key);
        jedis.close();

        return result;
    }

    @Override
    public void del(String key) {
        Jedis jedis = this.jedisPool.getResource();

        jedis.del(key);
        jedis.close();

    }

    @Override
    public void expire(String key, Integer seconds) {
        Jedis jedis = this.jedisPool.getResource();

        jedis.expire(key, seconds);
        jedis.close();

    }

    @Override
    public void set(String key, String value, Integer seconds) {
        Jedis jedis = this.jedisPool.getResource();

        jedis.set(key, value);
        jedis.expire(key, seconds);
        jedis.close();

    }

    @Override
    public Long incr(String key) {
        Jedis jedis = this.jedisPool.getResource();

        Long count = jedis.incr(key);
        jedis.close();

        return count;
    }

    @Override
    public void hmset(String key, Map<String, String> map, Integer seconds) {
        Jedis jedis = this.jedisPool.getResource();

        jedis.hmset(key, map);
        jedis.expire(key, seconds);
        jedis.close();
    }

    @Override
    public Map<String, String> hgetAll(String key) {
        Jedis jedis = this.jedisPool.getResource();

        Map<String, String> result = jedis.hgetAll(key);
        jedis.close();

        return result;
    }
}
