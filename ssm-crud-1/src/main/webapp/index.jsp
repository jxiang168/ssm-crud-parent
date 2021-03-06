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
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input name="email" type="email" class="form-control" id="email_add_input"
                                   placeholder="example@jxiang.org">
                            <span class="help-block"></span>
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

<!-- emp update Modal -->
<div class="modal fade" id="emp_update_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">修改员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <input type="hidden" id="empid_update_hidden" name="empId"/>
                    </div>
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static" name="empName"></p>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input name="email" type="email" class="form-control" id="email_update_input"
                                   placeholder="example@jxiang.org">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="dep_add_input" class="col-sm-2 control-label">depName</label>
                        <div id="dep_update_input" class="col-sm-4">
                            <select id="dep_update_select" name="dId" class="form-control">
                                <%--                                <option value="1">部门1</option>--%>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="emp_update_btn" type="button" class="btn btn-primary">更新</button>
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

    <%-- bind onload --%>
    $(function () {
        // default visit first page
        to_page(1);

        // bind add emp button
        $("#emp_add_btn").click(function () {
            // reset form
            reset_form("#emp_add_modal form");
            // $("#emp_add_modal form").attr("valid_status","");
            // get dep list
            getDepts("#dep_add_select");
            // pop modal
            $("#emp_add_modal").modal({
                backdrop: "static"
            });
        });

        // bind employee save button
        $("#emp_save_btn").click(save_button_click);

        // listen on click event on edit button
        $(document).on("click", ".edit_btn", edit_btn_click);

        // bind employee update btn
        $("#emp_update_btn").click(update_button_click);

    });

    function update_button_click() {
        var emp = $("#emp_update_modal form").serialize();
        // console.log(emp);
        $.ajax({
            url: "${APP_PATH}/emp/"+$("#empid_update_hidden").val(),
            type: "POST",
            data: emp,
            success: function (result) {
                alert(result.msg);
                if (result.code == "100") {
                    $("#emp_update_modal").modal("hide");
                    to_page(currentPageNum);
                } else {
                    // if (result.extend.errorFields.empName) {
                    //     set_validation_status("#empName_update_input", "error", result.extend.errorFields.empName);
                    // }
                    if (result.extend.errorFields.email) {
                        set_validation_status("#email_update_input", "error", result.extend.errorFields.email);
                    }
                }
            }
        });
    }

    function edit_btn_click() {
        // 1. reset edit form
        reset_form("#emp_update_modal form");
        // 2. query department data
        getDepts("#dep_update_select");
        // 3. get and fill emp data
        var empId = $(this).attr("empId");
        $.ajax({
            url:"${APP_PATH}/emp/"+ empId,
            type:"GET",
            success:function(result){
                var emp = result.extend.empData;
                // console.log(emp);
                $("#empid_update_hidden").val(emp.empId);
                console.log($("#empid_update_hidden").val());
                $("#empName_update_static").text(emp.empName);
                $("#email_update_input").val(emp.email);
                $("#emp_update_modal input[name='gender']").val([emp.gender]);
                $("#dep_update_select").val(emp.dId);
            }
        })
        // 4. pop up modal
        $("#emp_update_modal").modal({
            backdrop: "static"
        });
    }

    var totalPageNum;
    var currentPageNum;

    function set_validation_status(ele, status, msg) {
        $(ele).parent().removeClass("has-success has-error");
        if (status == "success") {
            $(ele).parent().addClass("has-success")
        } else {
            $(ele).parent().addClass("has-error")
        }
        $(ele).next("span").text(msg);
    }

    function validate_add_form() {
        var result = "";

        // 1. empName
        var empName = $("#empName_add_input").val();
        var regName = /^[a-z0-9_-]{6,16}$/;
        if (!regName.test(empName)) {
            result = result + "用户名只能是6-16位英文或数字。" + "\n";
            set_validation_status("#empName_add_input", "error", "用户名只能是6-16位英文或数字。");
        } else {
            set_validation_status("#empName_add_input", "success", "");
        }

        // 2. email
        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            result = result + "邮箱格式不正确。" + "\n";
            set_validation_status("#email_add_input", "error", "邮箱格式不正确。");
        } else {
            set_validation_status("#email_add_input", "success", "");
        }

        // final
        if (result != "") {
            // alert(result);
            return false;
        }
        return true;
    }

    function valid_add_form_bg() {
        // 1. empName not dupe
        var empName = $("#empName_add_input").val();
        $.ajax({
            url: "${APP_PATH}/emp.checkname",
            type: "GET",
            data: "empName=" + empName,
            async: false,
            success: function (result) {
                if (result.code == "100") {
                    set_validation_status("#empName_add_input", "success", "");
                    $("#emp_add_modal form").attr("validated", "true");
                } else {
                    set_validation_status("#empName_add_input", "error", "用户名已存在，不能重复。");
                    $("#emp_add_modal form").attr("validated", "false");
                }
            }
        })
        if ($("#emp_add_modal form").attr("validated") == "true") {
            return true;
        } else {
            return false;
        }
    }

    function to_page(pn) {
        $.ajax({
            url: "${APP_PATH}/emps",
            data: "pn=" + pn,
            type: "get",
            success: function (result) {
                totalPageNum = result.extend.pageInfo.pages;
                currentPageNum = result.extend.pageInfo.pageNum;
                // console.log(result);
                //    1. emps table
                build_emps_table(result);
                //    2. paging
                build_page_info(result);
                build_page_nav(result);
            }
        })
    }


    function save_button_click() {
        if (validate_add_form() == true) {
            if (valid_add_form_bg()) {
                var emp = $("#emp_add_modal form").serialize();
                $.ajax({
                    url: "${APP_PATH}/emp",
                    type: "POST",
                    data: emp,
                    success: function (result) {
                        alert(result.msg);
                        if (result.code == "100") {
                            $("#emp_add_modal").modal("hide");
                            to_page(totalPageNum + 1);
                        } else {
                            if (result.extend.errorFields.empName) {
                                set_validation_status("#empName_add_input", "error", result.extend.errorFields.empName);
                            }
                            if (result.extend.errorFields.email) {
                                set_validation_status("#email_add_input", "error", result.extend.errorFields.email);
                            }
                        }
                    }
                });
            }
        }
    }

    function reset_form(ele) {
        $(ele)[0].reset();
        $(ele).attr("validated", "false");
        $(ele).find("*").removeClass("has-success has-error");
        $(ele).find(".help-block").text("");
    }

    function getDepts(ele) {
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            success: function (result) {
                // console.log(result);
                $(ele).empty();
                $.each(result.extend.depts, function () {
                    // <option value="1">部门1</option>
                    $(ele).append(
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
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn").attr("empId",item.empId)
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                .append("编辑");
            var deleteBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn").attr("empId",item.empId)
                .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                .append("删除");
            var actionTd = $("<td></td>").append(editBtn).append(" ").append(deleteBtn);
            $("<tr></tr>").append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(depNameTd)
                .append(actionTd)
                .appendTo("#emps_table tbody");
        });
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