package org.jxiang.crud.service;

import org.jxiang.crud.bean.Employee;
import org.jxiang.crud.bean.EmployeeExample;
import org.jxiang.crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * TODO
 *
 * @author Jxiang
 * @version 1.0
 * @create 2022-06-27 16:09
 */
@Service
public class EmployeeService {
    @Autowired
    EmployeeMapper employeeMapper;

    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDepartment(null);
    }

    public long getNameCount(String name) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(name);
        return employeeMapper.countByExample(example);
    }

    public long getEmailCount(String email) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmailEqualTo(email);
        return employeeMapper.countByExample(example);
    }
}
