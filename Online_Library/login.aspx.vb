Imports System.Data.SqlClient
Imports System.Security.Cryptography
Imports System.Timers.Timer

Public Class login
    Inherits System.Web.UI.Page

    Public Function SHA384Hash(ByVal InputString As String) As String

        Dim sha384_HexString As New StringBuilder()
        Dim sha384 As SHA384 = SHA384Managed.Create()
        Dim dataToHash As Byte() = Encoding.UTF8.GetBytes(InputString)
        Dim hashvalue As Byte() = sha384.ComputeHash(dataToHash)

        For i As Integer = 0 To hashvalue.Length - 1
            sha384_HexString.Append(hashvalue(i).ToString("X2"))
        Next
        Return sha384_HexString.ToString().ToLower()

    End Function

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim cookie As HttpCookie = Request.Cookies("User_Info")
        If cookie IsNot Nothing AndAlso cookie("value") = Session(cookie("key")) Then
            If cookie("identity") = "admin" Then
                Response.Redirect("users_management.aspx")
            ElseIf cookie("identity") = "user" Then
                Response.Redirect("bookshelf.aspx")
            End If
        End If

    End Sub

    Protected Sub AdminSubmit_Click(ByVal sender As Object, ByVal e As EventArgs) Handles AdminSubmit.Click

        Dim connection As New SqlConnection("Server = paul\sqlexpress; Database = Library; Integrated Security = true")

        Dim command As New SqlCommand("SELECT * FROM Admins WHERE username = @username AND target_string = @password", connection)

        command.Parameters.Add("@username", SqlDbType.VarChar).Value = UsernameTextBox.Text.Trim()
        command.Parameters.Add("@password", SqlDbType.VarChar).Value = SHA384Hash(PasswordTextBox.Text.Trim())

        Dim adapter As New SqlDataAdapter(command)

        Dim table As New DataTable()

        adapter.Fill(table)

        If table.Rows.Count <= 0 Then

            Message.Text = "使用者名稱不存在或密碼錯誤"
            MyLabels.Visible = True
            ScriptManager.RegisterStartupScript(Me, Page.GetType, "Script", "ShowMessage()", True)

        Else

            Dim items = From list In table.AsEnumerable() Select list("target_string")
            Dim user_key As String = SHA384Hash(items.ToArray.ElementAt(0))
            Dim user_code As String = SHA384Hash(UsernameTextBox.Text.Trim())
            Dim cookie = New HttpCookie("User_Info")
            cookie("key") = user_key
            cookie("value") = user_code
            cookie("identity") = "admin"
            cookie.Expires = DateTime.Now.AddMinutes(30)

            Session.Add(user_key, user_code)
            Response.Cookies.Add(cookie)
            Response.Redirect("users_management.aspx")

        End If

    End Sub

    Protected Sub UserSubmit_Click(ByVal sender As Object, ByVal e As EventArgs) Handles UserSubmit.Click

        Dim connection As New SqlConnection("Server = paul\sqlexpress; Database = Library; Integrated Security = true")

        Dim command As New SqlCommand("SELECT * FROM Users WHERE username = @username AND target_string = @password", connection)

        command.Parameters.Add("@username", SqlDbType.VarChar).Value = UsernameTextBox.Text.Trim()
        command.Parameters.Add("@password", SqlDbType.VarChar).Value = SHA384Hash(PasswordTextBox.Text.Trim())

        Dim adapter As New SqlDataAdapter(command)

        Dim table As New DataTable()

        adapter.Fill(table)

        If table.Rows.Count <= 0 Then

            Message.Text = "使用者名稱不存在或密碼錯誤"
            MyLabels.Visible = True
            ScriptManager.RegisterStartupScript(Me, Page.GetType, "Script", "ShowMessage()", True)

        Else

            Dim items = From list In table.AsEnumerable() Select list("email_address")
            Dim user_key As String = SHA384Hash(items.ToArray.ElementAt(0))
            Dim user_code As String = SHA384Hash(UsernameTextBox.Text.Trim())
            Dim cookie = New HttpCookie("User_Info")
            cookie("key") = user_key
            cookie("value") = user_code
            cookie("identity") = "user"
            cookie.Expires = DateTime.Now.AddMinutes(30)

            Session.Add(user_key, user_code)
            Response.Cookies.Add(cookie)
            Response.Redirect("bookshelf.aspx")

        End If

    End Sub

    Protected Sub Register_Click(sender As Object, e As EventArgs) Handles Register.Click

        Response.Redirect("registration.aspx")

    End Sub

End Class