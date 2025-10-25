<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, utils.Conexion" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    // ✅ Verificar sesión
    if (session.getAttribute("rol") == null || !session.getAttribute("rol").equals("admin")) {
        response.sendRedirect("../login.jsp");
        return;
    }

    String mensaje = null;

   
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Nuevo Usuario - INFRA REPORT</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow-sm">
        <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
            <h5 class="mb-0"><i class="bi bi-person-plus"></i> Registrar Nuevo Usuario</h5>
            <a href="usuarios.jsp" class="btn btn-light btn-sm">
                <i class="bi bi-arrow-left"></i> Volver
            </a>
        </div>
        <div class="card-body">

            <% if (mensaje != null) { %>
                <div class="alert alert-info"><%= mensaje %></div>
            <% } %>

            <form method="post" action="../AgregarUsuarioServlet">

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Nombre Completo</label>
                        <input type="text" name="nombre" class="form-control" required>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">Usuario</label>
                        <input type="text" name="username" class="form-control" required>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">Contraseña</label>
                        <input type="password" name="password" class="form-control" required>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">Rol</label>
                        <select name="rol" class="form-select" required>
                            <option value="">Seleccionar...</option>
                            <option value="admin">Administrador</option>
                            <option value="sereno">Sereno</option>
                            <option value="vecino">Vecino</option>
                        </select>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">Estado</label>
                        <select name="estado" class="form-select">
                            <option value="activo" selected>Activo</option>
                            <option value="inactivo">Inactivo</option>
                        </select>
                    </div>
                </div>

                <div class="text-end">
                    <button type="submit" class="btn btn-success">
                        <i class="bi bi-check-circle"></i> Guardar Usuario
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>
