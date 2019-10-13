<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="VFDS.SignUp" 

    %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta charset="utf-8" />
    <script src='https://www.google.com/recaptcha/api.js' type="text/javascript"></script>      
    
    
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.10.2.min.js"></script>
    
    <script src="../Scripts/bootstrap.min.js"></script>
    

    <script type="text/javascript">
           $(document).ready(function () {

               $('#txfEmail').keyup(function () {
                var userName = $(this).val();

                if (userName.length >= 3) {
                    $.ajax({
                        url: 'UserService.asmx/UserNameExists',
                        method: 'post',
                        
                        data: { userName: userName },
                        dataType: 'json',
                        success: function (data) {
                            var divElement = $('#divOutput');
                            if (data.UserNameInUse) {
                                divElement.text(userName + ' Invalid/already in use');
                                divElement.css('color', 'red');
                            }
                            else {
                                divElement.text(userName + ' available')
                                divElement.css('color', 'green');
                            }
                        },
                        error: function (err) {
                            alert(err);
                        }
                    });
                }
            });
        });
    </script>
</head>
<body style="padding-top:20px">
<form id="form1" runat="server">



    
    

    <div class="col-md-10 col-md-offset-1">
        <div class="well">
            <!--This table contains the fields that we want to capture to sign up a new user-->
            <table class="table table-bordered">
                <thead>
                    <tr class="success">
                        <th colspan="2">
                            New User Sign Up
                            <a href="Login.aspx" class="btn btn-success pull-right">
                                Login
                            </a>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>First Name</td>                        
                        <td>
                            <asp:TextBox ID="txfNameFirst" runat="server" placeholder="First Name" required="true" ></asp:TextBox>
                            <asp:RequiredFieldValidator ID="vreqNameFirst" runat="server" ErrorMessage="First Name is required" ControlToValidate="txfNameFirst" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>                        
                    </tr>
                    <tr>
                        <td>Last Name</td>                        
                        <td>
                            <asp:TextBox ID="txfNameLast" runat="server" placeholder="Last Name" required="true" ></asp:TextBox>
                            <asp:RequiredFieldValidator ID="vreqNameLast" runat="server" ErrorMessage="Last Name is required" ControlToValidate="txfNameLast" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>                        
                    </tr>
                    <tr>
                        <td>Email</td>                        
                        <td>
                            <asp:TextBox ID="txfEmail" runat="server" placeholder="Email"  TextMode="Email" required="true" ></asp:TextBox>

                            <asp:RequiredFieldValidator ID="vreqEmail" runat="server" ErrorMessage="Email is required" ControlToValidate="txfEmail" ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="vreEmail" ControlToValidate="txfEmail" runat="server" ForeColor="Red" ErrorMessage="Enter Valid email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                            <div id="divOutput"></div>
                            

                        </td>                        
                    </tr>
                    <tr>
                        <td>Password</td>
                        <td>                            
                            <asp:TextBox ID="txfPassword" runat="server" placeholder="Password" TextMode="Password" required="true">
                            </asp:TextBox>
                            <asp:RequiredFieldValidator ID="vreqPassword" ControlToValidate="txfPassword" ForeColor="Red" runat="server" ErrorMessage="Password is Required"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="vrePassword" ForeColor="Red" ControlToValidate="txfPassword" runat="server" ErrorMessage="Minimum eight characters required" ValidationExpression="^[\s\S]{8,50}$"></asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>Confirm Password</td>
                        <td>                            
                            <asp:TextBox ID="txfPasswordConfirm" placeholder="Confirm Password" TextMode="Password" runat="server" required="true"></asp:TextBox>
                            <asp:CompareValidator ID="vcmpPasswordConfirm" runat="server" ForeColor="Red" ControlToCompare="txfPassword" ControlToValidate="txfPasswordConfirm" ErrorMessage="Enter Same password"></asp:CompareValidator>

                        </td>
                    </tr>
                    <tr>
                        <td>

                        </td>
                        <td>
                            <div class="g-recaptcha" data-sitekey="6LcQo1IUAAAAAB2MkNkeO78koleQCl7T-4PSMwnw"></div>
                            <asp:CustomValidator ID="vcustCaptcha" OnServerValidate="vcustCaptcha_ServerValidate" runat="server" ErrorMessage="Validate Captcha!" ForeColor="Red"></asp:CustomValidator>
                        </td>
                    </tr>
                    <tr class="success">
                        <td colspan="2">                            
                            <asp:Button ID="btnSignUp" runat="server" Text="Sign Up"  CssClass="btn btn-success" OnClick="btnSignUp_Click"/>
                        </td>
                    </tr>
                </tbody>
            </table>
          
            <!--Bootstrap alert to display any validation errors-->
            <div id="divError" class="alert alert-danger collapse">
                <a id="linkClose" href="#" class="close">&times;</a>
                <div id="divErrorText"></div>
            </div>
        </div>
    </div>

    
    </form>
    
</body>
</html>
