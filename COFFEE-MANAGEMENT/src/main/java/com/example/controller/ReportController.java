package com.example.controller;

import com.example.constant.SystemConstant;
import com.example.dto.OrderDTO;
import com.example.dto.ReportDTO;
import com.example.service.IOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class ReportController {

    @Autowired
    private IOrderService orderService;

    @RequestMapping(value = "/admin/report/list", method = RequestMethod.GET)
    public ModelAndView getReport(@ModelAttribute("model") ReportDTO model) {
        ModelAndView mav = new ModelAndView("report/list");
        ReportDTO report = orderService.report(model.getFromDate(), model.getToDate());
        mav.addObject("reports", report.getOrders());
        mav.addObject("totalPrice", report.getTotalPrice());
        mav.addObject("model", model);
        mav.addObject("activeReport", "active");
        return mav;
    }
    @RequestMapping(value = "/admin/report/timekeeping", method = RequestMethod.GET)
    public ModelAndView getKeeping() {
        ModelAndView mav = new ModelAndView("report/timekeeping");
        mav.addObject("activeTimekeeping", "active");
        return mav;
    }
}
