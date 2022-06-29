package org.jxiang.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.jxiang.crud.bean.Employee;
import org.jxiang.crud.bean.Msg;
import org.jxiang.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.HashMap;
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

    @RequestMapping(path = "/emp/{id}",method = RequestMethod.POST)
    @ResponseBody
    public Msg updateEmp(@PathVariable("id")Integer empId, @Valid Employee employee, BindingResult result) {
        if(result.hasErrors()) {
            HashMap<String, Object> map = new HashMap<>();
            for (FieldError fieldError : result.getFieldErrors()) {
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        } else {
            employee.setEmpId(empId);
            int ret = employeeService.updateEmployee(employee);
            if(ret!=0) {
                return Msg.success();
            } else {
                return Msg.fail();
            }
        }
    }

    @RequestMapping(path = "/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer empId) {
        Employee employee = employeeService.getEmpById(empId);
        return Msg.success().add("empData",employee);
    }

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
    public Msg saveEmp(@Valid Employee employee, BindingResult result) {
        if(result.hasErrors()) {
            HashMap<String, Object> map = new HashMap<>();
            for (FieldError fieldError : result.getFieldErrors()) {
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        } else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
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
