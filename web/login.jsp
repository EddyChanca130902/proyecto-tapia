<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - INFRA REPORT</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        /* ===== VARIABLES CSS ===== */
        :root {
            --primary-color: #1e3a8a;
            --secondary-color: #374151;
            --accent-color: #059669;
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

        /* ===== BODY BACKGROUND ===== */
        body {
            background: var(--gradient-secondary);
            min-height: 100vh;
            display: flex;
            align-items: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            position: relative;
            overflow-x: hidden;
        }

        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grid" width="20" height="20" patternUnits="userSpaceOnUse"><path d="M 20 0 L 0 0 0 20" fill="none" stroke="rgba(255,255,255,0.1)" stroke-width="0.5"/></pattern></defs><rect width="100" height="100" fill="url(%23grid)"/></svg>');
            opacity: 0.3;
            z-index: 0;
        }

        .container {
            position: relative;
            z-index: 1;
        }

        /* ===== LOGIN CONTAINER ===== */
        .login-container {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-lg);
            overflow: hidden;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255,255,255,0.2);
            position: relative;
        }

        .login-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--gradient-primary);
        }

        /* ===== LOGIN HEADER ===== */
        .login-header {
            background: var(--gradient-primary);
            color: white;
            padding: 2rem;
            text-align: center;
            position: relative;
        }

        .login-header::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            height: 1px;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
        }

        .login-header h2 {
            font-weight: 700;
            text-shadow: 0 2px 4px rgba(0,0,0,0.3);
            margin-bottom: 0.5rem;
        }

        .login-header p {
            opacity: 0.9;
            font-weight: 300;
        }

        /* ===== LOGIN BODY ===== */
        .login-body {
            padding: 2rem;
            background: linear-gradient(145deg, #ffffff 0%, #f8fafc 100%);
        }

        /* ===== FORM CONTROLS ===== */
        .form-control, .form-select {
            border-radius: var(--border-radius);
            border: 2px solid #e5e7eb;
            padding: 0.7rem 1rem;
            transition: var(--transition);
            background: white;
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
            padding: 0.7rem 1.5rem;
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

        .btn-primary {
            background: var(--gradient-primary);
        }

        .btn-outline-secondary {
            border: 2px solid #6b7280;
            color: #6b7280;
            background: transparent;
        }

        .btn-outline-secondary:hover {
            background: #6b7280;
            color: white;
        }

        /* ===== ROLE CARDS ===== */
        .role-card {
            border: 2px solid #e5e7eb;
            border-radius: var(--border-radius);
            padding: 1rem;
            margin-bottom: 1rem;
            cursor: pointer;
            transition: var(--transition);
            background: white;
            position: relative;
            overflow: hidden;
        }

        .role-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background: var(--gradient-primary);
            transform: scaleY(0);
            transition: var(--transition);
        }

        .role-card:hover {
            border-color: var(--primary-color);
            background: linear-gradient(145deg, #f8fafc 0%, #ffffff 100%);
            transform: translateX(5px);
            box-shadow: var(--shadow-sm);
        }

        .role-card:hover::before {
            transform: scaleY(1);
        }

        .role-card.selected {
            border-color: var(--primary-color);
            background: linear-gradient(145deg, #eff6ff 0%, #dbeafe 100%);
            box-shadow: var(--shadow-md);
            transform: translateX(8px);
        }

        .role-card.selected::before {
            transform: scaleY(1);
        }

        .role-card i {
            transition: var(--transition);
        }

        .role-card:hover i,
        .role-card.selected i {
            transform: scale(1.1);
        }

        /* ===== BACK LINK ===== */
        .back-link {
            color: white;
            text-decoration: none;
            font-weight: 500;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .back-link:hover {
            color: #f3f4f6;
            transform: translateX(-3px);
        }

        /* ===== CREDENTIALS INFO ===== */
        .credentials-info {
            background: linear-gradient(145deg, #f0f9ff 0%, #e0f2fe 100%);
            border: 1px solid #0ea5e9;
            border-radius: var(--border-radius);
            padding: 1rem;
            margin-top: 1rem;
        }

        /* ===== ANIMATIONS ===== */
        @keyframes slideInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .login-container {
            animation: slideInUp 0.6s ease-out;
        }

        /* ===== RESPONSIVE ===== */
        @media (max-width: 768px) {
            .login-header {
                padding: 1.5rem;
            }
            
            .login-body {
                padding: 1.5rem;
            }
            
            .role-card {
                padding: 0.8rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-5">
                <div class="login-container">
                    <div class="login-header">
                        <h2><i class="bi bi-building"></i> INFRA REPORT</h2>
                        <p class="mb-0">Sistema Municipal de Reportes</p>
                        <a href="index.jsp" class="back-link">
                            <i class="bi bi-arrow-left"></i> Volver al inicio
                        </a>
                    </div>
                    <div class="login-body">
                        <h4 class="mb-4 text-center">Seleccione su Rol</h4>
                        
                        <!-- Rol Selection -->
                        <div class="mb-4">
                            <div class="role-card" onclick="selectRole('admin')">
                                <div class="d-flex align-items-center">
                                    <i class="bi bi-person-gear fs-3 text-primary me-3"></i>
                                    <div>
                                        <h6 class="mb-1">Administrador Municipal</h6>
                                        <small class="text-muted">Gestión completa del sistema</small>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="role-card" onclick="selectRole('sereno')">
                                <div class="d-flex align-items-center">
                                    <i class="bi bi-person-badge fs-3 text-warning me-3"></i>
                                    <div>
                                        <h6 class="mb-1">Sereno Municipal</h6>
                                        <small class="text-muted">Reportar incidencias</small>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="role-card" onclick="selectRole('vecino')">
                                <div class="d-flex align-items-center">
                                    <i class="bi bi-person-circle fs-3 text-success me-3"></i>
                                    <div>
                                        <h6 class="mb-1">Vecino Municipal</h6>
                                        <small class="text-muted">Reportes ciudadanos</small>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Login Form -->
                        <form id="loginForm" style="display: none;" action="LoginServlet" method="post">
                            <input type="hidden" id="selectedRole" name="role" value="">
                            <div class="mb-3">
                                <label for="username" class="form-label">Usuario</label>
                                <input type="text" class="form-control" id="username" name="username" required>
                            </div>
                            <div class="mb-3">
                                <label for="password" class="form-label">Contraseña</label>
                                <input type="password" class="form-control" id="password" name="password" required>
                            </div>
                            <button type="submit" class="btn btn-primary w-100 mb-3">
                                <i class="bi bi-box-arrow-in-right"></i> Iniciar Sesión
                            </button>
                            <button type="button" class="btn btn-outline-secondary w-100" onclick="goBack()">
                                <i class="bi bi-arrow-left"></i> Cambiar Rol
                            </button>
                        </form>

                        <!-- Credentials Info -->
                        <div class="credentials-info" id="credentialsInfo" style="display: none;">
                            <div class="d-flex align-items-center mb-2">
                                <i class="bi bi-info-circle text-primary me-2"></i>
                                <strong class="text-primary">Credenciales de prueba:</strong>
                            </div>
                            <small class="text-muted">
                                <span id="credentialText"></span>
                            </small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        let selectedRole = '';

        function selectRole(role) {
            selectedRole = role;
            
            // Remove selected class from all cards
            document.querySelectorAll('.role-card').forEach(card => {
                card.classList.remove('selected');
            });
            
            // Add selected class to clicked card
            event.currentTarget.classList.add('selected');
            
            // Set hidden field value
            document.getElementById('selectedRole').value = role;
            
            // Show login form
            document.getElementById('loginForm').style.display = 'block';
            document.getElementById('credentialsInfo').style.display = 'block';
            
            // Update credentials info
            const credentialText = document.getElementById('credentialText');
            if (role === 'admin') {
                credentialText.innerHTML = 'Usuario: "admin" - Contraseña: "123"';
            } else if (role === 'sereno') {
                credentialText.innerHTML = 'Usuario: "sereno" - Contraseña: "123"';
            } else if (role === 'vecino') {
                credentialText.innerHTML = 'Usuario: "vecino" - Contraseña: "123"';
            }
        }

        function goBack() {
            selectedRole = '';
            document.querySelectorAll('.role-card').forEach(card => {
                card.classList.remove('selected');
            });
            document.getElementById('loginForm').style.display = 'none';
            document.getElementById('credentialsInfo').style.display = 'none';
            document.getElementById('username').value = '';
            document.getElementById('password').value = '';
            document.getElementById('selectedRole').value = '';
        }
    </script>
</body>
</html>