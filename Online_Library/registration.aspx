<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="registration.aspx.vb" Inherits="Online_Library.registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Online Library System</title>
    <link href="registration.css" rel="stylesheet" />
    <script>

        function check(input) {
            if (input.value != document.getElementById('PasswordTextBox').value) {
                input.setCustomValidity('密碼必須相同');
            } else {
                // input is valid -- reset the error message
                input.setCustomValidity('');
            }
        }

        function back_result(result_text) {
            setTimeout(function () {
                let target = document.getElementById('UsernameTextBox')
                if (result_text != "Valid") {
                    target.setCustomValidity('此名稱已存在');
                } else {
                    // input is valid -- reset the error message
                    input.setCustomValidity('');
                }
            }, 500)   
        }

        history.forward();

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <%
            Response.Buffer = True
            Response.Expires = 0
            Response.ExpiresAbsolute = DateTime.Now.AddDays(-1)
            Response.CacheControl = "no-cache"
        %>
        <div id="container" class="whole-window">
            <div id="login-window" class="item-center">
                <h1>新用戶註冊</h1>
                <asp:HyperLink ID="ReturnLogin" runat="server" Font-Italic="True" ForeColor="#CC0066"
                    Font-Underline="True" NavigateUrl="~/login.aspx" Font-Size="Small">我已經有帳號了 我要登入</asp:HyperLink>
                <div class="login-body">
                    <div>
                        <asp:Panel ID="AccountRow" runat="server">
                            <h3>使用者名稱</h3>
                            <asp:TextBox ID="UsernameTextBox" runat="server" required="required"
                                onInput="this.setCustomValidity('')" ClientIDMode="Static"></asp:TextBox>
                        </asp:Panel>
                    </div>
                    <div>
                        <asp:Panel ID="EmailAddressRow" runat="server" Visible="false">
                            <h3>電子郵件</h3>
                            <asp:TextBox ID="EmailTextBox" runat="server" required="required" placeholder="example@gmail.com"
                                TextMode="Email" ClientIDMode="Static"></asp:TextBox>
                        </asp:Panel>
                    </div>
                    <div>
                        <asp:Panel ID="PasswordRow" runat="server" Visible="false">
                            <h3>密碼</h3>
                            <asp:TextBox ID="PasswordTextBox" runat="server" placeholder="password"
                                onInvalid="setCustomValidity('請設定密碼')" onInput="this.setCustomValidity('')"
                                TextMode="Password" ClientIDMode="Static" ></asp:TextBox>
                        </asp:Panel>
                    </div>
                    <div>
                        <asp:Panel ID="PasswordAgainRow" runat="server" Visible="false">
                            <h3>確認密碼</h3>
                            <asp:TextBox ID="PasswordAgainTextBox" runat="server" placeholder="password"
                                onInput="check(this)" TextMode="Password" ClientIDMode="Static"></asp:TextBox>
                        </asp:Panel>
                    </div>
                </div>
                <div class="buttons">
                    <asp:Button ID="Check" runat="server" Text="檢查使用者名稱" />
                    <asp:Button ID="Change" runat="server" Text="更換使用者名稱" Visible="false"
                        CausesValidation="false" UseSubmitBehavior="false" />
                    <asp:Button ID="Register" runat="server" Text="註冊" Visible="false" />
                </div>
                <div class="labels">
                    <asp:Panel ID="Labels" runat="server" Visible="false" Height="50px">
                        <asp:Label ID="Message" runat="server" Text="" Font-Bold="True"></asp:Label>
                    </asp:Panel>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
