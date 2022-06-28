package org.jxiang.crud.test;

import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.jxiang.crud.bean.Employee;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;



/**
 * TODO
 *
 * @author Jxiang
 * @version 1.0
 * @create 2022-06-27 16:24
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:applicationContext.xml","file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml"})
@WebAppConfiguration
public class MvcTest {

    @Autowired
    WebApplicationContext context;
    MockMvc mockMvc;

    @Before
    public void initMocMvc() {
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {
        // simulate get request and return
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "5"))
                .andReturn();

        // read pageInfo
        MockHttpServletRequest request = result.getRequest();
        PageInfo pi = (PageInfo)request.getAttribute("pageInfo");
        System.out.println("当前页码: "+pi.getPageNum());
        System.out.println("总页码: "+pi.getPages());
        System.out.println("总记录数: "+pi.getTotal());
        System.out.println("连续显示页码: ");
        int[] nums = pi.getNavigatepageNums();
        for (int i : nums) {
            System.out.println(" " + i);
        }

        // get emps
        List<Employee> list = pi.getList();
        for (Employee employee : list) {
            System.out.println("ID:"+employee.getEmpId()+"==>Name:"+employee.getEmpName());
        }

    }
}
