package com.example.controller;

import com.example.dto.AreaDTO;
import com.example.service.IAreaService;
import com.example.service.IProductCategoryService;
import com.example.service.ITableService;
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
    
    @Autowired
    private ITableService tableService;

    @Autowired
    private IAreaService areaService;

    @Autowired
    private IProductCategoryService productCategoryService;

    @RequestMapping(value = "/admin/order/table/list", method = RequestMethod.GET)
    public ModelAndView getTables(@ModelAttribute("model") AreaDTO model)  {
        ModelAndView mav = new ModelAndView("order/list");
       
        if (model.getCode() != null) {
            mav.addObject("tables", tableService.findByAreaCode(model.getCode()));
        }
        mav.addObject("model", model);
        mav.addObject("areas", areaService.getAreas());
        mav.addObject("productCategories", productCategoryService.findAll());
        mav.addObject("activeOrders", "active");
       ;
        return mav;
    }
    @RequestMapping(value = "/admin/order/list", method = RequestMethod.GET)
    public ModelAndView getOrders(@RequestParam(value = "tableCode", required = false) String tableCode,
            @RequestParam(value = "areaCode", required = false) String areaCode,
            @RequestParam(value = "urlBill", required = false) String urlBill) {
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
        mav.addObject("tables", tableService.findByAreaCode(areaCode));
        AreaDTO areaDTO = new AreaDTO();
        areaDTO.setCode(areaCode);
        mav.addObject("model", areaDTO);
        mav.addObject("areas", areaService.getAreas());
        mav.addObject("productCategories", productCategoryService.findAll());
        if (urlBill != null) {
            mav.addObject("urlBill", urlBill);
        }
        return mav;
    }
}
