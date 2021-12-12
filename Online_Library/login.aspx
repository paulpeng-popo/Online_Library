<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="login.aspx.vb" Inherits="Online_Library.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Online Library System</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
        integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous" />
    <link href="login.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="https://cdn.staticfile.org/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>

    <script type="text/javascript">

        $(window).on('load', function () {
            if ( $.cookie('done_reading') != "true" ) {
                $('#Announcement').modal('show');
                $.cookie('done_reading', 'true');
            }
        });

        function ShowMessage() {
            let seconds = 1.5;
            setTimeout(function () {
                document.getElementById("<%=MyLabels.ClientID %>").style.display = "none";
            }, seconds * 1000);
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
        <div class="modal fade" id="Announcement" tabindex="-1" role="dialog" aria-labelledby="AnnouncementLongTitle" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="background-color: aquamarine">
                        <h5 class="modal-title" id="AnnouncementLongTitle">線上圖書館 使用須知</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p>親愛的讀者：</p>
                        <p>線上圖書館為開放式系統，只要線上註冊帳號、密碼即可使用，相關說明如下：</p>
                        <ul>
                            <li>
                                本系統提供沉浸式體驗的借閱服務，模擬人們在圖書館的行為。因此本系統之館藏具有數量限制，若多人同時借閱同一本書，可能會有借閱失敗之情形。
                            </li>
                            <li>
                                使用線上圖書館之讀者，只要登入帳號及密碼經系統認證後，即可免費閱讀上架之電子書部分章節(約1/10)；若讀者決定借閱該電子書，點選"我要借閱"，即可閱覽全文。
                            </li>
                            <li>
                                每個使用者帳號於本系統均可借閱電子書/雜誌，並可在任何時間地點閱讀14天（借期固定為14天），到期後自動歸還；如讀者14天後未閱讀完畢，可再續借。
                            </li>
                            <li>
                                本系統為尊重智慧財產權，圖書館的書籍資料不可被複製。
                            </li>
                            <li>
                                若有好書推薦上架本系統，歡迎來信聯絡管理員<br />
                                <a href = "mailto:kmes1234@gamil.com?subject=線上圖書館圖書推薦&body=請詳細說明書本資料及大綱">Send Feedback</a>。
                            </li>
                        </ul>
                        <p style="text-align: right;">線上圖書館 管理員 謹啟</p>
                    </div>
                    <div class="modal-footer" style="background-color: aquamarine">
                        <button type="button" class="btn btn-primary" data-dismiss="modal">我知道了</button>
                    </div>
                </div>
            </div>
        </div>
        <div id="container" class="my-whole-window">
            <div class="my-welcome">歡迎來到線上圖書館</div>
            <div id="login-window" class="my-item-center">
                <div class="my-login-body">
                    <div style="font-family: 'MS Reference Sans Serif'; font-size: 32px; font-weight: bold;">使用者登入</div>
                    <div>
                        <div style="font-family: 'MS Reference Sans Serif'; font-size: 18.72px; font-weight: bold;">使用者名稱</div>
                        <asp:TextBox ID="UsernameTextBox" runat="server" required="required"></asp:TextBox>
                    </div>
                    <div>
                        <div style="font-family: 'MS Reference Sans Serif'; font-size: 18.72px; font-weight: bold;">密碼</div>
                        <asp:TextBox ID="PasswordTextBox" runat="server" required="required" TextMode="Password"></asp:TextBox>
                    </div>
                </div>
                <div class="my-buttons">
                    <asp:Button ID="Register" runat="server" Text="註冊" CausesValidation="false" UseSubmitBehavior="false" />
                    <asp:Button ID="UserSubmit" runat="server" Text="一般登入" />
                    <asp:Button ID="AdminSubmit" runat="server" Text="管理員登入" />
                </div>
                <div id="mylabels" class="my-labels">
                    <asp:Panel ID="MyLabels" runat="server" Visible="false" Height="50px">
                        <asp:Label ID="Message" runat="server" Text="" Font-Bold="True"></asp:Label>
                    </asp:Panel>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
