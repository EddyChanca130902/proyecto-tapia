<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="jakarta.servlet.http.HttpSession"%>
<%
    // Verificar sesión
    if (session.getAttribute("userRole") == null || !session.getAttribute("userRole").equals("vecino")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel Vecino - INFRA REPORT</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #1e3a8a;
            --secondary-color: #374151;
            --accent-color: #059669;
            --vecino-color: #7c3aed;
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

        .card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }

        .card-img-top {
            border-radius: 12px 12px 0 0;
            height: 200px;
            object-fit: cover;
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

        .form-control, .form-select {
            border-radius: 8px;
            border: 2px solid #e5e7eb;
            padding: 0.7rem 1rem;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(30, 58, 138, 0.25);
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

        .btn-success {
            background-color: var(--accent-color);
            border-color: var(--accent-color);
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

        .badge-vecino {
            background-color: var(--vecino-color);
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

        .content-section {
            display: none;
        }

        .content-section.active {
            display: block;
        }

        .image-preview {
            max-width: 200px;
            max-height: 200px;
            border-radius: 8px;
            margin-top: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .urgent-indicator {
            color: #dc2626;
            font-weight: bold;
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
                    <i class="bi bi-person-circle"></i> Vecino Municipal
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
                        <h5><i class="bi bi-speedometer2"></i> Panel Ciudadano</h5>
                    </div>
                    <div class="list-group list-group-flush">
                        <a href="#" class="list-group-item list-group-item-action active" onclick="showSection('nuevo-reporte', this)">
                            <i class="bi bi-plus-circle"></i> Reportar Incidencia
                        </a>
                        <a href="#" class="list-group-item list-group-item-action" onclick="showSection('mis-reportes', this)">
                            <i class="bi bi-list-ul"></i> Mis Reportes
                        </a>
                        <a href="#" class="list-group-item list-group-item-action" onclick="showSection('reportes-publicos', this)">
                            <i class="bi bi-eye"></i> Reportes Públicos
                        </a>
                        <a href="#" class="list-group-item list-group-item-action" onclick="showSection('noticias', this)">
                            <i class="bi bi-newspaper"></i> Noticias
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
                            <h4><i class="bi bi-plus-circle"></i> Reportar Nueva Incidencia</h4>
                            <small class="text-muted">Como vecino municipal, puedes reportar problemas de infraestructura en tu comunidad</small>
                        </div>
                        <div class="card-body">
                            <form action="VecinoReportServlet" method="post" enctype="multipart/form-data">
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
                                                <option value="basura">Recolección de Basura</option>
                                                <option value="agua">Servicio de Agua</option>
                                                <option value="otro">Otro</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="lugar" class="form-label">Lugar *</label>
                                            <input type="text" class="form-control" id="lugar" name="lugar" placeholder="Dirección exacta o referencia" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="nombre" class="form-label">Nombre Completo *</label>
                                            <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Su nombre completo" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="telefono" class="form-label">Teléfono de Contacto</label>
                                            <input type="tel" class="form-control" id="telefono" name="telefono" placeholder="Número de contacto">
                                        </div>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label for="descripcion" class="form-label">Descripción Detallada *</label>
                                    <textarea class="form-control" id="descripcion" name="descripcion" rows="4" placeholder="Describa el problema con el mayor detalle posible" required></textarea>
                                </div>
                                <div class="mb-3">
                                    <label for="foto" class="form-label">Foto de la Incidencia</label>
                                    <input type="file" class="form-control" id="foto" name="foto" accept="image/*" onchange="previewImage(this)">
                                    <small class="text-muted">Adjunte una foto que muestre claramente el problema</small>
                                    <div id="imagePreview"></div>
                                </div>
                                <div class="mb-3">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="urgente" name="urgente">
                                        <label class="form-check-label" for="urgente">
                                            Considero que es urgente (riesgo para la seguridad)
                                        </label>
                                    </div>
                                </div>
                                <div class="alert alert-info">
                                    <i class="bi bi-info-circle"></i>
                                    <strong>Importante:</strong> Su reporte será revisado por el personal municipal y recibirá seguimiento según la prioridad del caso.
                                </div>
                                <button type="submit" class="btn btn-success btn-lg">
                                    <i class="bi bi-send"></i> Enviar Reporte Ciudadano
                                </button>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Mis Reportes Section -->
                <div id="mis-reportes" class="content-section">
                    <div class="card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h4><i class="bi bi-list-ul"></i> Mis Reportes Ciudadanos</h4>
                            <span class="badge bg-info">2 reportes</span>
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
                                        <tr class="table-warning">
                                            <td>
                                                <strong>VEC-250120-001</strong>
                                                <br><small class="urgent-indicator">⚠️ URGENTE</small>
                                            </td>
                                            <td>Pistas y Veredas</td>
                                            <td>Calle Los Olivos 456</td>
                                            <td><span class="badge badge-pendiente">Pendiente</span></td>
                                            <td>20 Ene 2025</td>
                                            <td>
                                                <button class="btn btn-outline-primary btn-sm" data-bs-toggle="modal" data-bs-target="#detalleModal">
                                                    <i class="bi bi-eye"></i> Ver
                                                </button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><strong>VEC-250119-002</strong></td>
                                            <td>Recolección de Basura</td>
                                            <td>Jr. Las Flores 789</td>
                                            <td><span class="badge badge-validado">Validado</span></td>
                                            <td>19 Ene 2025</td>
                                            <td>
                                                <button class="btn btn-outline-primary btn-sm" data-bs-toggle="modal" data-bs-target="#detalleModal">
                                                    <i class="bi bi-eye"></i> Ver
                                                </button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Reportes Públicos Section -->
                <div id="reportes-publicos" class="content-section">
                    <div class="card">
                        <div class="card-header">
                            <h4><i class="bi bi-eye"></i> Reportes Atendidos de la Comunidad</h4>
                            <small class="text-muted">Vea los problemas que han sido resueltos en su municipio</small>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6 col-lg-4 mb-4">
                                    <div class="card h-100">
                                        <div class="row g-0">
                                            <div class="col-6">
                                                <img src="https://erotafono.radio-grpp.io/2022/11/16/alumbrado-2_615374.jpg?v=1" class="card-img-top" alt="Noticia">
                                                <small class="text-muted d-block text-center p-1">Antes</small>
                                            </div>
                                            <div class="col-6">
                                                <img src="https://www.wesler.com.pe/wp-content/uploads/2025/02/4.8-edificacion-2.jpg?v=1" class="card-img-top" alt="Noticia">
                                                <small class="text-success d-block text-center p-1">Después</small>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <h6 class="card-title">Alumbrado Público</h6>
                                            <p class="card-text small"><i class="bi bi-geo-alt"></i> Av. Principal 123</p>
                                            <p class="card-text small"><i class="bi bi-person"></i> Reportado por: Sereno Municipal</p>
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
                                                <img src="https://jornada.com.pe/wp-content/uploads/2024/08/Elecciones-2022-5.png?v=1" class="card-img-top" alt="Noticia">
                                                <small class="text-muted d-block text-center p-1">Antes</small>
                                            </div>
                                            <div class="col-6">
                                                <img src="https://www.ventadeasfalto-rc-250.com.pe/data1/reparacion/servicio-mantenimiento-pistas.jpg?v=1" class="card-img-top" alt="Noticia">
                                                <small class="text-success d-block text-center p-1">Después</small>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <h6 class="card-title">Pistas y Veredas</h6>
                                            <p class="card-text small"><i class="bi bi-geo-alt"></i> Calle Los Olivos 456</p>
                                            <p class="card-text small"><i class="bi bi-person"></i> Reportado por: Vecino Municipal</p>
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

                <!-- Noticias Section -->
                <div id="noticias" class="content-section">
                    <div class="card">
                        <div class="card-header">
                            <h4><i class="bi bi-newspaper"></i> Noticias Municipales</h4>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6 col-lg-4 mb-4">
                                    <div class="card h-100 shadow-sm">
                                        <img src="https://www.greenenergy.com.pe/portal/wp-content/uploads/09-Alumbrado-Solar-de-Puentes-Vehiculares.jpg?v=1" class="card-img-top" alt="Noticia">
                                        <div class="card-body">
                                            <h5 class="card-title">Mejoras en el Sistema de Alumbrado</h5>
                                            <p class="card-text">Se han completado las mejoras en el sistema de alumbrado público en 15 sectores de la ciudad.</p>
                                            <small class="text-muted">15 de Enero, 2025</small>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 col-lg-4 mb-4">
                                    <div class="card h-100 shadow-sm">
                                        <img src="https://munihuamanga.gob.pe/wp-content/uploads/2019/09/IMG_1071-2-e1570644406295.jpg?v=1" class="card-img-top" alt="Noticia">
                                        <div class="card-body">
                                            <h5 class="card-title">Reparación de Vías Principales</h5>
                                            <p class="card-text">Iniciamos la reparación y mantenimiento de las principales arterias viales de la ciudad.</p>
                                            <small class="text-muted">12 de Enero, 2025</small>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 col-lg-4 mb-4">
                                    <div class="card h-100 shadow-sm">
                                        <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlun_h9MO9a2OIa-Yo-rhisdJxSgi2jwG8OQ&s" class="card-img-top" alt="Noticia">
                                        <div class="card-body">
                                            <h5 class="card-title">Participación Ciudadana Activa</h5>
                                            <p class="card-text">Los vecinos ahora pueden reportar incidencias directamente a través del sistema INFRA REPORT.</p>
                                            <small class="text-muted">18 de Enero, 2025</small>
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
                            <h5>Información del Reporte Ciudadano</h5>
                            <table class="table table-borderless">
                                <tr><td><strong>ID:</strong></td><td>VEC-250120-001</td></tr>
                                <tr><td><strong>Categoría:</strong></td><td>Pistas y Veredas</td></tr>
                                <tr><td><strong>Lugar:</strong></td><td>Calle Los Olivos 456</td></tr>
                                <tr><td><strong>Reportado por:</strong></td><td>Juan Pérez</td></tr>
                                <tr><td><strong>Teléfono:</strong></td><td>987-654-321</td></tr>
                                <tr><td><strong>Estado:</strong></td><td><span class="badge badge-pendiente">Pendiente</span></td></tr>
                                <tr><td><strong>Fecha:</strong></td><td>20 Ene 2025</td></tr>
                                <tr><td><strong>Urgente:</strong></td><td>⚠️ Sí</td></tr>
                            </table>
                            <h6>Descripción:</h6>
                            <p class="bg-light p-3 rounded">Hueco grande en la pista que representa un peligro para los vehículos y peatones. Se encuentra en mal estado desde hace varias semanas.</p>
                        </div>
                        <div class="col-md-4">
                            <h6>Imagen del Reporte:</h6>
                            <img src="https://images.pexels.com/photos/1089438/pexels-photo-1089438.jpeg" class="img-fluid rounded" alt="Imagen del reporte">
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