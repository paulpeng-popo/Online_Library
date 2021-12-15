<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="bookshelf.aspx.vb" Inherits="Online_Library.bookshelf" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Online Library System</title>
    <script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/css/bootstrap.min.css" media="screen" />
    <link href="bookshelf.css" rel="stylesheet" />
    <script type="text/javascript">

        function ShowPopup(title, body) {
            $("#MyPopup .modal-title").html(title);
            $("#MyPopup .modal-body pre").html(body);
            $("#MyPopup").modal("show");
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
        <div id="MyPopup" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"></h4>
                    </div>
                    <div class="modal-body">
                        <pre></pre>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <asp:Panel ID="SearchHeader" runat="server">
            <div class="header-container">
                <div id="LogoutZone" style="float: left; padding: 10px 0 10px 20px;">
                    <asp:Button ID="LogoutButton" runat="server" Text="登出" BorderStyle="Solid" Height="30px" Width="60px" />
                </div>
                <div id="BookText" class="choose-block">
                    <asp:Label ID="BookName" runat="server" Text="書名(或包含的字詞):" Font-Bold="True" Font-Size="Large"></asp:Label>
                    <asp:TextBox ID="BookNameTextBox" runat="server" Text="<所有書目>" Height="18px" Width="300px" AutoPostBack="True"></asp:TextBox>
                </div>
                <div id="ChoseCategory" class="choose-block">
                    <asp:Label ID="CategoryLabel" runat="server" Text="選擇分類" Font-Bold="True" Font-Size="Large"></asp:Label>
                    <asp:DropDownList ID="CategoryDropDownList" runat="server" Height="25px" AutoPostBack="True" AppendDataBoundItems="true"
                        DataSourceID="CategoryData" DataTextField="category" DataValueField="category">
                        <asp:ListItem Text="<所有種類>" Value="<所有種類>" />
                    </asp:DropDownList>
                </div>
                <div id="ChoseYear" class="choose-block">
                    <asp:Label ID="YearLabel" runat="server" Text="選擇年分" Font-Bold="True" Font-Size="Large"></asp:Label>
                    <asp:DropDownList ID="YearDropDownList" runat="server" Height="25px" AutoPostBack="True" AppendDataBoundItems="true"
                        DataSourceID="YearData" DataTextField="pubyear" DataValueField="pubyear">
                        <asp:ListItem Text="<所有年份>" Value="0" />
                    </asp:DropDownList>
                </div>
                <div id="FilterAvailable" class="choose-block">
                    <asp:CheckBox ID="AvailableCheckBox" runat="server" Text="只顯示目前可借" Font-Bold="True" Font-Size="Large" AutoPostBack="True" />
                </div>
                <div id="UserInfo" style="float: right; padding: 10px 30px 10px 0">
                    <asp:Label ID="UserNameTop" runat="server" Font-Bold="True" Font-Size="Large" BorderStyle="Groove" Height="30px"></asp:Label>
                </div>
                <div id="UserButton" style="float: right; padding: 0 30px 20px 20px">
                    <asp:Button ID="UserBook" runat="server" Text="我的書庫" BorderStyle="Solid" Height="30px" Width="100px" />
                </div>
            </div>
        </asp:Panel>
        <div class="body-container">
            <asp:Panel ID="LibraryWindow" runat="server">
                <asp:Repeater ID="DynamicDataTable" runat="server" DataSourceID="BooksData">
                    <HeaderTemplate>
                        <table border="1">
                            <tr>
                                <td><b>編號</b></td>
                                <td><b>書名</b></td>
                                <td><b>作者</b></td>
                                <td><b>書目分類項</b></td>
                                <td><b>出版年份</b></td>
                                <td><b>可借用本數</b></td>
                                <td><b>書本資料及借閱</b></td>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td><%# Me.DynamicDataTable.Items.Count + 1 %></td>
                            <td><%# Eval("bookname") %></td>
                            <td><%# Eval("author") %></td>
                            <td><%# Eval("category") %></td>
                            <td><%# Eval("pubyear") %></td>
                            <td><%# Eval("quantity") %></td>
                            <td>
                                <asp:Button ID="Details" runat="server" Text="我要借閱" BorderStyle="Solid" Height="30px"
                                    CommandArgument='<%# Eval("ISBN") %>' OnCommand="Detail_Click" />
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
                <asp:SqlDataSource ID="CategoryData" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryConnectionString %>" SelectCommand="SELECT DISTINCT [category] FROM [Books] ORDER BY [category]"></asp:SqlDataSource>
                <asp:SqlDataSource ID="YearData" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryConnectionString %>" SelectCommand="SELECT DISTINCT [pubyear] FROM [Books] ORDER BY [pubyear] DESC"></asp:SqlDataSource>
                <asp:SqlDataSource ID="BooksData" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryConnectionString %>" SelectCommand="SELECT * FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM (SELECT [bookname], [author], [category], [Books].[ISBN], [pubyear], [quantity] FROM [Books] WHERE NOT EXISTS (SELECT * FROM [LibraryCard] WHERE [Books].[ISBN] = [LibraryCard].[ISBN] AND @quantity = 1)) AS [DontHaveTable] WHERE [DontHaveTable].[quantity] &gt;= @quantity OR @quantity = 0) AS [QuantityTable] WHERE [QuantityTable].[pubyear] = @pubyear OR @pubyear = 0) AS [YearTable] WHERE [YearTable].[category] = @category OR @category LIKE N'%所有種類%') AS [CategoryTable] WHERE [CategoryTable].[bookname] LIKE '%' + @bookname + '%' OR @bookname LIKE N'%所有書目%' ORDER BY [bookname]">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="BookNameTextBox" Name="bookname" Type="String" PropertyName="Text" />
                        <asp:ControlParameter ControlID="CategoryDropDownList" Name="category" Type="String" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="YearDropDownList" Name="pubyear" Type="Int32" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="AvailableCheckBox" Name="quantity" Type="Int32" PropertyName="Checked" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </asp:Panel>
            <div class="padding-row"></div>
            <asp:Panel ID="BookWindow" runat="server" Visible="false" CssClass="window-center">
                <div style="float: right; padding: 10px 30px 10px 0">
                    <asp:Label ID="UserNameDown" runat="server" Font-Bold="True" Font-Size="Large" BorderStyle="Groove" Height="30px"></asp:Label>
                </div>
                <div style="display: inline-block">
                    <asp:Image ID="BookImage" runat="server" Height="280px" Width="200px" />
                </div>
                <div style="display: inline-block; height: 280px; width: 700px;">
                    <ul>
                        <li><strong>書名:</strong>
                            <asp:Label ID="Name" runat="server" Text="" Font-Size="Large"></asp:Label></li>
                        <li><strong>作者:</strong>
                            <asp:Label ID="Author" runat="server" Text="" Font-Size="Large"></asp:Label></li>
                        <li><strong>出版社:</strong>
                            <asp:Label ID="Publisher" runat="server" Text="" Font-Size="Large"></asp:Label></li>
                        <li><strong>出版年份:</strong>
                            <asp:Label ID="Year" runat="server" Text="" Font-Size="Large"></asp:Label><strong>年</strong></li>
                        <li><strong>國際標準書號:</strong>
                            <asp:Label ID="BookNumber" runat="server" Text="" Font-Size="Large"></asp:Label></li>
                        <li><strong>總頁數:</strong>
                            <asp:Label ID="Pages" runat="server" Text="" Font-Size="Large"></asp:Label><strong>頁</strong></li>
                        <li><strong>可借閱本數:</strong>
                            <asp:Label ID="Amount" runat="server" Text="" Font-Size="Large"></asp:Label><strong>本</strong></li>
                    </ul>
                    <div style="position: relative; bottom: -70px; float: left;">
                        <asp:Button ID="SimpleRead" runat="server" Text="試閱" BorderStyle="Inset" Height="30px" />
                        <asp:Button ID="Borrow" runat="server" Text="我要借書" BorderStyle="Inset" Height="30px" />
                    </div>
                    <div style="position: relative; bottom: -70px; float: right;">
                        <asp:Button ID="ReturnButton" runat="server" Text="返回搜尋頁" BorderStyle="Outset" Height="30px" />
                    </div>
                </div>
            </asp:Panel>
        </div>
    </form>
</body>
</html>
