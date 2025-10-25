<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, utils.Conexion" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    // ✅ Verificar sesión
    if (session.getAttribute("rol") == null || !session.getAttribute("rol").equals("admin")) {
        response.sendRedirect("../login.jsp");
        return;
    }

    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Usuarios - INFRA REPORT</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8fafc;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .card {
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .btn {
            border-radius: 8px;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <div class="card">
        <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
            <h4 class="mb-0"><i class="bi bi-people-fill"></i> Gestión de Usuarios</h4>
            <a href="agregarUsuario.jsp" class="btn btn-light btn-sm">
                <i class="bi bi-person-plus"></i> Nuevo Usuario
            </a>
            <a href="../admin.jsp" class="btn btn-outline-light btn-sm">
                    <i class="bi bi-house-door"></i> Volver al Panel  </a>
        </div>
        <div class="card-body">
            <table class="table table-hover align-middle">
                <thead class="table-primary">
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Usuario</th>
                        <th>Rol</th>
                        <th>Estado</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            conn = Conexion.getConnection();
                            stmt = conn.createStatement();
                            rs = stmt.executeQuery("SELECT * FROM usuarios");

                            while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getInt("id") %></td>
                        <td><%= rs.getString("nombre") %></td>
                        <td><%= rs.getString("username") %></td>
                        <td><%= rs.getString("rol") %></td>
                        <td><span class="badge bg-<%= rs.getString("estado").equals("activo") ? "success" : "secondary" %>">
                            <%= rs.getString("estado") %></span>
                        </td>
                        <td>
                            <a href="editarUsuario.jsp?id=<%= rs.getInt("id") %>" class="btn btn-warning btn-sm">
                                <i class="bi bi-pencil-square"></i>
                            </a>
                            <a href="../EliminarUsuarioServlet?id=<%= rs.getInt("id") %>" 
                               class="btn btn-danger btn-sm"
                               onclick="return confirm('¿Seguro que deseas eliminar este usuario?');">
                                <i class="bi bi-trash"></i>
                            </a>
                        </td>
                    </tr>
                    <%
                            }
                        } catch (Exception e) {
                            out.println("<tr><td colspan='6' class='text-center text-danger'>Error: " + e.getMessage() + "</td></tr>");
                        } finally {
                            if (rs != null) rs.close();
                            if (stmt != null) stmt.close();
                            if (conn != null) conn.close();
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
