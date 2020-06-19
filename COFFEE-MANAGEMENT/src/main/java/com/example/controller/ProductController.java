package com.example.controller;

import com.example.service.IProductCategoryService;
import com.example.constant.SystemConstant;
import com.example.dto.ProductDTO;
import com.example.service.IProductService;
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

@Controller(value = "productControllerOfAdmin")
public class ProductController {

    @Autowired
    private IProductService productService;
    
    @Autowired
    private IProductCategoryService productCategoryService;

    @RequestMapping(value = "/admin/product/list", method = RequestMethod.GET)
    public ModelAndView getNews(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("product/list");
        List<ProductDTO> products = productService.findAll();
        initMessageResponse(mav, request);
        mav.addObject("products", products);
        mav.addObject("activeProducts", "active");
        mav.addObject("activeProduct", "active open");
        return mav;
    }

    @RequestMapping(value = "/admin/product/edit", method = RequestMethod.GET)
    public ModelAndView editPostPage(@ModelAttribute("model") ProductDTO model,
                                     @RequestParam(value = "id", required = false) Long id, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("product/edit");
        if (id != null) {
            model = productService.findById(id);
        }
        initMessageResponse(mav, request);
        mav.addObject("productcategories", productCategoryService.getProductCategories());
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
