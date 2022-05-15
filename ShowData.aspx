<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ShowData.aspx.cs" Inherits="Ajax.ShowData" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">
        <h1>Display Details from DB with AJAX</h1>
        <div class="d-flex align-items-center justify-content-between my-3">
            <a href="InsertData.aspx" class="btn btn-primary">Insert Data</a>
            <div class="d-flex">
                <label>Search: </label>
                <input class="search col ml-2" type="text" />
            </div>
        </div>
        <table id="UsersTbl" class="table table-bordered">
            <thead class="bg-dark text-white">
                <tr>
                    <th>ID</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Email ID</th>
                    <th>Operations</th>
                </tr>
            </thead>
            <tbody></tbody>
        </table>
    </div>

    <div id="myModal" class="modal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Modal title</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="id" />
                    <label class="col-md-6">First Name: </label>
                    <input type="text" id="fname" class="col-md-6" />
                    <label class="col-md-6">Last Name: </label>
                    <input type="text" id="lname" class="col-md-6" />
                    <label class="col-md-6">Email: </label>
                    <input type="text" id="email" class="col-md-6" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" id="update">Save changes</button>
                </div>
            </div>
        </div>
    </div>
    
    <script>

        $(document).ready(function () {
            showAll();

            function openModal() {
                $('#myModal').modal('show');
            }

            function closeModal() {
                $('#myModal').modal('hide');
            }

            $('.search').on('keyup', function () {
                var inputkeys = $(this).val();
                let jsonStr = "{'inputkeys':'" + inputkeys + "'}";

                $.ajax({
                    type: "POST",
                    url: "WebService.asmx/searchUser",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: jsonStr,
                    success: function (data) {
                        console.log('resp:::::::::::::>>', data.d);
                        var usersTable = $('#UsersTbl tbody');
                        usersTable.empty();
                        var jsonstr = JSON.parse(data.d);

                        jsonstr.forEach(function (index) {
                            usersTable.append(`<tr><td>${index.id}</td><td>${index.fname}</td><td>${index.lname}</td><td>${index.email}</td>
                                                    <td class='d-flex justify-content-around'>
                                                        <a id='edit' class='text-success' data-id='${index.id}' data-fname="${index.fname}" data-lname="${index.lname}" data-email="${index.email}" style='cursor:pointer'>Edit</a>
                                                        <a id='delete' class='text-danger' data-id='${index.id}' style='cursor:pointer'>Delete</a>
                                                    </td></tr>`);
                        });
                    },

                })
            })

            function showAll() {
                $.ajax({
                    type: "POST",
                    url: "WebService.asmx/ShowUsers",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        var usersTable = $('#UsersTbl tbody');
                        usersTable.empty();
                        var jsonstr = JSON.parse(data.d);

                        jsonstr.forEach(function (index) {
                            usersTable.append(`<tr><td>${index.id}</td>
                                                    <td>${index.fname}</td>
                                                    <td>${index.lname}</td>
                                                    <td >${index.email}</td>
                                                    <td class='d-flex justify-content-around'>
                                                        <a id='edit' class='text-success' data-id='${index.id}' data-fname="${index.fname}" data-lname="${index.lname}" data-email="${index.email}" style='cursor:pointer'>Edit</a>
                                                        <a id='delete' class='text-danger' data-id='${index.id}' style='cursor:pointer'>Delete</a>
                                                    </td>
                                               </tr>`);
                        });
                    },
                    error: function (err) {
                        console.log('err', err)
                    }
                })
            }

            $('#UsersTbl').on('click', '#edit', function () {
                $('#id').val($(this).attr('data-id'));
                $('#fname').val($(this).attr('data-fname'));
                $('#lname').val($(this).attr('data-lname'));
                $('#email').val($(this).attr('data-email'));
                openModal();
            })

            $("#update").on('click', function () {
                let id = $("#id").val();
                let fname = $("#fname").val();
                let lname = $("#lname").val();
                let email = $("#email").val();

                let jsonStr = "{'id':'" + id + "', 'Fname':'" + fname + "', 'Lname':'" + lname + "', 'Email':'" + email + "'}";
                console.log(jsonStr)

                $.ajax({
                    type: "POST",
                    url: "WebService.asmx/UpdateUser",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: jsonStr,
                    success: function (response) {
                        console.log('response:::::::::>>' + response.d)
                        showAll();
                        closeModal();
                        $(".search").val("");
                    },
                })
            })

            $('#UsersTbl').on('click', '#delete', function () {
                let id = $(this).attr('data-id');

                let jsonStr = "{'id':'" + id + "'}";
                console.log(jsonStr);

                $.ajax({
                    type: "POST",
                    url: "WebService.asmx/DeleteUser",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: jsonStr,
                    success: function (response) {
                        console.log('response:::::::::>>' + response.d)
                        showAll();
                        $(".search").val("");
                    },
                })
            })
        })


    </script>

</asp:Content>
