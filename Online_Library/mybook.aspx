<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="mybook.aspx.vb" Inherits="Online_Library.mybook" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Repeater ID="DynamicDataTable" runat="server" DataSourceID="BooksData">
                <HeaderTemplate>
                    <table border="1">
                        <tr>
                            <td><b>編號</b></td>
                            <td><b>書本外觀</b></td>
                            <td><b>書名</b></td>
                            <td><b>作者</b></td>
                            <td><b>書目分類項</b></td>
                            <td><b>閱讀</b></td>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td><%# Me.DynamicDataTable.Items.Count + 1 %></td>
                        <td>
                            <asp:Image ID="BookImage" runat="server" Height="280px" Width="200px" ImageUrl='<%# Eval("bookimage", "~/resources/{0}") %>' /></td>
                        <td><%# Eval("bookname") %></td>
                        <td><%# Eval("author") %></td>
                        <td><%# Eval("category") %></td>
                        <td>
                            <asp:Button ID="StartReading" runat="server" Text="開始閱讀" BorderStyle="Solid" Height="30px"
                                CommandArgument='<%# Eval("ISBN") %>' OnCommand="Read_Click" />
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
            <asp:SqlDataSource ID="BooksData" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryConnectionString %>" SelectCommand="SELECT [bookname], [bookimage], [author], [category], [LibraryCard].[ISBN] FROM [Books], [LibraryCard] WHERE [LibraryCard].[ISBN] = [Books].[ISBN] ORDER BY [start_date] DESC"></asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
