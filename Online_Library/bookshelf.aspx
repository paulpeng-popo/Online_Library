<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="bookshelf.aspx.vb" Inherits="Online_Library.bookshelf" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Online Library System</title>
    <link href="bookshelf.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="header-container">
            <div id="BookText" class="chose-block">
                <asp:Label ID="BookName" runat="server" Text="書名:" Font-Bold="True" Font-Size="Large"></asp:Label>
                <asp:TextBox ID="BookNameTextBox" runat="server" Height="18px" Width="300px" AutoPostBack="True"></asp:TextBox>
            </div>
            <div id="ChoseCategory" class="chose-block">
                <asp:Label ID="CategoryLabel" runat="server" Text="選擇分類" Font-Bold="True" Font-Size="Large"></asp:Label>
                <asp:DropDownList ID="CategoryDropDownList" runat="server" Height="25px" AutoPostBack="True" DataSourceID="CategoryData" DataTextField="category" DataValueField="category">
                </asp:DropDownList>
            </div>
            <div id="ChoseYear" class="chose-block">
                <asp:Label ID="YearLabel" runat="server" Text="選擇年分" Font-Bold="True" Font-Size="Large"></asp:Label>
                <asp:DropDownList ID="YearDropDownList" runat="server" Height="25px" AutoPostBack="True" DataSourceID="YearData" DataTextField="pubyear" DataValueField="pubyear">
                </asp:DropDownList>
            </div>
            <div id="FilterAvailable" class="chose-block">
                <asp:CheckBox ID="AvailableCheckBox" runat="server" Text="只顯示目前可借" Font-Bold="True" Font-Size="Large" AutoPostBack="True" />
            </div>
        </div>
        <div class="body-container">
            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="BooksData">
                <HeaderTemplate>
                    <table border="1">
                        <tr>
                            <td><b>書名</b></td>
                            <td><b>作者</b></td>
                            <td><b>出版年份</b></td>
                            <td><b>國際標準書號</b></td>
                            <td><b>可借用本數</b></td>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td><%# Eval("bookname") %> </td>
                        <td><%# Eval("author") %> </td>
                        <td><%# Eval("pubyear") %> </td>
                        <td><%# Eval("ISBN") %> </td>
                        <td><%# Eval("quantity") %> </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
            <asp:SqlDataSource ID="CategoryData" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryConnectionString %>" SelectCommand="SELECT DISTINCT [category] FROM [Books] ORDER BY [category]"></asp:SqlDataSource>
            <asp:SqlDataSource ID="YearData" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryConnectionString %>" SelectCommand="SELECT DISTINCT [pubyear] FROM [Books] ORDER BY [pubyear] DESC"></asp:SqlDataSource>
            <asp:SqlDataSource ID="BooksData" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryConnectionString %>" SelectCommand="SELECT [bookname], [author], [pubyear], [ISBN], [quantity] FROM [Books] ORDER BY [bookname]"></asp:SqlDataSource>
            <div class="padding-row"></div>
        </div>
    </form>
</body>
</html>
