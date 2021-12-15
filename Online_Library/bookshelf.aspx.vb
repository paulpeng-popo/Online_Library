Imports System.Data.SqlClient

Public Class bookshelf
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim cookie As HttpCookie = Request.Cookies("User_Info")
        If cookie Is Nothing OrElse cookie("value") <> Session(cookie("key")) Then
            Response.Redirect("login.aspx")
        End If

        If BookNameTextBox.Text = "" Then
            BookNameTextBox.Text = "<所有書目>"
        End If

        UserNameTop.Text = "登入身分: " + Session(Session(cookie("key")))
        UserNameDown.Text = "登入身分: " + Session(Session(cookie("key")))

        Dim connection As New SqlConnection("Server = paul\sqlexpress; Database = Library; Integrated Security = true")

        Dim findOutdatedBook As New SqlCommand("SELECT [ISBN] FROM [LibraryCard] WHERE due_date < @now_date", connection)
        findOutdatedBook.Parameters.Add("@now_date", SqlDbType.Date).Value = Date.Now()
        Dim adapter1 As New SqlDataAdapter(findOutdatedBook)
        Dim table1 As New DataTable()
        adapter1.Fill(table1)

        Dim temp = From list In table1.AsEnumerable() Select list("ISBN")
        For i As Integer = 0 To temp.ToArray().Length - 1

            Dim theChangedISBN = temp.ToArray().ElementAt(i)

            Dim returnBook As New SqlCommand("UPDATE [Books] SET [quantity] = [quantity] + 1 WHERE @isbn = [Books].[ISBN]", connection)
            returnBook.Parameters.Add("@isbn", SqlDbType.BigInt).Value = theChangedISBN
            Dim adapter2 As New SqlDataAdapter(returnBook)
            Dim table2 As New DataTable()
            adapter2.Fill(table2)

            Dim deleteInCard As New SqlCommand("DELETE FROM [LibraryCard] WHERE [ISBN] = @isbn", connection)
            deleteInCard.Parameters.Add("@isbn", SqlDbType.BigInt).Value = theChangedISBN
            Dim adapter3 As New SqlDataAdapter(deleteInCard)
            Dim table3 As New DataTable()
            adapter3.Fill(table3)

        Next

    End Sub

    Protected Sub LogoutButton_Click(sender As Object, e As EventArgs) Handles LogoutButton.Click

        Session.Clear()
        Response.Cookies.Remove("User_Info")
        Response.Redirect("login.aspx")

    End Sub

    Protected Sub Detail_Click(ByVal sender As Object, ByVal e As CommandEventArgs)

        Dim AlreadyHave As Boolean = False
        Dim ISBN As String = e.CommandArgument.ToString()
        Session.Add("Selected_Book", ISBN)

        Dim connection As New SqlConnection("Server = paul\sqlexpress; Database = Library; Integrated Security = true")
        Dim command As New SqlCommand("SELECT * FROM Books WHERE ISBN = @isbn", connection)
        command.Parameters.Add("@isbn", SqlDbType.BigInt).Value = ISBN
        Dim adapter As New SqlDataAdapter(command)
        Dim table As New DataTable()
        adapter.Fill(table)

        Dim findcommand As New SqlCommand("SELECT * FROM LibraryCard WHERE ISBN = @isbn", connection)
        findcommand.Parameters.Add("@isbn", SqlDbType.BigInt).Value = ISBN
        Dim newadapter As New SqlDataAdapter(findcommand)
        Dim newtable As New DataTable()
        newadapter.Fill(newtable)

        If newtable.Rows.Count > 0 Then

            AlreadyHave = True

        End If

        If table.Rows.Count = 1 Then

            Dim BookInfo As DataRow = table.AsEnumerable().First()
            BookImage.ImageUrl = "~/resources/" + BookInfo("bookimage").ToString()
            Name.Text = BookInfo("bookname").ToString()
            Author.Text = BookInfo("author").ToString()
            Publisher.Text = BookInfo("publisher").ToString()
            Year.Text = BookInfo("pubyear").ToString()
            BookNumber.Text = BookInfo("ISBN").ToString()
            Pages.Text = BookInfo("pages").ToString()
            Amount.Text = BookInfo("quantity").ToString()

            If BookInfo("quantity") <= 0 OrElse AlreadyHave Then
                Borrow.Enabled = False
            Else
                Borrow.Enabled = True
            End If

            SearchHeader.Visible = False
            LibraryWindow.Visible = False
            BookWindow.Visible = True

        End If

    End Sub

    Protected Sub UserBook_Click(sender As Object, e As EventArgs) Handles UserBook.Click

        Response.Redirect("userpanel.aspx")

    End Sub

    Protected Sub SimpleRead_Click(sender As Object, e As EventArgs) Handles SimpleRead.Click

        Dim ISBN As String = Session("Selected_Book")

        Dim connection As New SqlConnection("Server = paul\sqlexpress; Database = Library; Integrated Security = true")
        Dim command As New SqlCommand("SELECT [bookname], [abstract] FROM Books WHERE ISBN = @isbn", connection)
        command.Parameters.Add("@isbn", SqlDbType.BigInt).Value = ISBN
        Dim adapter As New SqlDataAdapter(command)
        Dim table As New DataTable()
        adapter.Fill(table)

        Dim title As String = table.AsEnumerable.First()("bookname").ToString()
        Dim body As String = table.AsEnumerable.First()("abstract").ToString()
        body = body.Replace(vbCrLf, "<br />")
        ScriptManager.RegisterStartupScript(Me, Page.GetType, "Script", "ShowPopup('" & title & "', '" & body & "');", True)

    End Sub

    Protected Sub Borrow_Click(sender As Object, e As EventArgs) Handles Borrow.Click

        Dim cookie As HttpCookie = Request.Cookies("User_Info")
        Dim ISBN As String = Session("Selected_Book")

        Dim connection As New SqlConnection("Server = paul\sqlexpress; Database = Library; Integrated Security = true")
        Dim command As New SqlCommand("INSERT INTO [LibraryCard] ( [ISBN], [username], [start_date], [due_date] ) VALUES ( @ISBN, @username, @startDate, @dueDate )", connection)
        command.Parameters.Add("@ISBN", SqlDbType.BigInt).Value = ISBN
        command.Parameters.Add("@username", SqlDbType.NVarChar).Value = Session(Session(cookie("key")))
        command.Parameters.Add("@startDate", SqlDbType.Date).Value = Date.Now()
        command.Parameters.Add("@dueDate", SqlDbType.Date).Value = Date.Now.AddDays(14)
        Dim adapter As New SqlDataAdapter(command)
        Dim table As New DataTable()
        adapter.Fill(table)

        Dim borrowcommand As New SqlCommand("UPDATE [Books] SET [quantity] = [quantity] - 1 WHERE ISBN = @isbn", connection)
        borrowcommand.Parameters.Add("@isbn", SqlDbType.BigInt).Value = ISBN
        Dim newadapter As New SqlDataAdapter(borrowcommand)
        Dim newtable As New DataTable()
        newadapter.Fill(newtable)

        ScriptManager.RegisterStartupScript(Me, Page.GetType, "Script", "alert('借閱成功');", True)
        Response.AddHeader("REFRESH", "0;URL=bookshelf.aspx")

    End Sub

    Protected Sub ReturnButton_Click(sender As Object, e As EventArgs) Handles ReturnButton.Click

        SearchHeader.Visible = True
        LibraryWindow.Visible = True
        BookWindow.Visible = False
        Session.Remove("Selected_Book")

    End Sub

End Class