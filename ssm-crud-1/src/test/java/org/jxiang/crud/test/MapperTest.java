package org.jxiang.crud.test;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.jxiang.crud.bean.Employee;
import org.jxiang.crud.dao.DepartmentMapper;
import org.jxiang.crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * TODO
 *
 * @author Jxiang
 * @version 1.0
 * @create 2022-06-27 12:31
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;

    @Test
    public void testCRUD() {
        // 1. insert a few department
//        departmentMapper.insertSelective(new Department(null, "开发部"));
//        departmentMapper.insertSelective(new Department(null, "测试部"));
        // 2. insert a fwe employees
//        employeeMapper.insertSelective(new Employee(null,"Jerry","M","Jerry@jxiang.org",1));
        // 3. insert batch employees
//        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
//        for (int i = 0; i < 1000; i++) {
//            String uid = UUID.randomUUID().toString().substring(0, 5) + String.valueOf(i);
//            mapper.insertSelective(new Employee(null, uid, "M", uid + "@jxiang.org", 1));
//        }
        // fix empty department issue
//        Employee employee = employeeMapper.selectByPrimaryKeyWithDepartment(1);
//        System.out.println(employee);
//        System.out.println(employee.getDepartment());
        Employee employee = new Employee(2,null,"M","946f10@jxiang.org",2);
        int i = employeeMapper.updateByPrimaryKeySelective(employee);
        System.out.println(i);
        System.out.println(employeeMapper.selectByPrimaryKey(2));
    }
}
