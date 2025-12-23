<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="KayitOl.aspx.cs" Inherits="Internet_Programciligi_Odev.KayitOl" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Kayıt Ol</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #e9ecef; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .register-container { background: white; padding: 40px; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); width: 350px; }
        .header { text-align: center; color: #333; margin-bottom: 20px; }
        .input-group { margin-bottom: 15px; }
        .input-control { width: 100%; padding: 10px; border: 1px solid #ced4da; border-radius: 5px; box-sizing: border-box; }
        .btn-register { width: 100%; padding: 12px; background-color: #17a2b8; border: none; color: white; border-radius: 5px; cursor: pointer; font-weight: bold; }
        .btn-register:hover { background-color: #138496; }
        .login-link { display: block; text-align: center; margin-top: 15px; color: #007bff; text-decoration: none; font-size: 0.9em; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="register-container">
            <h2 class="header">Yeni Kayıt Oluştur</h2>
            
            <asp:Label ID="lblDurum" runat="server" Text="" ForeColor="Red"></asp:Label>

            <div class="input-group">
                <asp:TextBox ID="txtKadi" runat="server" CssClass="input-control" placeholder="Kullanıcı Adı"></asp:TextBox>
            </div>

            <div class="input-group">
                <asp:TextBox ID="txtSifre" runat="server" CssClass="input-control" TextMode="Password" placeholder="Şifre"></asp:TextBox>
            </div>

            <div class="input-group">
                <label style="font-size:0.8em; color:#666;">Güvenlik Sorusu Seçiniz:</label>
                <asp:DropDownList ID="ddlSorular" runat="server" CssClass="input-control"></asp:DropDownList>
            </div>

            <div class="input-group">
                <asp:TextBox ID="txtCevap" runat="server" CssClass="input-control" placeholder="Sorunun Cevabı"></asp:TextBox>
            </div>

            <asp:Button ID="btnKayitOl" runat="server" Text="Kayıt Ol" CssClass="btn-register" OnClick="btnKayitOl_Click" />
            
            <a href="WebForm1.aspx" class="login-link">Zaten hesabın var mı? Giriş Yap</a>
        </div>
    </form>
</body>
</html>