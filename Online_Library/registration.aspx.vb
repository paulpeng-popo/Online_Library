Imports System.Data.SqlClient
Imports System.Security.Cryptography
Public Class registration
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

        'Dim cookie As HttpCookie = Request.Cookies("User_Info")
        'If cookie IsNot Nothing Then
        'Response.Redirect("login.aspx")
        'End If

    End Sub

    Protected Sub Check_Click(sender As Object, e As EventArgs) Handles Check.Click

        Dim connection As New SqlConnection("Server = paul\sqlexpress; Database = Library; Integrated Security = true")
        Dim command As New SqlCommand("SELECT username FROM Users WHERE username = @username", connection)
        command.Parameters.Add("@username", SqlDbType.NVarChar).Value = UsernameTextBox.Text.Trim()
        Dim adapter As New SqlDataAdapter(command)
        Dim table As New DataTable()
        adapter.Fill(table)

        Labels.Visible = True
        If table.Rows.Count <> 0 Then
            ScriptManager.RegisterStartupScript(Me, Page.GetType, "Script", "back_result('Invalid')", True)
            Message.Text = "此使用者名稱已存在"
        Else
            ScriptManager.RegisterStartupScript(Me, Page.GetType, "Script", "back_result('Valid')", True)
            Message.Text = "使用者名稱可使用"
            UsernameTextBox.Enabled = False
            EmailAddressRow.Visible = True
            PasswordRow.Visible = True
            PasswordAgainRow.Visible = True
            Check.Visible = False
            Change.Visible = True
            Register.Visible = True
        End If

    End Sub

    Protected Sub Change_Click(sender As Object, e As EventArgs) Handles Change.Click

        Message.Text = ""
        Labels.Visible = False
        UsernameTextBox.Text = ""
        UsernameTextBox.Enabled = True
        EmailTextBox.Text = ""
        EmailAddressRow.Visible = False
        PasswordRow.Visible = False
        PasswordAgainRow.Visible = False
        Check.Visible = True
        Register.Visible = False
        Change.Visible = False

    End Sub

    Protected Sub Register_Click(ByVal sender As Object, ByVal e As EventArgs) Handles Register.Click

        Dim connection As New SqlConnection("Server = paul\sqlexpress; Database = Library; Integrated Security = true")
        Dim command As New SqlCommand(
            "INSERT INTO Users ( username, target_string, email_address ) VALUES ( @username, @password, @email );",
            connection
        )
        command.Parameters.Add("@username", SqlDbType.NVarChar).Value = UsernameTextBox.Text.Trim()
        command.Parameters.Add("@password", SqlDbType.NVarChar).Value = SHA384Hash(PasswordTextBox.Text.Trim())
        command.Parameters.Add("@email", SqlDbType.NVarChar).Value = EmailTextBox.Text.Trim()
        Dim adapter As New SqlDataAdapter(command)
        Dim table As New DataTable()
        adapter.Fill(table)
        Message.Text = "註冊成功，畫面將在3秒後自動跳轉"
        UsernameTextBox.Text = ""
        EmailTextBox.Text = ""
        UsernameTextBox.Visible = False
        EmailAddressRow.Visible = False
        PasswordRow.Visible = False
        PasswordAgainRow.Visible = False
        Register.Visible = False
        Change.Visible = False
        Response.AddHeader("REFRESH", "2;URL=login.aspx")

    End Sub

End Class