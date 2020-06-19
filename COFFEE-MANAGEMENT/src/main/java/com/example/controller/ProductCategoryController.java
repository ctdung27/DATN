package com.example.controller;

import com.example.constant.SystemConstant;
import com.example.dto.AreaDTO;
import com.example.dto.ProductCategoryDTO;
import com.example.service.IAreaService;
import com.example.service.IProductCategoryService;
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

@Controller(value = "productCategoryControllerOfAdmin")
public class ProductCategoryController {

    @Autowired
    private IProductCategoryService productCategoryService;

    @RequestMapping(value = "/admin/productcategory/list", method = RequestMethod.GET)
    public ModelAndView getNews(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("productcategory/list");
        List<ProductCategoryDTO> productCategories = productCategoryService.findAll();
        initMessageResponse(mav, request);
        mav.addObject("productcategories", productCategories);
        mav.addObject("activeProductCategories", "active");
        mav.addObject("activeProductCategorie", "active open");
        return mav;
    }

    @RequestMapping(value = "/admin/productcategory/edit", method = RequestMethod.GET)
    public ModelAndView editPostPage(@ModelAttribute("model") ProductCategoryDTO model,
                                     @RequestParam(value = "id", required = false) Long id, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("productcategory/edit");
        if (id != null) {
            model = productCategoryService.findById(id);
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
