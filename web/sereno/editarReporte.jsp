<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, utils.Conexion" %>

<%
    String idParam = request.getParameter("id");
    if (idParam == null) {
        response.sendRedirect("../sereno.jsp");
        return;
    }

    int id = Integer.parseInt(idParam);
    String categoria = "", lugar = "", descripcion = "", estado = "";
    boolean urgente = false;

    try (Connection conn = Conexion.getConnection();
         PreparedStatement ps = conn.prepareStatement("SELECT * FROM reportes WHERE id=?")) {

        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            categoria = rs.getString("categoria");
            lugar = rs.getString("lugar");
            descripcion = rs.getString("descripcion");
            estado = rs.getString("estado");
            urgente = rs.getBoolean("urgente");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    // ✅ Detectar rol y definir a dónde volver
    HttpSession ses = request.getSession(false);
    String rol = (ses != null && ses.getAttribute("rol") != null)
                 ? ses.getAttribute("rol").toString()
                 : "login";

    String destino = "login.jsp";
    if ("sereno".equals(rol)) {
        destino = "../sereno.jsp";
    } else if ("vecino".equals(rol)) {
        destino = "../vecino.jsp";
    } else if ("admin".equals(rol)) {
        destino = "../admin.jsp";
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Reporte</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-warning text-dark">
            <h4><i class="bi bi-pencil-square"></i> Editar Reporte</h4>
        </div>
        <div class="card-body">
            <form action="../EditarReporteServlet" method="post">
                <input type="hidden" name="id" value="<%= id %>">

                <div class="mb-3">
                    <label class="form-label">Categoría</label>
                    <input type="text" name="categoria" class="form-control" value="<%= categoria %>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Lugar</label>
                    <input type="text" name="lugar" class="form-control" value="<%= lugar %>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Descripción</label>
                    <textarea name="descripcion" class="form-control" rows="3"><%= descripcion %></textarea>
                </div>

                <div class="mb-3">
                    <label class="form-label">Estado</label>
                    <select name="estado" class="form-select">
                        <option value="pendiente" <%= estado.equals("pendiente") ? "selected" : "" %>>Pendiente</option>
                        <option value="en_proceso" <%= estado.equals("en_proceso") ? "selected" : "" %>>En Proceso</option>
                        <option value="resuelto" <%= estado.equals("resuelto") ? "selected" : "" %>>Resuelto</option>
                    </select>
                </div>

                <div class="form-check mb-3">
                    <input class="form-check-input" type="checkbox" name="urgente" <%= urgente ? "checked" : "" %>>
                    <label class="form-check-label">Marcar como urgente</label>
                </div>

                <div class="d-flex justify-content-between">
                    <!-- ✅ Botón dinámico según rol -->
                    <a href="<%= destino %>" class="btn btn-secondary">
                        <i class="bi bi-arrow-left"></i> Volver
                    </a>
                    <button type="submit" class="btn btn-warning">
                        <i class="bi bi-save"></i> Guardar Cambios
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
