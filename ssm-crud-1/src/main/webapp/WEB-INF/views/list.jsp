<%@ page contentType="text/html; UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
"
<!DOCTYPE html>
<html>
<head>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <%--    <base href="/ssm_crud_1/">--%>
    <base href="${APP_PATH}/">
    <title>员工列表</title>
    <!--jquery-->
    <script src="static/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>
    <!--bootstrap-->
    <script src="static/js/jquery-1.12.4.min.js"></script>
    <link href="static/bootstrap-3.4.1-dist/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body>
<!-- page layout -->
<div class="container">
    <%--  title  --%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <%--  button  --%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary">新增</button>
            <button class="btn btn-danger">删除</button>
        </div>
    </div>
    <%--  data  --%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                <tr>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                <c:forEach items="${pageInfo.list}" var="emp">
                    <tr>
                        <td>${emp.empId}</td>
                        <td>${emp.empName}</td>
                        <td>${emp.gender=="M"?"男":"女"}</td>
                        <td>${emp.email}</td>
                        <td>${emp.department.depName}</td>
                        <td>
                            <button class="btn btn-primary btn-sm">
                                <span class="glyphicon glyphicon-pencil"/>编辑
                            </button>
                            <button class="btn btn-danger btn-sm">
                                <span class="glyphicon glyphicon-trash"/>删除
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
    <%--  paging  --%>
    <div class="row">
        <div class="col-md-6">
            当前第 ${pageInfo.pageNum} 页，总 ${pageInfo.pages} 页，供 ${pageInfo.total} 条记录。
        </div>
        <div class="col-md-6">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <c:if test="${pageInfo.pageNum==1}">
                        <li class="disabled"><a>首页</a></li>
                    </c:if>
                    <c:if test="${pageInfo.pageNum!=1}">
                        <li><a href="?pn=${1}">首页</a></li>
                    </c:if>
                    <c:if test="${pageInfo.hasPreviousPage}">
                        <li>
                            <a href="?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${!pageInfo.hasPreviousPage}">
                        <li class="disabled">
                            <a aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:forEach items="${pageInfo.navigatepageNums}" var="page_num">
                        <c:if test="${pageInfo.pageNum==page_num}">
                            <li class="active"><a href="?pn=${page_num}">${page_num}</a></li>
                        </c:if>
                        <c:if test="${pageInfo.pageNum!=page_num}">
                            <li><a href="?pn=${page_num}">${page_num}</a></li>
                        </c:if>
                    </c:forEach>
                    <c:if test="${pageInfo.hasNextPage}">
                        <li>
                            <a href="?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${!pageInfo.hasNextPage}">
                        <li class="disabled">
                            <a aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${pageInfo.pageNum==pageInfo.pages}">
                        <li class="disabled"><a>末页</a></li>
                    </c:if>
                    <c:if test="${pageInfo.pageNum!=pageInfo.pages}">
                        <li><a href="?pn=${pageInfo.pages}">末页</a></li>
                    </c:if>
                </ul>
            </nav>
        </div>
    </div>
</div>
</body>
</html>