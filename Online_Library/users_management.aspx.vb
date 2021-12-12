Public Class users_management
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim cookie As HttpCookie = Request.Cookies("User_Info")
        If cookie Is Nothing OrElse cookie("value") <> Session(cookie("key")) Or cookie("identity") <> "admin" Then
            Response.Redirect("login.aspx")
        End If

    End Sub

End Class