package com.example.controller;

import com.example.dto.OrderDTO;
import com.example.service.IOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class OrderController {

    @Autowired
    private IOrderService orderService;

    @RequestMapping(value = "/admin/order/table/list", method = RequestMethod.GET)
    public ModelAndView getTables() {
        ModelAndView mav = new ModelAndView("order/list");
        mav.addObject("tables", orderService.findTable());
        return mav;
    }

    @RequestMapping(value = "/admin/order/list", method = RequestMethod.GET)
    public ModelAndView getOrders(@RequestParam(value = "tableCode", required = false) String tableCode) {
        ModelAndView mav = new ModelAndView("order/list");
        if (tableCode != null) {
            List<OrderDTO> orders = orderService.findByTableCode(tableCode);
            mav.addObject("tableCode", tableCode);
            mav.addObject("orders", orders);
            Integer totalPrice = 0;
            for (OrderDTO item: orders) {
                if (item.getTotalPrice() != null) {
                    totalPrice += item.getTotalPrice();
                }
            }
            if (totalPrice != 0) {
                mav.addObject("totalPrice", totalPrice);
            }
        }
        mav.addObject("tables", orderService.findTable());
        return mav;
    }
}
