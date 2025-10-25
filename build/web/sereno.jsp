<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="jakarta.servlet.http.HttpSession"%>
<%
    // Verificar sesión
    if (session.getAttribute("userRole") == null || !session.getAttribute("userRole").equals("sereno")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel Sereno - INFRA REPORT</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        /* ===== VARIABLES CSS ===== */
        :root {
            --primary-color: #1e3a8a;
            --secondary-color: #374151;
            --accent-color: #059669;
            --warning-color: #d97706;
            --light-bg: #f8fafc;
            --dark-text: #1f2937;
            --gradient-primary: linear-gradient(135deg, #1e3a8a 0%, #3b82f6 100%);
            --shadow-sm: 0 2px 4px rgba(0,0,0,0.1);
            --shadow-md: 0 4px 12px rgba(0,0,0,0.15);
            --border-radius: 12px;
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        /* ===== GLOBAL STYLES ===== */
        body {
            background-color: var(--light-bg);
            color: var(--dark-text);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
        }

        /* ===== NAVBAR ===== */
        .bg-primary-custom {
            background: var(--gradient-primary) !important;
            box-shadow: var(--shadow-md);
        }

        .navbar-brand {
            font-size: 1.5rem;
            letter-spacing: 0.5px;
            font-weight: 700;
            text-shadow: 0 2px 4px rgba(0,0,0,0.3);
        }

        /* ===== CARDS ===== */
        .card {
            border: none;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-sm);
            transition: var(--transition);
            background: white;
        }

        .card:hover {
            box-shadow: var(--shadow-md);
            transform: translateY(-2px);
        }

        /* ===== SIDEBAR ===== */
        .list-group-item {
            border: none;
            border-bottom: 1px solid #e5e7eb;
            padding: 1rem 1.25rem;
            transition: var(--transition);
            position: relative;
        }

        .list-group-item::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 4px;
            background: var(--gradient-primary);
            transform: scaleY(0);
            transition: var(--transition);
        }

        .list-group-item:hover {
            background-color: #f1f5f9;
            padding-left: 1.5rem;
            transform: translateX(3px);
        }

        .list-group-item:hover::before {
            transform: scaleY(1);
        }

        .list-group-item.active {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            background: var(--gradient-primary);
            color: white;
            font-weight: 600;
        }

        .list-group-item.active::before {
            transform: scaleY(1);
        }

        /* ===== FORMS ===== */
        .form-control, .form-select {
            border-radius: var(--border-radius);
            border: 2px solid #e5e7eb;
            padding: 0.7rem 1rem;
            transition: var(--transition);
            font-weight: 500;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(30, 58, 138, 0.25);
            transform: translateY(-1px);
        }

        /* ===== BUTTONS ===== */
        .btn {
            border-radius: var(--border-radius);
            font-weight: 500;
            padding: 0.6rem 1.2rem;
            transition: var(--transition);
            border: none;
            position: relative;
            overflow: hidden;
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: var(--transition);
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .btn:hover::before {
            left: 100%;
        }

        .btn-success {
            background-color: var(--accent-color);
            border-color: var(--accent-color);
            background: linear-gradient(135deg, var(--accent-color), #10b981);
        }

        /* ===== BADGES ===== */
        .badge-pendiente {
            background-color: #fbbf24;
            color: #78350f;
            font-weight: 600;
            padding: 0.5rem 0.8rem;
            border-radius: 20px;
        }

        .badge-validado {
            background-color: #60a5fa;
            color: #1e3a8a;
            font-weight: 600;
            padding: 0.5rem 0.8rem;
            border-radius: 20px;
        }

        .badge-proceso {
            background-color: #34d399;
            color: #064e3b;
            font-weight: 600;
            padding: 0.5rem 0.8rem;
            border-radius: 20px;
        }

        .badge-cerrado {
            background-color: #6b7280;
            color: #ffffff;
            font-weight: 600;
            padding: 0.5rem 0.8rem;
            border-radius: 20px;
        }

        /* ===== TABLES ===== */
        .table th {
            background: var(--gradient-primary);
            color: white;
            font-weight: 600;
            border: none;
            padding: 1rem;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 0.5px;
        }

        .table td {
            padding: 1rem;
            vertical-align: middle;
            border-bottom: 1px solid #e5e7eb;
            font-weight: 500;
        }

        .table tbody tr {
            transition: var(--transition);
        }

        .table tbody tr:hover {
            background-color: #f8fafc;
            transform: scale(1.01);
        }

        /* ===== CONTENT SECTIONS ===== */
        .content-section {
            display: none;
            animation: fadeInUp 0.5s ease-out;
        }

        .content-section.active {
            display: block;
        }

        /* ===== IMAGE PREVIEW ===== */
        .image-preview {
            max-width: 200px;
            max-height: 200px;
            border-radius: var(--border-radius);
            margin-top: 10px;
            box-shadow: var(--shadow-sm);
            transition: var(--transition);
        }

        .image-preview:hover {
            transform: scale(1.05);
            box-shadow: var(--shadow-md);
        }

        /* ===== CARD HEADERS ===== */
        .card-header {
            background: var(--gradient-primary);
            color: white;
            border: none;
            font-weight: 600;
            padding: 1rem 1.5rem;
        }

        .card-header h4, .card-header h5 {
            margin: 0;
            text-shadow: 0 1px 2px rgba(0,0,0,0.2);
        }

        /* ===== ANIMATIONS ===== */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* ===== RESPONSIVE ===== */
        @media (max-width: 768px) {
            .container-fluid {
                padding: 0.5rem;
            }
            
            .card-body {
                padding: 1rem;
            }
            
            .table-responsive {
                font-size: 0.9rem;
            }
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
                    <i class="bi bi-person-badge"></i> Sereno Municipal
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
                        <h5><i class="bi bi-speedometer2"></i> Panel de Control</h5>
                    </div>
                    <div class="list-group list-group-flush">
                        <a href="#" class="list-group-item list-group-item-action active" onclick="showSection('nuevo-reporte', this)">
                            <i class="bi bi-plus-circle"></i> Nuevo Reporte
                        </a>
                        <a href="#" class="list-group-item list-group-item-action" onclick="showSection('mis-reportes', this)">
                            <i class="bi bi-list-ul"></i> Mis Reportes
                        </a>
                    </div>
                </div>
            </div>

            <!-- Main Content -->
            <div class="col-md-9">
                <!-- Nuevo Reporte Section -->
                <div id="nuevo-reporte" class="content-section active">
                    <div class="card">
                        <div class="card-header">
                            <h4><i class="bi bi-plus-circle"></i> Crear Nuevo Reporte</h4>
                        </div>
                        <div class="card-body">
                            <form action="ReportServlet" method="post" enctype="multipart/form-data">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="categoria" class="form-label">Categoría *</label>
                                            <select class="form-select" id="categoria" name="categoria" required>
                                                <option value="">Seleccionar categoría</option>
                                                <option value="alumbrado">Alumbrado Público</option>
                                                <option value="pista">Pistas y Veredas</option>
                                                <option value="alcantarillado">Alcantarillado</option>
                                                <option value="poste">Poste Eléctrico</option>
                                                <option value="areas-verdes">Áreas Verdes</option>
                                                <option value="señalizacion">Señalización</option>
                                                <option value="otro">Otro</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="lugar" class="form-label">Lugar *</label>
                                            <input type="text" class="form-control" id="lugar" name="lugar" placeholder="Dirección o referencia" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label for="descripcion" class="form-label">Descripción *</label>
                                    <textarea class="form-control" id="descripcion" name="descripcion" rows="4" placeholder="Descripción detallada del problema" required></textarea>
                                </div>
                                <div class="mb-3">
                                    <label for="foto" class="form-label">Foto de la Incidencia</label>
                                    <input type="file" class="form-control" id="foto" name="foto" accept="image/*" onchange="previewImage(this)">
                                    <div id="imagePreview"></div>
                                </div>
                                <div class="mb-3">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="urgente" name="urgente">
                                        <label class="form-check-label" for="urgente">
                                            Marcar como urgente
                                        </label>
                                    </div>
                                </div>
                                <button type="submit" class="btn btn-success btn-lg">
                                    <i class="bi bi-send"></i> Enviar Reporte
                                </button>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Mis Reportes Section -->
                <div id="mis-reportes" class="content-section">
                    <div class="card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h4><i class="bi bi-list-ul"></i> Mis Reportes</h4>
                            <span class="badge bg-info">3 reportes</span>
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
                                            <th>Acciones</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td><strong>RPT-250120-001</strong></td>
                                            <td>Alumbrado Público</td>
                                            <td>Av. Principal 123</td>
                                            <td><span class="badge badge-proceso">En Proceso</span></td>
                                            <td>20 Ene 2025</td>
                                            <td>
                                                <button class="btn btn-outline-primary btn-sm" data-bs-toggle="modal" data-bs-target="#detalleModal">
                                                    <i class="bi bi-eye"></i> Ver
                                                </button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><strong>RPT-250119-002</strong></td>
                                            <td>Pistas y Veredas</td>
                                            <td>Calle Los Olivos 456</td>
                                            <td><span class="badge badge-validado">Validado</span></td>
                                            <td>19 Ene 2025</td>
                                            <td>
                                                <button class="btn btn-outline-primary btn-sm" data-bs-toggle="modal" data-bs-target="#detalleModal">
                                                    <i class="bi bi-eye"></i> Ver
                                                </button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><strong>RPT-250118-003</strong></td>
                                            <td>Alcantarillado</td>
                                            <td>Jr. Las Flores 789</td>
                                            <td><span class="badge badge-cerrado">Cerrado</span></td>
                                            <td>18 Ene 2025</td>
                                            <td>
                                                <button class="btn btn-outline-success btn-sm" data-bs-toggle="modal" data-bs-target="#detalleModal">
                                                    <i class="bi bi-check-circle"></i> Completado
                                                </button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Detalle Reporte -->
    <div class="modal fade" id="detalleModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Detalle del Reporte</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-8">
                            <h5>Información del Reporte</h5>
                            <table class="table table-borderless">
                                <tr><td><strong>ID:</strong></td><td>RPT-250120-001</td></tr>
                                <tr><td><strong>Categoría:</strong></td><td>Alumbrado Público</td></tr>
                                <tr><td><strong>Lugar:</strong></td><td>Av. Principal 123</td></tr>
                                <tr><td><strong>Estado:</strong></td><td><span class="badge badge-proceso">En Proceso</span></td></tr>
                                <tr><td><strong>Fecha:</strong></td><td>20 Ene 2025</td></tr>
                                <tr><td><strong>Urgente:</strong></td><td>No</td></tr>
                            </table>
                            <h6>Descripción:</h6>
                            <p class="bg-light p-3 rounded">Poste de alumbrado público dañado en la Av. Principal, no funciona correctamente durante las noches, representa un riesgo para los peatones.</p>
                            <h6>Acción de Mantenimiento:</h6>
                            <p class="bg-success bg-opacity-10 p-3 rounded text-success">Reparación de poste eléctrico programada para mañana</p>
                        </div>
                        <div class="col-md-4">
                            <h6>Imagen del Reporte:</h6>
                            <img src="https://images.pexels.com/photos/2219024/pexels-photo-2219024.jpeg" class="img-fluid rounded" alt="Imagen del reporte">
                        </div>
                    </div>
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

        function previewImage(input) {
            const preview = document.getElementById('imagePreview');
            preview.innerHTML = '';
            
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
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