package com.example.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.example.dto.OrderDTO;
import com.example.dto.ReportDTO;
import com.example.dto.UserDTO;
import com.example.service.IOrderService;
import com.example.service.IUserService;

@Controller(value = "homeControllerOfAdmin")
public class HomeController {

	 @Autowired
	    private IUserService userService;
	 
	  @Autowired
	    private IOrderService orderService;
	
	 
	@RequestMapping(value = "/admin/home", method = RequestMethod.GET)
	public ModelAndView homePage() {
		ModelAndView mav = new ModelAndView("home");
		List<UserDTO> users = userService.findAll();
		ReportDTO report = orderService.report("20-06-2020", "21-06-2020");
        mav.addObject("reports", report.getOrders());
        mav.addObject("totalPrice", report.getTotalPrice());
		mav.addObject("users", users);
		mav.addObject("activeHome", "active");
		
       
		return mav;
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView loginPage() {
		ModelAndView mav = new ModelAndView("login");
		return mav;
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null) {
			new SecurityContextLogoutHandler().logout(request, response, auth);
		}
		return new ModelAndView("redirect:/login");
	}
	
	@RequestMapping(value = "/accessDenied", method = RequestMethod.GET)
	public ModelAndView accessDenied() {
		return new ModelAndView("redirect:/login?accessDenied");
	}
}
