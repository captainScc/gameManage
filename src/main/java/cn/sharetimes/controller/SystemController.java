package cn.sharetimes.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class SystemController {
    @RequestMapping(value = "/")
    public String test() {
        return "first";
    }

}
