<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>INFRA REPORT - Sistema Municipal de Reportes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        /* ===== VARIABLES CSS ===== */
        :root {
            --primary-color: #1e3a8a;
            --secondary-color: #374151;
            --accent-color: #059669;
            --warning-color: #d97706;
            --danger-color: #dc2626;
            --light-bg: #f8fafc;
            --dark-text: #1f2937;
            --gradient-primary: linear-gradient(135deg, #1e3a8a 0%, #3b82f6 100%);
            --gradient-secondary: linear-gradient(135deg, #374151 0%, #6b7280 100%);
            --shadow-sm: 0 2px 4px rgba(0,0,0,0.1);
            --shadow-md: 0 4px 12px rgba(0,0,0,0.15);
            --shadow-lg: 0 8px 25px rgba(0,0,0,0.2);
            --border-radius: 12px;
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        /* ===== ESTILOS GLOBALES ===== */
        body {
            background-color: var(--light-bg);
            color: var(--dark-text);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            scroll-behavior: smooth;
        }

        /* ===== NAVBAR ===== */
        .bg-primary-custom {
            background-color: var(--primary-color) !important;
            background: var(--gradient-primary) !important;
            backdrop-filter: blur(10px);
            box-shadow: var(--shadow-md);
        }

        .navbar-brand {
            font-size: 1.5rem;
            letter-spacing: 0.5px;
            font-weight: 700;
            text-shadow: 0 2px 4px rgba(0,0,0,0.3);
            transition: var(--transition);
        }

        .navbar-brand:hover {
            transform: scale(1.05);
        }

        .nav-link {
            font-weight: 500;
            transition: var(--transition);
            position: relative;
        }

        .nav-link:hover {
            transform: translateY(-2px);
        }

        .nav-link::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            width: 0;
            height: 2px;
            background: white;
            transition: var(--transition);
            transform: translateX(-50%);
        }

        .nav-link:hover::after {
            width: 80%;
        }

        /* ===== HERO SECTION ===== */
        .hero-section {
            background: var(--gradient-secondary);
            padding: 100px 0;
            min-height: 600px;
            display: flex;
            align-items: center;
            position: relative;
            overflow: hidden;
        }

        .hero-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grid" width="10" height="10" patternUnits="userSpaceOnUse"><path d="M 10 0 L 0 0 0 10" fill="none" stroke="rgba(255,255,255,0.1)" stroke-width="0.5"/></pattern></defs><rect width="100" height="100" fill="url(%23grid)"/></svg>');
            opacity: 0.3;
        }

        .hero-section h1 {
            font-size: 3.5rem;
            font-weight: 700;
            line-height: 1.2;
            margin-bottom: 1.5rem;
            text-shadow: 0 4px 8px rgba(0,0,0,0.3);
            position: relative;
            z-index: 2;
        }

        .hero-section .lead {
            font-size: 1.25rem;
            font-weight: 400;
            text-shadow: 0 2px 4px rgba(0,0,0,0.2);
            position: relative;
            z-index: 2;
        }

        .hero-section .btn {
            position: relative;
            z-index: 2;
            box-shadow: var(--shadow-md);
        }

        /* ===== CARDS ===== */
        .card {
            border: none;
            border-radius: var(--border-radius);
            transition: var(--transition);
            box-shadow: var(--shadow-sm);
            overflow: hidden;
            background: white;
        }

        .card:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: var(--shadow-lg);
        }

        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--gradient-primary);
            transform: scaleX(0);
            transition: var(--transition);
        }

        .card:hover::before {
            transform: scaleX(1);
        }

        .card-img-top {
            border-radius: var(--border-radius) var(--border-radius) 0 0;
            height: 200px;
            object-fit: cover;
            transition: var(--transition);
        }

        .card:hover .card-img-top {
            transform: scale(1.1);
        }

        .card-body {
            padding: 1.5rem;
            position: relative;
        }

        .card-title {
            font-weight: 600;
            color: var(--dark-text);
            margin-bottom: 1rem;
            font-size: 1.1rem;
        }

        .card-text {
            color: #6b7280;
            line-height: 1.6;
        }

        /* ===== NEWS SECTION ===== */
        .news-card {
            position: relative;
            overflow: hidden;
        }

        .news-card .card-header {
            background: var(--gradient-primary);
            color: white;
            border: none;
            padding: 1rem 1.5rem;
            font-weight: 600;
        }

        .news-meta {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1rem;
            font-size: 0.9rem;
            color: #6b7280;
        }

        .news-meta .badge {
            font-size: 0.75rem;
            padding: 0.4rem 0.8rem;
        }

        .news-excerpt {
            color: #4b5563;
            line-height: 1.7;
            margin-bottom: 1rem;
        }

        .read-more-btn {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: var(--transition);
        }

        .read-more-btn:hover {
            color: var(--accent-color);
            transform: translateX(5px);
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

        .btn-primary {
            background: var(--gradient-primary);
        }

        /* ===== SECTIONS ===== */
        section {
            padding: 4rem 0;
            position: relative;
        }

        section h2 {
            font-weight: 700;
            color: var(--dark-text);
            margin-bottom: 3rem;
            position: relative;
            display: inline-block;
        }

        section h2::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 60px;
            height: 4px;
            background: var(--gradient-primary);
            border-radius: 2px;
        }

        /* ===== REPORTES ATENDIDOS ===== */
        .before-after-card {
            position: relative;
            overflow: hidden;
        }

        .before-after-images {
            position: relative;
        }

        .before-after-images img {
            transition: var(--transition);
        }

        .before-after-card:hover .before-after-images img {
            filter: brightness(1.1);
        }

        .status-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            background: rgba(16, 185, 129, 0.9);
            color: white;
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
            backdrop-filter: blur(10px);
        }

        /* ===== FOOTER ===== */
        footer {
            background: var(--gradient-secondary) !important;
            margin-top: 4rem;
            position: relative;
        }

        footer::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 1px;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
        }

        .social-links a {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: rgba(255,255,255,0.1);
            transition: var(--transition);
        }

        .social-links a:hover {
            background: rgba(255,255,255,0.2);
            transform: translateY(-2px);
        }

        /* ===== RESPONSIVE ===== */
        @media (max-width: 768px) {
            .hero-section {
                padding: 60px 0;
                text-align: center;
            }
            
            .hero-section h1 {
                font-size: 2.5rem;
            }

            .card {
                margin-bottom: 2rem;
            }

            section {
                padding: 2rem 0;
            }
        }

        /* ===== ANIMATIONS ===== */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .fade-in-up {
            animation: fadeInUp 0.6s ease-out;
        }

        /* ===== UTILITIES ===== */
        .text-gradient {
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .bg-pattern {
            background-image: radial-gradient(circle at 1px 1px, rgba(30,58,138,0.1) 1px, transparent 0);
            background-size: 20px 20px;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary-custom fixed-top">
        <div class="container">
            <a class="navbar-brand fw-bold" href="index.jsp">
                <i class="bi bi-building"></i> INFRA REPORT
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="#noticias">📰 Noticias</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#reportes-atendidos">✅ Reportes Atendidos</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#acerca-de">ℹ️ Acerca de</a>
                    </li>
                </ul>
                <a href="login.jsp" class="btn btn-outline-light">
                    <i class="bi bi-person-lock"></i> Login
                </a>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main style="margin-top: 76px;">
        <!-- Hero Section -->
        <section class="hero-section">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-6">
                        <h1 class="display-4 fw-bold text-white mb-4">Sistema Municipal de Reportes</h1>
                        <p class="lead text-white mb-4">Transparencia y eficiencia en la gestión de infraestructura urbana</p>
                        <a href="login.jsp" class="btn btn-light btn-lg">Iniciar Sesión</a>
                    </div>
                    <div class="col-lg-6">
                        <img src="https://web.munisjl.gob.pe/web/images/mdsjl-cambia-contigo.png?v=1" class="card-img-top" alt="Noticia">
                    </div>
                </div>
            </div>
        </section>

        <!-- Noticias Section -->
        <section id="noticias" class="py-5">
            <div class="container">
                <h2 class="text-center mb-5 fade-in-up">📰 Noticias y Comunicados Municipales</h2>
                
                <!-- Noticia Destacada -->
                <div class="row mb-5">
                    <div class="col-12">
                        <div class="card news-card shadow-lg">
                            <div class="card-header">
                                <div class="d-flex justify-content-between align-items-center">
                                    <h4 class="mb-0"><i class="bi bi-megaphone"></i> Noticia Destacada</h4>
                                    <span class="badge bg-warning text-dark">IMPORTANTE</span>
                                </div>
                            </div>
                            <div class="row g-0">
                                <div class="col-md-4">
                                    <img src="https://portal.andina.pe/EDPfotografia2/Thumbnail/2010/04/27/000124695W.jpg?v=1" class="card-img-top" alt="Noticia">
                                </div>
                                <div class="col-md-8">
                                    <div class="card-body">
                                        <h3 class="card-title text-gradient">Modernización del Sistema Municipal INFRA REPORT</h3>
                                        <div class="news-meta">
                                            <span><i class="bi bi-calendar3"></i> 20 de Enero, 2025</span>
                                            <span><i class="bi bi-person"></i> Alcaldía Municipal</span>
                                            <span class="badge bg-primary">Tecnología</span>
                                        </div>
                                        <p class="news-excerpt">
                                            La municipalidad ha implementado exitosamente el nuevo sistema INFRA REPORT, una plataforma digital 
                                            que revoluciona la gestión de reportes de infraestructura urbana. Este sistema permite a serenos 
                                            municipales y ciudadanos reportar incidencias de manera eficiente, mientras que los administradores 
                                            pueden gestionar y dar seguimiento en tiempo real.
                                        </p>
                                        <p class="news-excerpt">
                                            Con esta herramienta, buscamos mejorar la transparencia, reducir los tiempos de respuesta y 
                                            fortalecer la comunicación entre la administración municipal y la ciudadanía.
                                        </p>
                                        <a href="#" class="read-more-btn">
                                            Leer más <i class="bi bi-arrow-right"></i>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Grid de Noticias -->
                <div class="row">
                    <div class="col-md-6 col-lg-4 mb-4">
                        <div class="card h-100 shadow-sm news-card fade-in-up">
                           <img src="https://cdnespecial.elcomercio.pe/wp-content/uploads/sites/78/2021/09/Peru_Sostenible_Enel_alumbrado_publico_ciudades_sostenibles_interna.jpg?v=1" class="card-<img src="https://enfoquereal.com/wp-content/uploads/2025/02/476136146_1102468841915933_3206554856097517983_n.jpg?w=863&h=0&crop=1&v=1" class="card-img-top" alt="Noticia">
                            <div class="card-body">
                                <div class="news-meta">
                                    <span><i class="bi bi-calendar3"></i> 18 de Enero, 2025</span>
                                    <span class="badge bg-success">Infraestructura</span>
                                </div>
                                <h5 class="card-title">Mejoras en el Sistema de Alumbrado Público</h5>
                                <p class="card-text news-excerpt">
                                    Se han completado las mejoras en el sistema de alumbrado público en 15 sectores estratégicos 
                                    de la ciudad, beneficiando a más de 50,000 habitantes con mejor iluminación nocturna.
                                </p>
                                <a href="#" class="read-more-btn">
                                    Leer más <i class="bi bi-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-4 mb-4">
                        <div class="card h-100 shadow-sm news-card fade-in-up">
                            <img src="https://postgrado.ucsp.edu.pe/wp-content/uploads/2021/03/Carreteras-calles-vi%CC%81as-1.jpg?v=1" class="card-img-top" alt="Noticia">
                            <div class="card-body">
                                <div class="news-meta">
                                    <span><i class="bi bi-calendar3"></i> 15 de Enero, 2025</span>
                                    <span class="badge bg-warning text-dark">Vialidad</span>
                                </div>
                                <h5 class="card-title">Programa de Reparación de Vías Principales</h5>
                                <p class="card-text news-excerpt">
                                    Iniciamos el programa integral de reparación y mantenimiento de las principales arterias 
                                    viales, con una inversión de 2.5 millones de soles para mejorar la conectividad urbana.
                                </p>
                                <a href="#" class="read-more-btn">
                                    Leer más <i class="bi bi-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-4 mb-4">
                        <div class="card h-100 shadow-sm news-card fade-in-up">
                            <img src="https://www.defensoria.gob.pe/wp-content/uploads/2024/07/Capacitaci%C3%B3n-Serenos-Surquillo.jpg?v=1" class="card-img-top" alt="Noticia">
                            <div class="card-body">
                                <div class="news-meta">
                                    <span><i class="bi bi-calendar3"></i> 12 de Enero, 2025</span>
                                    <span class="badge bg-info">Servicios</span>
                                </div>
                                <h5 class="card-title">Capacitación a Serenos Municipales</h5>
                                <p class="card-text news-excerpt">
                                    Se realizó la capacitación completa a 120 serenos municipales sobre el uso del sistema 
                                    INFRA REPORT, fortaleciendo sus capacidades para el reporte eficiente de incidencias.
                                </p>
                                <a href="#" class="read-more-btn">
                                    Leer más <i class="bi bi-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-4 mb-4">
                        <div class="card h-100 shadow-sm news-card fade-in-up">
                            <img src="https://omceingenieros.com.pe/wp-content/uploads/2024/12/instalaciones-y-mantenimiento-de-redes-electricas-_t6pr4e4_3-1.jpg?v=1" class="card-img-top" alt="Noticia">
                            <div class="card-body">
                                <div class="news-meta">
                                    <span><i class="bi bi-calendar3"></i> 10 de Enero, 2025</span>
                                    <span class="badge bg-danger">Urgente</span>
                                </div>
                                <h5 class="card-title">Mantenimiento de Red Eléctrica</h5>
                                <p class="card-text news-excerpt">
                                    Programación de mantenimiento preventivo en la red eléctrica municipal. 
                                    Se realizarán cortes programados en horarios específicos para garantizar el servicio.
                                </p>
                                <a href="#" class="read-more-btn">
                                    Leer más <i class="bi bi-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-4 mb-4">
                        <div class="card h-100 shadow-sm news-card fade-in-up">
                            <img src="https://www.serpar.gob.pe/wp-content/uploads/2023/02/PLANTACI%C3%93N-500-%C3%81RBOLES-EN-LOS-OLIVOS-6-scaled.jpg?v=1" class="card-img-top" alt="Noticia">
                            <div class="card-body">
                                <div class="news-meta">
                                    <span><i class="bi bi-calendar3"></i> 8 de Enero, 2025</span>
                                    <span class="badge bg-success">Medio Ambiente</span>
                                </div>
                                <h5 class="card-title">Campaña de Arborización Urbana</h5>
                                <p class="card-text news-excerpt">
                                    Lanzamiento de la campaña "Ciudad Verde 2025" con la plantación de 1,000 árboles 
                                    en parques y avenidas principales para mejorar la calidad del aire.
                                </p>
                                <a href="#" class="read-more-btn">
                                    Leer más <i class="bi bi-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-4 mb-4">
                        <div class="card h-100 shadow-sm news-card fade-in-up">
                            <img src="https://enfoquereal.com/wp-content/uploads/2025/02/476136146_1102468841915933_3206554856097517983_n.jpg?w=863&h=0&crop=1" class="card-img-top" alt="Noticia">
                            <div class="card-body">
                                <div class="news-meta">
                                    <span><i class="bi bi-calendar3"></i> 5 de Enero, 2025</span>
                                    <span class="badge bg-primary">Participación</span>
                                </div>
                                <h5 class="card-title">Reuniones Vecinales Programadas</h5>
                                <p class="card-text news-excerpt">
                                    Se han programado reuniones vecinales en todos los distritos para presentar 
                                    los avances del sistema INFRA REPORT y recibir sugerencias de la comunidad.
                                </p>
                                <a href="#" class="read-more-btn">
                                    Leer más <i class="bi bi-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Botón Ver Más Noticias -->
                <div class="text-center mt-4">
                    <button class="btn btn-primary btn-lg">
                        <i class="bi bi-newspaper"></i> Ver Todas las Noticias
                    </button>
                </div>
            </div>
        </section>

        <!-- Reportes Atendidos Section -->
        <section id="reportes-atendidos" class="py-5 bg-light">
            <div class="container">
                <h2 class="text-center mb-5">✅ Reportes Atendidos</h2>
                <div class="row">
                    <div class="col-md-6 col-lg-4 mb-4">
                        <div class="card h-100 before-after-card">
                            <div class="status-badge">
                                <i class="bi bi-check-circle"></i> Resuelto
                            </div>
                            <div class="row g-0">
                                <div class="col-6">
                                    <img src="https://i1.wp.com/biblioteca.jornada.com.pe/images/2025/04/23/Situacion-de-alumbrado-publico-en-Ayacucho-alienta-la-inseguridad-ciudadana.webp?ssl=1" class="card-img-top" alt="Noticia">
                                    <small class="text-muted d-block text-center p-1">Antes</small>
                                </div>
                                <div class="col-6">
                                    <img src="https://iluminet.com/newpress/wp-content/uploads/2015/06/foto-inicio-torres-luminarios.jpg?v=1" class="card-img-top" alt="Noticia">
                                    <small class="text-success d-block text-center p-1">Después</small>
                                </div>
                            </div>
                            <div class="card-body">
                                <h6 class="card-title">Alumbrado Público</h6>
                                <p class="card-text small"><i class="bi bi-geo-alt"></i> Av. Principal 123</p>
                                <p class="card-text small"><i class="bi bi-person"></i> Reportado por: Sereno Municipal</p>
                                <p class="card-text small text-muted">
                                    <i class="bi bi-calendar-check"></i> Resuelto: 18 de Enero, 2025
                                </p>
                                <small class="text-success"><strong>Acción:</strong> Reparación completa del sistema eléctrico</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-4 mb-4">
                        <div class="card h-100 before-after-card">
                            <div class="status-badge">
                                <i class="bi bi-check-circle"></i> Resuelto
                            </div>
                            <div class="row g-0">
                                <div class="col-6">
                                    <img src="https://www.frapial.com/wp-content/uploads/2022/12/pistas-en-mal-estado.jpg?v=1" class="card-img-top" alt="Noticia">
                                    <small class="text-muted d-block text-center p-1">Antes</small>
                                </div>
                                <div class="col-6">
                                    <img src="https://chimbotenlinea.com/sites/default/files/styles/grande/public/field/image/pistas_los_pinos.jpg?itok=km0m5gSm&v=1" class="card-img-top" alt="Noticia">
                                    <small class="text-success d-block text-center p-1">Después</small>
                                </div>
                            </div>
                            <div class="card-body">
                                <h6 class="card-title">Pistas y Veredas</h6>
                                <p class="card-text small"><i class="bi bi-geo-alt"></i> Calle Los Olivos 456</p>
                                <p class="card-text small"><i class="bi bi-person"></i> Reportado por: Vecino Municipal</p>
                                <p class="card-text small text-muted">
                                    <i class="bi bi-calendar-check"></i> Resuelto: 17 de Enero, 2025
                                </p>
                                <small class="text-success"><strong>Acción:</strong> Reparación integral del pavimento</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-4 mb-4">
                        <div class="card h-100 before-after-card">
                            <div class="status-badge">
                                <i class="bi bi-check-circle"></i> Resuelto
                            </div>
                            <div class="row g-0">
                                <div class="col-6">
                                    <img src="https://proycontra.com.pe/wp-content/uploads/2023/10/MALA-SENALIZACION-CARRETERA-IQUITOS-NAYTA-2-scaled.jpg?v=1" class="card-img-top" alt="Noticia">
                                    <small class="text-muted d-block text-center p-1">Antes</small>
                                </div>
                                <div class="col-6">
                                    <img src="https://chimbotenlinea.com/sites/default/files/styles/grande/public/field/image/pistas_los_pinos.jpg?itok=km0m5gSm&v=1" class="card-img-top" alt="Noticia">
                                    <small class="text-success d-block text-center p-1">Después</small>
                                </div>
                            </div>
                            <div class="card-body">
                                <h6 class="card-title">Señalización Vial</h6>
                                <p class="card-text small"><i class="bi bi-geo-alt"></i> Av. Central 789</p>
                                <p class="card-text small"><i class="bi bi-person"></i> Reportado por: Sereno Municipal</p>
                                <p class="card-text small text-muted">
                                    <i class="bi bi-calendar-check"></i> Resuelto: 16 de Enero, 2025
                                </p>
                                <small class="text-success"><strong>Acción:</strong> Instalación de nueva señalética</small>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Botón Ver Más Reportes -->
                <div class="text-center mt-4">
                    <button class="btn btn-success btn-lg">
                        <i class="bi bi-eye"></i> Ver Todos los Reportes Atendidos
                    </button>
                </div>
            </div>
        </section>

        <!-- Acerca de Section -->
        <section id="acerca-de" class="py-5">
            <div class="container">
                <h2 class="text-center mb-5">ℹ️ Acerca del Sistema</h2>
                <div class="row">
                    <div class="col-lg-8 mx-auto">
                        <div class="card shadow-lg">
                            <div class="card-body p-5">
                                <div class="text-center mb-4">
                                    <i class="bi bi-building text-gradient" style="font-size: 4rem;"></i>
                                    <h3 class="card-title mt-3 text-gradient">INFRA REPORT</h3>
                                    <p class="lead">Sistema Municipal de Gestión de Infraestructura</p>
                                </div>
                                
                                <p class="card-text mb-4">
                                    Sistema integral de gestión municipal que permite el reporte, seguimiento y resolución 
                                    eficiente de incidencias en la infraestructura urbana. Desarrollado para fortalecer 
                                    la comunicación entre la administración municipal, serenos y ciudadanos.
                                </p>
                                
                                <h5 class="mt-4">Características:</h5>
                                <ul class="list-unstyled mb-4">
                                    <li class="mb-2"><i class="bi bi-check-circle-fill text-success me-3"></i>Reporte en tiempo real de incidencias</li>
                                    <li class="mb-2"><i class="bi bi-check-circle-fill text-success me-3"></i>Seguimiento completo de estados</li>
                                    <li class="mb-2"><i class="bi bi-check-circle-fill text-success me-3"></i>Transparencia ciudadana total</li>
                                    <li class="mb-2"><i class="bi bi-check-circle-fill text-success me-3"></i>Dashboard administrativo avanzado</li>
                                    <li class="mb-2"><i class="bi bi-check-circle-fill text-success me-3"></i>Gestión de fotos antes/después</li>
                                    <li class="mb-2"><i class="bi bi-check-circle-fill text-success me-3"></i>Sistema de roles diferenciados</li>
                                </ul>
                                
                                <div class="row mt-4">
                                    <div class="col-md-6">
                                        <h6><i class="bi bi-people-fill text-primary me-2"></i>Usuarios del Sistema:</h6>
                                        <ul class="list-unstyled small">
                                            <li>• Administradores Municipales</li>
                                            <li>• Serenos Municipales</li>
                                            <li>• Vecinos y Ciudadanos</li>
                                        </ul>
                                    </div>
                                    <div class="col-md-6">
                                        <h6><i class="bi bi-gear-fill text-primary me-2"></i>Categorías de Reporte:</h6>
                                        <ul class="list-unstyled small">
                                            <li>• Alumbrado Público</li>
                                            <li>• Pistas y Veredas</li>
                                            <li>• Alcantarillado</li>
                                            <li>• Señalización Vial</li>
                                        </ul>
                                    </div>
                                </div>
                                
                                <h5 class="mt-4">Contacto:</h5>
                                <div class="row">
                                    <div class="col-md-6">
                                        <p class="mb-2"><i class="bi bi-telephone-fill text-primary me-2"></i> (01) 234-5678</p>
                                        <p class="mb-2"><i class="bi bi-envelope-fill text-primary me-2"></i> contacto@infrareport.gob.pe</p>
                                    </div>
                                    <div class="col-md-6">
                                        <p class="mb-2"><i class="bi bi-geo-alt-fill text-primary me-2"></i> Av. Municipal 123, Lima</p>
                                        <p class="mb-2"><i class="bi bi-clock-fill text-primary me-2"></i> Lun - Vie: 8:00 AM - 6:00 PM</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <!-- Footer -->
    <footer class="bg-dark text-white py-4">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h5><i class="bi bi-building me-2"></i>INFRA REPORT</h5>
                    <p class="mb-3">Sistema Municipal de Gestión de Infraestructura</p>
                    <p class="small text-light opacity-75">
                        Comprometidos con la transparencia y eficiencia en la gestión municipal.
                    </p>
                </div>
                <div class="col-md-6 text-md-end">
                    <div class="social-links mb-3">
                        <a href="#" class="text-white me-3" title="Facebook"><i class="bi bi-facebook"></i></a>
                        <a href="#" class="text-white me-3" title="Twitter"><i class="bi bi-twitter"></i></a>
                        <a href="#" class="text-white me-3" title="Instagram"><i class="bi bi-instagram"></i></a>
                        <a href="#" class="text-white" title="YouTube"><i class="bi bi-youtube"></i></a>
                    </div>
                    <p class="mb-1">&copy; 2025 Municipalidad Provincial.</p>
                    <p class="small opacity-75">Todos los derechos reservados.</p>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>