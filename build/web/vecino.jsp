<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, utils.Conexion"%>

<%
    if (session.getAttribute("rol") == null || !session.getAttribute("rol").equals("vecino")) {
        response.sendRedirect("login.jsp");
        return;
    }
    int usuarioId = (int) session.getAttribute("usuario_id");
%>

@WebServlet("/AgregarReporteServlet")
@MultipartConfig

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Panel del Vecino - INFRA REPORT</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8fafc;
            font-family: 'Segoe UI', sans-serif;
        }
        .bg-primary-custom {
            background: linear-gradient(135deg, #1e3a8a, #3b82f6);
        }
        .navbar-brand { font-weight: bold; letter-spacing: 1px; }
        .card {
            border-radius: 14px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }
        .list-group-item {
            transition: all 0.3s;
            border: none;
            border-bottom: 1px solid #e5e7eb;
        }
        .list-group-item:hover { background-color: #f3f4f6; }
        .list-group-item.active {
            background-color: #1e3a8a;
            color: #fff;
            font-weight: 600;
        }
        .content-section { display: none; animation: fadeIn 0.4s ease; }
        .content-section.active { display: block; }
        @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
        .image-preview {
            max-width: 200px; border-radius: 10px; margin-top: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.15);
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary-custom">
    <div class="container-fluid">
        <a class="navbar-brand" href="#"><i class="bi bi-shield-lock"></i> INFRA REPORT</a>
        <div class="navbar-nav ms-auto">
            <span class="navbar-text me-3"><i class="bi bi-person"></i> <%= session.getAttribute("username") %></span>
            <a href="LogoutServlet" class="btn btn-outline-light btn-sm"><i class="bi bi-box-arrow-right"></i> Salir</a>
        </div>
    </div>
</nav>

<div class="container-fluid mt-4">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-3">
            <div class="card">
                <div class="card-header bg-primary-custom text-white">
                    <h5 class="mb-0"><i class="bi bi-menu-button-wide"></i> Panel Vecino</h5>
                </div>
                <div class="list-group list-group-flush">
                    <a href="#" class="list-group-item list-group-item-action active" onclick="showSection('nuevo-reporte', this)">
                        <i class="bi bi-plus-circle"></i> Nuevo Reporte
                    </a>
                    <a href="#" class="list-group-item list-group-item-action" onclick="showSection('mis-reportes', this)">
                        <i class="bi bi-list-task"></i> Mis Reportes
                    </a>
                </div>
            </div>
        </div>

        <!-- Main content -->
        <div class="col-md-9">
            
            <!-- NUEVO REPORTE -->
            <div id="nuevo-reporte" class="content-section active">
                <div class="card mb-4">
                    <div class="card-header bg-primary-custom text-white">
                        <h5 class="mb-0"><i class="bi bi-pencil-square"></i> Registrar Nuevo Reporte</h5>
                    </div>
                    <div class="card-body">
                        <form action="AgregarReporteServlet" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="usuario_id" value="<%= usuarioId %>">
                            <input type="hidden" name="nombre_reportante" value="<%= session.getAttribute("username") %>">
                            <input type="hidden" name="telefono" value="000000000">

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Categoría *</label>
                                    <select class="form-select" name="categoria" required>
                                        <option value="">Seleccionar categoría</option>
                                        <option value="Alumbrado Público">Alumbrado Público</option>
                                        <option value="Pistas y Veredas">Pistas y Veredas</option>
                                        <option value="Alcantarillado">Alcantarillado</option>
                                        <option value="Poste Eléctrico">Poste Eléctrico</option>
                                        <option value="Áreas Verdes">Áreas Verdes</option>
                                        <option value="Señalización">Señalización</option>
                                        <option value="Otro">Otro</option>
                                    </select>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Lugar *</label>
                                    <input type="text" name="lugar" class="form-control" placeholder="Ej. Av. Principal 123" required>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Descripción *</label>
                                <textarea name="descripcion" class="form-control" rows="4" placeholder="Describe el problema..." required></textarea>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Foto de la Incidencia</label>
                                <input type="file" class="form-control" name="foto" accept="image/*" onchange="previewImage(this)">
                                <div id="imagePreview"></div>
                            </div>

                            <div class="form-check mb-3">
                                <input type="checkbox" class="form-check-input" id="urgente" name="urgente">
                                <label class="form-check-label" for="urgente">Marcar como urgente</label>
                            </div>

                            <button type="submit" class="btn btn-success">
                                <i class="bi bi-send"></i> Enviar Reporte
                            </button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- MIS REPORTES -->
            <div id="mis-reportes" class="content-section">
                <div class="card">
                    <div class="card-header bg-primary-custom text-white">
                        <h5 class="mb-0"><i class="bi bi-list-ul"></i> Mis Reportes</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead class="table-primary">
                                    <tr>
                                        <th>ID</th>
                                        <th>Categoría</th>
                                        <th>Lugar</th>
                                        <th>Estado</th>
                                        <th>Fecha</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        try (Connection conn = Conexion.getConnection()) {
                                            PreparedStatement ps = conn.prepareStatement(
                                                "SELECT * FROM reportes WHERE usuario_id=? ORDER BY fecha_reporte DESC"
                                            );
                                            ps.setInt(1, usuarioId);
                                            ResultSet rs = ps.executeQuery();
                                            while (rs.next()) {
                                    %>
                                        <tr>
                                            <td><%= rs.getInt("id") %></td>
                                            <td><%= rs.getString("categoria") %></td>
                                            <td><%= rs.getString("lugar") %></td>
                                            <td>
                                                <span class="badge bg-<%= rs.getString("estado").equals("pendiente") ? "warning" : rs.getString("estado").equals("en_proceso") ? "info" : "success" %>">
                                                    <%= rs.getString("estado") %>
                                                </span>
                                            </td>
                                            <td><%= rs.getTimestamp("fecha_reporte") %></td>
                                            <td>
    <a href="sereno/editarReporte.jsp?id=<%= rs.getInt("id") %>" 
       class="btn btn-sm btn-outline-warning">
        <i class="bi bi-pencil"></i> Editar
    </a>
       <a href="EliminarReporteServlet?id=<%= rs.getInt("id") %>" 
       class="btn btn-sm btn-outline-danger"
       onclick="return confirm('¿Seguro que deseas eliminar este reporte?');">
        <i class="bi bi-trash"></i> Eliminar
    </a>
</td>
                                        </tr>
                                    <%
                                            }
                                        } catch (Exception e) {
                                            out.println("<tr><td colspan='5' class='text-danger'>Error al mostrar reportes.</td></tr>");
                                            e.printStackTrace();
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<script>
function showSection(sectionId, element) {
    document.querySelectorAll('.content-section').forEach(sec => sec.classList.remove('active'));
    document.getElementById(sectionId).classList.add('active');
    document.querySelectorAll('.list-group-item').forEach(li => li.classList.remove('active'));
    element.classList.add('active');
}

function previewImage(input) {
    const preview = document.getElementById('imagePreview');
    preview.innerHTML = '';
    if (input.files && input.files[0]) {
        const reader = new FileReader();
        reader.onload = e => {
            const img = document.createElement('img');
            img.src = e.target.result;
            img.className = 'image-preview';
            preview.appendChild(img);
        };
        reader.readAsDataURL(input.files[0]);
    }
}
</script>

</body>
</html>
