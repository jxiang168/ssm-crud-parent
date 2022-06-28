package org.jxiang.crud.service;

import org.jxiang.crud.bean.Department;
import org.jxiang.crud.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * TODO
 *
 * @author Jxiang
 * @version 1.0
 * @create 2022-06-28 17:37
 */
@Service
public class DepartmentService {
    @Autowired
    DepartmentMapper departmentMapper;

    public List<Department> getAll() {
        return departmentMapper.selectByExample(null);
    }
}
