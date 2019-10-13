<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="VFDS.Login"
     %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta charset="utf-8" />
   <script src='https://www.google.com/recaptcha/api.js' type="text/javascript"></script>      
    <link href="~/Content/bootstrap.min.css" rel="stylesheet" />

    <script src="~/Scripts/jquery-1.10.2.min.js"></script>
    <script src="~/Scripts/bootstrap.min.js"></script>

 

</head>
<body style="padding-top:20px">
<form id="form1" runat="server">
    <div class="col-md-10 col-md-offset-1">
        <div class="well">
            <!--Table to capture username and password-->
            <table class="table table-bordered">
                <thead>
                    <tr class="success">
                        <th colspan="2">
                            Existing User Login
                            <a href="Login/SignUp.aspx" class="btn btn-success pull-right">
                                Sign Up
                            </a>
                            
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Username / Email</td>
                        <td>                            
                            <asp:TextBox ID="txf_Email"  runat="server" placeholder="Enter Email..."  required></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Password</td>
                        <td>
                            <%--<input type="password" id="txtPassword" placeholder="Password" />--%>
                            <asp:TextBox ID="txf_Password" TextMode="Password" runat="server" placeholder="******" required></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                              <div class="g-recaptcha" data-sitekey="6LcQo1IUAAAAAB2MkNkeO78koleQCl7T-4PSMwnw"></div>
                            <asp:CustomValidator ID="vcustCaptcha" OnServerValidate="vcustCaptcha_ServerValidate" runat="server" ErrorMessage="Validate Captcha!" ForeColor="Red"></asp:CustomValidator>
                        </td>
                    </tr>
                    <tr class="success">
                        <td colspan="2">
                            <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-success" OnClick="btnLogin_Click" />
                            
                        </td>
                    </tr>
                </tbody>
            </table>
            <!--Bootstrap alert to display error message if the login fails-->
            
            <div id="divError" class="alert alert-danger" runat="server" visible="false">                
                <div id="divErrorText"> username or password is incorrect </div>
            </div>
            
        </div>
    </div>
        </form>
   
</body>
</html>
