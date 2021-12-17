<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="mybook.aspx.vb" Inherits="Online_Library.mybook" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        tr td {
            padding: 10px;
            text-align: center;
        }

        .noselect {
            -webkit-touch-callout: none; /* iOS Safari */
            -webkit-user-select: none; /* Safari */
            -moz-user-select: none; /* Old versions of Firefox */
            -ms-user-select: none; /* Internet Explorer/Edge */
            user-select: none; /* Non-prefixed version, currently
                                  supported by Chrome, Opera and Firefox */
        }
    </style>
    <script type="text/javascript">

        function Showtext(content) {
            document.getElementById("trash_text").innerHTML = content;
        }

    </script>
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
                            <td><b>歸還</b></td>
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
                        <td>
                            <asp:Button ID="BookReturn" runat="server" Text="我要還書" BorderStyle="Solid" Height="30px"
                                CommandArgument='<%# Eval("ISBN") %>' OnCommand="Return_Click" />
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
            <asp:SqlDataSource ID="BooksData" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryConnectionString %>" SelectCommand="SELECT [bookname], [bookimage], [author], [category], [LibraryCard].[ISBN] FROM [Books], [LibraryCard] WHERE [LibraryCard].[ISBN] = [Books].[ISBN] AND [LibraryCard].[username] = @currentUser ORDER BY [start_date] DESC">
                <SelectParameters>
                    <asp:SessionParameter Name="currentUser" SessionField="CurrentUser" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:Panel ID="Panel" runat="server" Visible="false">
                <div style="text-align: center; font-size: 30px;">
                    <asp:Label ID="BookName" runat="server" Text=""></asp:Label>
                </div>
                <div>
                    <asp:Button ID="BackButton" runat="server" Text="返回" />
                </div>
                <div>
                    <hr />
                    <p id="trash_text" class="noselect"></p>
                </div>
            </asp:Panel>
        </div>
    </form>
</body>
</html>
