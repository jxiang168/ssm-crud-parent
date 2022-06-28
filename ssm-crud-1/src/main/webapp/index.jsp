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
    <script src="static/js/jquery-1.12.4.min.js"></script>
    <!--bootstrap-->
    <script src="static/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>
    <link href="static/bootstrap-3.4.1-dist/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body>

<!-- emp add Modal -->
<div class="modal fade" id="emp_add_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">添加员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input name="empName" type="text" class="form-control" id="empName_add_input"
                                   placeholder="empName">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input name="email" type="email" class="form-control" id="email_add_input"
                                   placeholder="example@jxiang.org">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="dep_add_input" class="col-sm-2 control-label">depName</label>
                        <div id="dep_add_input" class="col-sm-4">
                            <select id="dep_add_select" name="dId" class="form-control">
<%--                                <option value="1">部门1</option>--%>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="emp_save_btn" type="button" class="btn btn-primary">保存</button>
            </div>
        </div>
    </div>
</div>

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
            <button id="emp_add_btn" class="btn btn-primary">新增</button>
            <button class="btn btn-danger">删除</button>
        </div>
    </div>
    <%--  data  --%>
    <div class="row">
        <div class="col-md-12">
            <table id="emps_table" class="table table-hover">
                <thead>
                <tr>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
    </div>
    <%--  paging  --%>
    <div class="row">
        <div id="page_info_area" class="col-md-6"></div>
        <div id="page_nav_area" class="col-md-6"></div>
    </div>
</div>
<script>

    var totalPageNum;

    function to_page(pn) {
        $.ajax({
            url: "${APP_PATH}/emps",
            data: "pn=" + pn,
            type: "get",
            success: function (result) {
                totalPageNum = result.extend.pageInfo.pages;
                // console.log(result);
                //    1. emps table
                build_emps_table(result);
                //    2. paging
                build_page_info(result);
                build_page_nav(result);
            }
        })
    }

    <%-- bind onload --%>
    $(function () {
        // default visit first page
        to_page(1);

        // bind add emp button
        $("#emp_add_btn").click(function () {
            // get dep list
            getDepts();
            // pop modal
            $("#emp_add_modal").modal({
                backdrop: "static"
            })
        });

        // bind employee save button
        $("#emp_save_btn").click(function(){
            var emp = $("#emp_add_modal form").serialize();
            $.ajax({
                url:"${APP_PATH}/emp",
                type:"POST",
                data:emp,
                success:function(result) {
                    alert(result.msg);
                }
            });
            $("#emp_add_modal").modal("hide");
            to_page(totalPageNum+1);
        })
    });

    function getDepts() {
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            success: function (result) {
                // console.log(result);
                $.each(result.extend.depts, function () {
                    // <option value="1">部门1</option>
                    $("#dep_add_select").append(
                        $("<option></option>").attr("value", this.depId).append(this.depName)
                    );
                });
            }
        })
    }

    function build_emps_table(result) {
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            // alert(item.empName);
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender == "M" ? "男" : "女");
            var emailTd = $("<td></td>").append(item.email);
            var depNameTd = $("<td></td>").append(item.department.depName);
            // var editBtn = $('<button class="btn btn-primary btn-sm"><span class="glyphicon glyphicon-pencil"/>编辑</button>');
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                .append("编辑");
            var deleteBtn = $("<button></button>").addClass("btn btn-danger btn-sm")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                .append("编辑");
            var actionTd = $("<td></td>").append(editBtn).append(" ").append(deleteBtn);
            $("<tr></tr>").append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(depNameTd)
                .append(actionTd)
                .appendTo("#emps_table tbody");
        })
    }

    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("当前 " + result.extend.pageInfo.pageNum
            + " 页，总 " + result.extend.pageInfo.pages
            + "页，共 " + result.extend.pageInfo.total + " 条记录。");
    }

    function build_page_nav(result) {
        $("#page_nav_area").empty();
        // console.log(result);
        var pageInfo = result.extend.pageInfo;

        var ul = $("<ul></ul>").addClass("pagination");

        if (pageInfo.pageNum == 1) {
            var first = $("<li></li>").addClass("disabled").append($("<a></a>").append("首页"));
        } else {
            var first = $("<li></li>").append($("<a></a>").attr("href", "javascript:").append("首页")).click(function () {
                to_page(1)
            });
        }
        ul.append(first);

        if (pageInfo.hasPreviousPage) {
            var prev = $("<li></li>").append(
                $("<a></a>").attr({"aria-label": "Previous", "href": "javascript:"}).append(
                    $("<span></span>").attr("aria-hidden", "true").append("&laquo;")
                )
            ).click(function () {
                to_page(pageInfo.pageNum - 1)
            });
        } else {
            var prev = $("<li></li>").addClass("disabled").append(
                $("<a></a>").attr("aria-label", "Previous").append(
                    $("<span></span>").attr("aria-hidden", "true").append("&laquo;")
                )
            );
        }
        ul.append(prev);

        $.each(pageInfo.navigatepageNums, function (index, item) {
            // console.log("index="+index,",item="+item);
            if (item == pageInfo.pageNum) {
                ul.append(
                    $("<li></li>").addClass("active").append(
                        $("<a></a>").append(item)
                    )
                );
            } else {
                ul.append(
                    $("<li></li>").append(
                        $("<a></a>").attr("href", "javascript:").append(item)
                    ).click(function () {
                        to_page(item)
                    })
                );
            }
        });

        if (pageInfo.hasNextPage) {
            var next = $("<li></li>").append(
                $("<a></a>").attr({"aria-label": "Next", "href": "javascript:"}).append(
                    $("<span></span>").attr("aria-hidden", "true").append("&raquo;")
                )
            ).click(function () {
                to_page(pageInfo.pageNum + 1)
            });
        } else {
            var next = $("<li></li>").addClass("disabled").append(
                $("<a></a>").attr("aria-label", "Next").append(
                    $("<span></span>").attr("aria-hidden", "true").append("&raquo;")
                )
            );
        }
        ul.append(next);

        if (pageInfo.pageNum == pageInfo.pages) {
            var last = $("<li></li>").addClass("disabled").append($("<a></a>").append("末页"));
        } else {
            var last = $("<li></li>").append($("<a></a>").attr("href", "javascript:").append("末页")).click(function () {
                to_page(pageInfo.pages)
            });
        }
        ul.append(last);

        $("#page_nav_area").append($("<nav></nav>").attr("aria-label", "Page navigation").append(ul));
    }


</script>
</body>
</html>