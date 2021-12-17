Imports System.Data.SqlClient

Public Class mybook
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim cookie As HttpCookie = Request.Cookies("User_Info")
        If cookie Is Nothing OrElse cookie("value") <> Session(cookie("key")) Then
            Response.Redirect("login.aspx")
        End If

    End Sub

    Protected Sub Read_Click(ByVal sender As Object, ByVal e As CommandEventArgs)

        Dim ISBN As String = e.CommandArgument.ToString()

        Dim connection As New SqlConnection("Server = paul\sqlexpress; Database = Library; Integrated Security = true")
        Dim command As New SqlCommand("SELECT * FROM Books WHERE ISBN = @isbn", connection)
        command.Parameters.Add("@isbn", SqlDbType.BigInt).Value = ISBN
        Dim adapter As New SqlDataAdapter(command)
        Dim table As New DataTable()
        adapter.Fill(table)

        If table.Rows.Count = 1 Then

            Dim BookInfo As DataRow = table.AsEnumerable().First()
            BookName.Text = BookInfo("bookname")
            Dim fileReader As String = My.Computer.FileSystem.ReadAllText("D:\paul\database\Lab\Online_Library\Online_Library\resources\bookcontent.txt")

            fileReader = fileReader.Replace(vbCrLf, "<br />")
            fileReader = fileReader.Replace(vbTab, "&emsp;&emsp;")
            ScriptManager.RegisterStartupScript(Me, Page.GetType, "Script", "Showtext('" & fileReader & "')", True)

            DynamicDataTable.Visible = False
            Panel.Visible = True

        End If

    End Sub

    Protected Sub BackButton_Click(sender As Object, e As EventArgs) Handles BackButton.Click

        ScriptManager.RegisterStartupScript(Me, Page.GetType, "Script", "Showtext('')", True)
        DynamicDataTable.Visible = True
        Panel.Visible = False

    End Sub

    Protected Sub Return_Click(ByVal sender As Object, ByVal e As CommandEventArgs)

        Dim ISBN As String = e.CommandArgument.ToString()
        Dim cookie As HttpCookie = Request.Cookies("User_Info")
        Dim CurrentUser As String = Session(Session(cookie("key")))

        Dim connection As New SqlConnection("Server = paul\sqlexpress; Database = Library; Integrated Security = true")

        Dim findReturnBook As New SqlCommand("DELETE FROM [LibraryCard] WHERE @currentUser = [username] AND @isbn = [ISBN]", connection)
        findReturnBook.Parameters.Add("@currentUser", SqlDbType.NVarChar).Value = CurrentUser
        findReturnBook.Parameters.Add("@isbn", SqlDbType.BigInt).Value = ISBN
        Dim adapter1 As New SqlDataAdapter(findReturnBook)
        Dim table1 As New DataTable()
        adapter1.Fill(table1)

        Dim returnBook As New SqlCommand("UPDATE [Books] SET [quantity] = [quantity] + 1 WHERE @isbn = [Books].[ISBN]", connection)
        returnBook.Parameters.Add("@isbn", SqlDbType.BigInt).Value = ISBN
        Dim adapter2 As New SqlDataAdapter(returnBook)
        Dim table2 As New DataTable()
        adapter2.Fill(table2)

        ScriptManager.RegisterStartupScript(Me, Page.GetType, "Script", "alert('還書成功')", True)
        Response.AddHeader("REFRESH", "0;URL=mybook.aspx")

    End Sub

End Class