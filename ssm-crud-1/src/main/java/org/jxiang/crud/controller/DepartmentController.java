package org.jxiang.crud.controller;

import org.jxiang.crud.bean.Department;
import org.jxiang.crud.bean.Msg;
import org.jxiang.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * TODO
 *
 * @author Jxiang
 * @version 1.0
 * @create 2022-06-27 16:04
 */
@Controller
public class DepartmentController {

    @Autowired
    DepartmentService departmentService;

    @RequestMapping("/depts")
    @ResponseBody
    public Msg getEmpsJasn() {
        // query
        List<Department> depts = departmentService.getAll();
        Msg msg = Msg.success();
        msg.add("depts",depts);
        return msg;
    }
}
