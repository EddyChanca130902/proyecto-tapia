<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, utils.Conexion" %>

<%
    // Verificar sesión
    if (session.getAttribute("rol") == null || !session.getAttribute("rol").equals("admin")) {
        response.sendRedirect("../login.jsp");
        return;
    }

    String idParam = request.getParameter("id");
    if (idParam == null) {
        response.sendRedirect("usuarios.jsp");
        return;
    }

    int id = Integer.parseInt(idParam);
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String nombre = "", username = "", rol = "", estado = "";

    try {
        conn = Conexion.getConnection();
        ps = conn.prepareStatement("SELECT * FROM usuarios WHERE id = ?");
        ps.setInt(1, id);
        rs = ps.executeQuery();
        if (rs.next()) {
            nombre = rs.getString("nombre");
            username = rs.getString("username");
            rol = rs.getString("rol");
            estado = rs.getString("estado");
        } else {
            response.sendRedirect("usuarios.jsp");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Usuario</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-warning text-dark d-flex justify-content-between align-items-center">
            <h4 class="mb-0"><i class="bi bi-pencil-square"></i> Editar Usuario</h4>
            <a href="usuarios.jsp" class="btn btn-light btn-sm">
                <i class="bi bi-arrow-left"></i> Volver
            </a>
        </div>
        <div class="card-body">
            <form action="../EditarUsuarioServlet" method="post">
                <input type="hidden" name="id" value="<%= id %>">

                <div class="mb-3">
                    <label class="form-label">Nombre</label>
                    <input type="text" name="nombre" class="form-control" value="<%= nombre %>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Usuario</label>
                    <input type="text" name="username" class="form-control" value="<%= username %>" required>
                </div>

                <!-- 🆕 Campo de nueva contraseña -->
                <div class="mb-3">
                    <label class="form-label">Nueva Contraseña (opcional)</label>
                    <input type="password" name="password" class="form-control" placeholder="Dejar vacío si no deseas cambiarla">
                </div>

                <div class="mb-3">
                    <label class="form-label">Rol</label>
                    <select name="rol" class="form-select" required>
                        <option value="admin" <%= rol.equals("admin") ? "selected" : "" %>>Administrador</option>
                        <option value="sereno" <%= rol.equals("sereno") ? "selected" : "" %>>Sereno</option>
                        <option value="vecino" <%= rol.equals("vecino") ? "selected" : "" %>>Vecino</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Estado</label>
                    <select name="estado" class="form-select">
                        <option value="activo" <%= estado.equals("activo") ? "selected" : "" %>>Activo</option>
                        <option value="inactivo" <%= estado.equals("inactivo") ? "selected" : "" %>>Inactivo</option>
                    </select>
                </div>

                <div class="text-end">
                    <button type="submit" class="btn btn-warning">
                        <i class="bi bi-check-circle"></i> Guardar Cambios
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
