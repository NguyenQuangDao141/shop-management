<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 7/24/2021
  Time: 5:54 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="f" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Update User</title>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.css" rel="stylesheet"
          type="text/css"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.js"></script>
    <style>
        body {
            background: rgb(154, 154, 147)
        }

        .form-control:focus {
            box-shadow: none;
            border-color: #9A9A93FF;
        }

        .profile-button {
            background: rgb(177, 174, 174);
            box-shadow: none;
            border: none
        }

        .profile-button:hover {
            background: #9A9A93FF;
        }

        .profile-button:focus {
            background: #9A9A93FF;
            box-shadow: none
        }

        .profile-button:active {
            background: #9A9A93FF;
            box-shadow: none
        }

        .back:hover {
            color: #9A9A93FF;
            cursor: pointer
        }

        .labels {
            font-size: 11px
        }

        .add-experience:hover {
            background: #9A9A93FF;
            color: #fff;
            cursor: pointer;
            border: solid 1px #9A9A93FF;
        }
    </style>
</head>
<body>

<form:form action="/user/update/profile.htm" modelAttribute="userUpdate" method="post" id="formDate">
    <div class="container rounded bg-white mt-5 mb-5">
        <div class="row">
            <div class="col-md-5 border-right">
                <div class="d-flex flex-column align-items-center text-center p-3 py-5">
                    <img class="rounded-circle mt-5"
                         src="https://images.unsplash.com/photo-1541647376583-8934aaf3448a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80"
                         width="50%">
                    <span class="font-weight-bold">${userUpdate.username}</span
                    <span class="text-black-50">lethanhdat210520@gmail.com</span>
                    <span> </span></div>
            </div>
            <div class="col-md-7">
                <div class="p-3 py-5">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h4 class="text-right">Profile Settings</h4>
                    </div>
                    <div class="row mt-2">
                        <form:hidden path="id" readonly="readonly" class="form-control"/>
                        <div class="col-md-6"><label class="labels">First Name<h7 style="color: red">(*)</h7></label>
                            <form:input path="firstName" class="form-control"/>
                            <form:errors path="firstName" cssClass="error" cssStyle="color: red"/>
                        </div>
                        <div class="col-md-6"><label class="labels">Last Name<h7 style="color: red">(*)</h7></label>
                                <%--                            <input type="text" class="form-control" value="" placeholder="lastName">--%>
                            <form:input path="lastName" class="form-control"/>
                            <form:errors path="lastName" cssClass="error" cssStyle="color: red"/>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-md-12"><label class="labels">Birthday<h7 style="color: red">(*)</h7></label>
                            <form:input type="text" path="birthday" class="form-control" id="datepicker"  value="${userUpdate.getBirthday(1)}"/>
                            <p id="erroMessage" style="color:red;"> </p>
                            <p style="color:red;">${errorBirthday}</p>
                        </div>
                        <div class="col-md-12"><label class="labels">Sex<h7 style="color: red">(*)</h7></label>
                                <%--                            <form:input path="sex" readonly="readonly" class="form-control" ></form:input>--%>
                            <select class="form-control" name="sex">
                                <option value="true">--select--</option>
                                <option value="true" <c:if test="${userUpdate.sex == true}">selected</c:if>>Nam</option>
                                <option value="false" <c:if test="${userUpdate.sex == false}">selected</c:if>>Nữ
                                </option>
                            </select>
                        </div>
                        <div class="col-md-12"><label class="labels">Address<h7 style="color: red">(*)</h7></label>
                            <form:input path="address" class="form-control"/>
                            <form:errors path="address" cssClass="error" cssStyle="color: red"/>
                        </div>
                        <div class="col-md-12"><label class="labels">Phone<h7 style="color: red">(*)</h7></label>
                            <form:input path="phone" class="form-control"/>
                            <form:errors path="phone" cssClass="error" cssStyle="color: #760b0b"/>
                        </div>
                    </div>
                    <div style="flex-direction: row-reverse;justify-self: center;display: flex ">
                        <div class="mt-5 text-center" style="margin: auto">
                            <a style="width: 200px; background-color: #951111FF  " href="/user/show/profile?id=${userId}"
                               class="btn btn-primary btn-lg active" role="button"
                               aria-pressed="true">Back</a>
                        </div>
                        <div class="mt-5 text-center" style="margin: auto">
                            <button style="width: 200px" class="btn btn-primary btn-lg active" type="button" onclick="submitForm()">Save</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
    </div>

</form:form>
</body>
<script>

    function submitForm(){
        var datepicker = document.getElementById("datepicker").value;
        var year = parseInt(datepicker.slice(datepicker.length-4,datepicker.length));
        var dateNow = new Date();
        if (year > dateNow.getFullYear()) {
          document.getElementById("erroMessage").innerHTML ="Invalid date of birth";
        } else {
            document.getElementById("erroMessage").innerHTML = "";
            document.getElementById("formDate").submit();
        }
    }

    function test(){
        var datepicker = document.getElementById("datepicker").value;
        var year = parseInt(datepicker.slice(datepicker.length-4,datepicker.length));
        var dateNow = new Date();
        if (year > dateNow.getFullYear()) {
            console.log("faild");
        } else {
            console.log("ok");
        }
    };

    $(function () {
        $("#datepicker").datepicker({
            autoclose: true,
            todayHighlight: true,
        });
    });


</script>
</html>
