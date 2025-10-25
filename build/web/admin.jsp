<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="jakarta.servlet.http.HttpSession"%>
<%@ page import="java.sql.*, utils.Conexion" %>
<%
    // Verificar sesión (usa el mismo nombre que en el servlet)
    if (session.getAttribute("rol") == null || !session.getAttribute("rol").equals("admin")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel Administrador - INFRA REPORT</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #1e3a8a;
            --secondary-color: #374151;
            --accent-color: #059669;
            --warning-color: #d97706;
            --danger-color: #dc2626;
            --light-bg: #f8fafc;
            --dark-text: #1f2937;
        }

        body {
            background-color: var(--light-bg);
            color: var(--dark-text);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .bg-primary-custom {
            background-color: var(--primary-color) !important;
        }

        .navbar-brand {
            font-size: 1.5rem;
            letter-spacing: 0.5px;
        }

        .card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .list-group-item {
            border: none;
            border-bottom: 1px solid #e5e7eb;
            padding: 1rem 1.25rem;
            transition: all 0.3s ease;
        }

        .list-group-item:hover {
            background-color: #f1f5f9;
            padding-left: 1.5rem;
        }

        .list-group-item.active {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .badge-pendiente {
            background-color: #fbbf24;
            color: #78350f;
        }

        .badge-validado {
            background-color: #60a5fa;
            color: #1e3a8a;
        }

        .badge-proceso {
            background-color: #34d399;
            color: #064e3b;
        }

        .badge-cerrado {
            background-color: #6b7280;
            color: #ffffff;
        }

        .table th {
            background-color: var(--primary-color);
            color: white;
            font-weight: 600;
            border: none;
            padding: 1rem;
        }

        .table td {
            padding: 1rem;
            vertical-align: middle;
            border-bottom: 1px solid #e5e7eb;
        }

        .btn {
            border-radius: 8px;
            font-weight: 500;
            padding: 0.6rem 1.2rem;
            transition: all 0.3s ease;
        }

        .btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        .stats-card {
            border: none;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            border-radius: 12px;
        }

        .stats-card.bg-primary {
            background: linear-gradient(135deg, var(--primary-color), #3b82f6) !important;
        }

        .stats-card.bg-warning {
            background: linear-gradient(135deg, var(--warning-color), #f59e0b) !important;
        }

        .stats-card.bg-info {
            background: linear-gradient(135deg, #0891b2, #06b6d4) !important;
        }

        .stats-card.bg-success {
            background: linear-gradient(135deg, var(--accent-color), #10b981) !important;
        }

        .content-section {
            display: none;
        }

        .content-section.active {
            display: block;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary-custom">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold" href="index.jsp">
                <i class="bi bi-building"></i> INFRA REPORT
            </a>
            <div class="navbar-nav ms-auto">
                <span class="navbar-text me-3">
                    <i class="bi bi-person-gear"></i> Administrador
                </span>
                <a href="LogoutServlet" class="btn btn-outline-light btn-sm">
                    <i class="bi bi-box-arrow-right"></i> Salir
                </a>
            </div>
        </div>
    </nav>

    <div class="container-fluid mt-4">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3">
                <div class="card">
                    <div class="card-header bg-primary-custom text-white">
                        <h5><i class="bi bi-speedometer2"></i> Panel Administrativo</h5>
                    </div>
                    <div class="list-group list-group-flush">
                        <a href="#" class="list-group-item list-group-item-action active" onclick="showSection('dashboard', this)">
                            <i class="bi bi-graph-up"></i> Dashboard
                        </a>
                        <a href="#" class="list-group-item list-group-item-action" onclick="showSection('todos-reportes', this)">
                            <i class="bi bi-clipboard-data"></i> Todos los Reportes
                        </a>
                        <a href="#" class="list-group-item list-group-item-action" onclick="showSection('reportes-atendidos', this)">
                            <i class="bi bi-check-circle"></i> Reportes Atendidos
                        </a>
                            <a href="admin/usuarios.jsp" class="list-group-item list-group-item-action">
                               <i class="bi bi-person-plus"></i> Gestionar Usuarios
                          </a>

                    </div>
                </div>
            </div>

            <!-- Main Content -->
            <div class="col-md-9">
                <!-- Dashboard Section -->
                <div id="dashboard" class="content-section active">
                    <!-- Stats Cards -->
                    <div class="row mb-4">
                        <div class="col-md-3">
                            <div class="card stats-card bg-primary text-white">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <h4>24</h4>
                                            <p class="mb-0">Total Reportes</p>
                                        </div>
                                        <div class="align-self-center">
                                            <i class="bi bi-clipboard-data fs-1"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card stats-card bg-warning text-white">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <h4>8</h4>
                                            <p class="mb-0">Pendientes</p>
                                        </div>
                                        <div class="align-self-center">
                                            <i class="bi bi-clock-history fs-1"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card stats-card bg-info text-white">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <h4>6</h4>
                                            <p class="mb-0">En Proceso</p>
                                        </div>
                                        <div class="align-self-center">
                                            <i class="bi bi-arrow-clockwise fs-1"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card stats-card bg-success text-white">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <h4>10</h4>
                                            <p class="mb-0">Cerrados</p>
                                        </div>
                                        <div class="align-self-center">
                                            <i class="bi bi-check-circle fs-1"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Recent Reports -->
                    <div class="card">
                        <div class="card-header">
                            <h5>Reportes Recientes</h5>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Categoría</th>
                                            <th>Lugar</th>
                                            <th>Estado</th>
                                            <th>Fecha</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td><strong>RPT-250120-001</strong></td>
                                            <td>Alumbrado Público</td>
                                            <td>Av. Principal 123</td>
                                            <td><span class="badge badge-proceso">En Proceso</span></td>
                                            <td>20 Ene 2025</td>
                                        </tr>
                                        <tr>
                                            <td><strong>VEC-250120-002</strong></td>
                                            <td>Pistas y Veredas</td>
                                            <td>Calle Los Olivos 456</td>
                                            <td><span class="badge badge-pendiente">Pendiente</span></td>
                                            <td>20 Ene 2025</td>
                                        </tr>
                                        <tr>
                                            <td><strong>RPT-250119-003</strong></td>
                                            <td>Alcantarillado</td>
                                            <td>Jr. Las Flores 789</td>
                                            <td><span class="badge badge-cerrado">Cerrado</span></td>
                                            <td>19 Ene 2025</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="todos-reportes" class="content-section">
    <div class="card">
        <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
            <h4 class="mb-0"><i class="bi bi-clipboard-data"></i> Gestión de Reportes</h4>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="table-primary">
                        <tr>
                            <th>ID</th>
                            <th>Usuario ID</th>
                            <th>Categoría</th>
                            <th>Lugar</th>
                            <th>Urgente</th>
                            <th>Estado</th>
                            <th>Fecha</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try (Connection conn = Conexion.getConnection();
                                 Statement stmt = conn.createStatement();
                                 ResultSet rs = stmt.executeQuery("SELECT * FROM reportes ORDER BY fecha_reporte DESC")) {

                                boolean tieneDatos = false;
                                while (rs.next()) {
                                    tieneDatos = true;
                        %>
                        <tr>
                            <td><%= rs.getInt("id") %></td>
                            <td><%= rs.getInt("usuario_id") %></td>
                            <td><%= rs.getString("categoria") %></td>
                            <td><%= rs.getString("lugar") %></td>
                            <td>
                                <% if (rs.getBoolean("urgente")) { %>
                                    <span class="badge bg-danger">Sí</span>
                                <% } else { %>
                                    <span class="badge bg-secondary">No</span>
                                <% } %>
                            </td>
                            <td>
                                <span class="badge 
                                    <%= rs.getString("estado").equals("pendiente") ? "bg-warning" :
                                        rs.getString("estado").equals("en_proceso") ? "bg-info" :
                                        "bg-success" %>">
                                    <%= rs.getString("estado") %>
                                </span>
                            </td>
                            <td><%= rs.getTimestamp("fecha_reporte") %></td>
                            <td>
                                <a href="admin/editarReporte.jsp?id=<%= rs.getInt("id") %>" 
                                   class="btn btn-sm btn-outline-primary">
                                    <i class="bi bi-pencil"></i> Editar
                                </a>
                                <a href="EliminarReporteServlet?id=<%= rs.getInt("id") %>"
                                   class="btn btn-sm btn-outline-danger"
                                   onclick="return confirm('¿Seguro que deseas eliminar este reporte?');">
                                    <i class="bi bi-trash"></i>
                                </a>
                            </td>
                        </tr>
                        <%
                                }
                                if (!tieneDatos) {
                        %>
                        <tr>
                            <td colspan="8" class="text-center text-muted">No hay reportes registrados aún.</td>
                        </tr>
                        <%
                                }
                            } catch (Exception e) {
                                out.println("<tr><td colspan='8' class='text-center text-danger'>Error: " + e.getMessage() + "</td></tr>");
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

                <!-- Reportes Atendidos Section -->
                <div id="reportes-atendidos" class="content-section">
                    <div class="card">
                        <div class="card-header">
                            <h4><i class="bi bi-check-circle"></i> Reportes Atendidos</h4>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6 col-lg-4 mb-4">
                                    <div class="card h-100">
                                        <div class="row g-0">
                                            <div class="col-6">
                                                <img src="https://cde.canaln.pe/actualidad-sjl-poste-punto-caer-pone-riesgo-conductores-y-peatones-n321864-696x418-468116.jpg?v=1" class="card-img-top" alt="Noticia">
                                                <small class="text-muted d-block text-center p-1">Antes</small>
                                            </div>
                                            <div class="col-6">
                                                <img src="https://img.freepik.com/foto-gratis/enfoque-selectivo-electricistas-es-arreglar-linea-transmision-energia-poste-electrico_1150-6115.jpg?v=1" class="card-img-top" alt="Noticia">
                                                <small class="text-success d-block text-center p-1">Después</small>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <h6 class="card-title">RPT-001 - Alumbrado Público</h6>
                                            <p class="card-text small"><i class="bi bi-geo-alt"></i> Av. Principal 123</p>
                                            <p class="card-text small"><i class="bi bi-person"></i> Sereno Municipal</p>
                                            <p class="card-text small text-muted">
                                                <i class="bi bi-calendar"></i> Resuelto: 18 Ene 2025
                                            </p>
                                            <small class="text-info"><strong>Acción:</strong> Reparación de poste eléctrico</small>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 col-lg-4 mb-4">
                                    <div class="card h-100">
                                        <div class="row g-0">
                                            <div class="col-6">
                                               <img src="https://www.defensoria.gob.pe/wp-content/uploads/2022/09/Tarapoto-1-9-22.png?v=1" class="card-img-top" alt="Noticia">

                                                <small class="text-muted d-block text-center p-1">Antes</small>
                                            </div>
                                            <div class="col-6">
                                                <img src="https://munisanmiguel.gob.pe/wp-content/uploads/2021/09/LIMA-01.jpg?v=1" class="card-img-top" alt="Noticia">
                                                <small class="text-success d-block text-center p-1">Después</small>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <h6 class="card-title">VEC-002 - Pistas y Veredas</h6>
                                            <p class="card-text small"><i class="bi bi-geo-alt"></i> Calle Los Olivos 456</p>
                                            <p class="card-text small"><i class="bi bi-person"></i> Vecino Municipal</p>
                                            <p class="card-text small text-muted">
                                                <i class="bi bi-calendar"></i> Resuelto: 17 Ene 2025
                                            </p>
                                            <small class="text-info"><strong>Acción:</strong> Reparación de pavimento</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Gestionar Reporte -->
    <div class="modal fade" id="gestionModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Gestionar Reporte</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <h5>Información del Reporte</h5>
                            <table class="table table-borderless table-sm">
                                <tr><td><strong>ID:</strong></td><td>RPT-250120-001</td></tr>
                                <tr><td><strong>Categoría:</strong></td><td>Alumbrado Público</td></tr>
                                <tr><td><strong>Lugar:</strong></td><td>Av. Principal 123</td></tr>
                                <tr><td><strong>Reportado por:</strong></td><td>Sereno Municipal</td></tr>
                                <tr><td><strong>Fecha:</strong></td><td>20 Ene 2025</td></tr>
                                <tr><td><strong>Urgente:</strong></td><td>No</td></tr>
                            </table>
                            <h6>Descripción:</h6>
                            <p class="bg-light p-2 rounded small">Poste de alumbrado público dañado, no funciona correctamente durante las noches.</p>
                        </div>
                        <div class="col-md-6">
                            <h5>Gestión del Reporte</h5>
                            <form>
                                <div class="mb-3">
                                    <label for="status" class="form-label">Estado</label>
                                    <select class="form-select" id="status">
                                        <option value="pendiente">Pendiente</option>
                                        <option value="validado">Validado</option>
                                        <option value="proceso" selected>En Proceso</option>
                                        <option value="cerrado">Cerrado</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="action" class="form-label">Acción de Mantenimiento</label>
                                    <input type="text" class="form-control" id="action" value="Reparación de poste eléctrico">
                                </div>
                                <div class="mb-3">
                                    <label for="assignee" class="form-label">Asignar a</label>
                                    <input type="text" class="form-control" id="assignee" value="Cuadrilla Eléctrica A">
                                </div>
                                <div class="mb-3">
                                    <label for="afterImage" class="form-label">Foto Después</label>
                                    <input type="file" class="form-control" id="afterImage" accept="image/*">
                                </div>
                                <div class="mb-3">
                                    <label for="notes" class="form-label">Notas</label>
                                    <textarea class="form-control" id="notes" rows="3">Trabajo programado para mañana</textarea>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-success" data-bs-dismiss="modal">Actualizar Reporte</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function showSection(sectionId, element) {
            // Hide all sections
            document.querySelectorAll('.content-section').forEach(section => {
                section.classList.remove('active');
            });
            
            // Show selected section
            document.getElementById(sectionId).classList.add('active');
            
            // Update active menu item
            document.querySelectorAll('.list-group-item').forEach(item => {
                item.classList.remove('active');
            });
            element.classList.add('active');
        }
    </script>
</body>
</html>