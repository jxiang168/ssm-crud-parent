package org.jxiang.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.jxiang.crud.bean.Employee;
import org.jxiang.crud.bean.Msg;
import org.jxiang.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    @RequestMapping("/emp.checkname")
    @ResponseBody
    public Msg checkEmp(String empName) {
        long nameCount = employeeService.getNameCount(empName);
        if (nameCount==0) {
            return Msg.success();
        } else {
            return Msg.fail();
        }
    }

    @RequestMapping(path = "/emp", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(Employee employee) {
        employeeService.saveEmp(employee);
        return Msg.success();
    }

    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsJasn(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
        // set page
        PageHelper.startPage(pn, 5);
        // query
        List<Employee> emps = employeeService.getAll();
        // retrive page info
        PageInfo<Employee> page = new PageInfo<>(emps, 5);
        // add to frontend
        model.addAttribute("pageInfo", page);

        Msg msg = Msg.success();
        msg.add("pageInfo", page);
        return msg;
    }


}
