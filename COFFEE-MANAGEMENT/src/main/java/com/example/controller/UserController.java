package com.example.controller;

import com.example.constant.SystemConstant;
import com.example.dto.UserDTO;
import com.example.service.IRoleService;
import com.example.service.IUserService;
import com.example.util.MessageResponseUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Controller(value = "userControllerOfAdmin")
public class UserController {

    @Autowired
    private IUserService userService;

    @Autowired
    private IRoleService roleService;

    @RequestMapping(value = "/admin/user/list", method = RequestMethod.GET)
    public ModelAndView getNews(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("user/list");
        List<UserDTO> users = userService.findAll();
        initMessageResponse(mav, request);
        mav.addObject("users", users);
        return mav;
    }

    @RequestMapping(value = "/admin/user/edit", method = RequestMethod.GET)
    public ModelAndView editPostPage(@ModelAttribute("model") UserDTO model,
                                     @RequestParam(value = "id", required = false) Long id, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("user/edit");
        if (id != null) {
            model = userService.findById(id);
        }
        initMessageResponse(mav, request);
        mav.addObject("roles", roleService.getRoles());
        mav.addObject("model", model);
        return mav;
    }

    @RequestMapping(value = "/admin/user/profile", method = RequestMethod.GET)
    public ModelAndView updateProfile(@ModelAttribute("model") UserDTO model,
                                     @RequestParam(value = "id", required = false) Long id, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("user/profile");
        if (id != null) {
            model = userService.findById(id);
        }
        initMessageResponse(mav, request);
        mav.addObject("model", model);
        return mav;
    }

    private void initMessageResponse(ModelAndView mav, HttpServletRequest request) {
        String message = request.getParameter("message");
        if (message != null && StringUtils.isNotEmpty(message)) {
            Map<String, String> messageMap = MessageResponseUtils.getMessage(message);
            mav.addObject(SystemConstant.ALERT, messageMap.get(SystemConstant.ALERT));
            mav.addObject(SystemConstant.MESSAGE_RESPONSE, messageMap.get(SystemConstant.MESSAGE_RESPONSE));
        }
    }
}
