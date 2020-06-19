package com.example.controller;

import com.example.service.IAreaService;
import com.example.constant.SystemConstant;
import com.example.dto.ProductDTO;
import com.example.dto.TableDTO;
import com.example.service.IProductService;
import com.example.service.ITableService;
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

@Controller(value = "tableControllerOfAdmin")
public class TableController {

    @Autowired
    private ITableService tableService;
    
    @Autowired
    private IAreaService areaService;

    @RequestMapping(value = "/admin/table/list", method = RequestMethod.GET)
    public ModelAndView getNews(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("table/list");
        List<TableDTO> tables = tableService.findAll();
        initMessageResponse(mav, request);
        mav.addObject("tables", tables);
        mav.addObject("activeTables", "active");
        mav.addObject("activeTable", "active open");
        return mav;
    }

    @RequestMapping(value = "/admin/table/edit", method = RequestMethod.GET)  
    public ModelAndView editPostPage(@ModelAttribute("model") TableDTO model,
                                     @RequestParam(value = "id", required = false) Long id, HttpServletRequest request) {   /// sư dụng cho thêm mới và cập nhât (cập nhật thì có id, thêm mới thì không)
        ModelAndView mav = new ModelAndView("table/edit");
        if (id != null) {
            model = tableService.findById(id);
        }
        initMessageResponse(mav, request);
        mav.addObject("areas", areaService.getAreas());
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
