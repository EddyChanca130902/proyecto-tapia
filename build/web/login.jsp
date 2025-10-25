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
        :root {
            --primary-color: #1e3a8a;
            --secondary-color: #374151;
            --gradient-primary: linear-gradient(135deg, #1e3a8a 0%, #3b82f6 100%);
            --gradient-secondary: linear-gradient(135deg, #374151 0%, #6b7280 100%);
            --shadow-lg: 0 8px 25px rgba(0,0,0,0.2);
            --border-radius: 12px;
        }

        body {
            background: var(--gradient-secondary);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            overflow-x: hidden;
        }

        .login-container {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-lg);
            overflow: hidden;
            width: 100%;
            max-width: 480px;
            animation: fadeIn 0.6s ease-in-out;
        }

        .login-header {
            background: var(--gradient-primary);
            color: white;
            padding: 2rem;
            text-align: center;
        }

        .login-header h2 {
            font-weight: 700;
            margin-bottom: 0.3rem;
        }

        .login-body {
            padding: 2rem;
            background: #f9fafb;
        }

        .role-card {
            border: 2px solid #e5e7eb;
            border-radius: var(--border-radius);
            padding: 1rem;
            margin-bottom: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            background: white;
        }

        .role-card:hover {
            border-color: var(--primary-color);
            background: #eef2ff;
            transform: translateX(4px);
        }

        .role-card.selected {
            border-color: var(--primary-color);
            background: #dbeafe;
            box-shadow: 0 0 10px rgba(30,58,138,0.2);
        }

        .form-control {
            border-radius: var(--border-radius);
            border: 2px solid #e5e7eb;
            padding: 0.7rem 1rem;
        }

        .btn-primary {
            background: var(--gradient-primary);
            border: none;
            border-radius: var(--border-radius);
            padding: 0.7rem;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .btn-outline-secondary {
            border-radius: var(--border-radius);
            padding: 0.7rem;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(25px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <h2><i class="bi bi-building"></i> INFRA REPORT</h2>
            <p>Sistema Municipal de Reportes</p>
        </div>

        <div class="login-body">
            <h4 class="text-center mb-4">Seleccione su Rol</h4>

            <% 
                String error = request.getParameter("error");
                if ("1".equals(error)) {
            %>
                <div class="alert alert-danger text-center">❌ Usuario o contraseña incorrectos</div>
            <% } else if ("db".equals(error)) { %>
                <div class="alert alert-warning text-center">⚙️ Error en la base de datos</div>
            <% } %>

            <div class="role-card" onclick="selectRole('admin', event)">
                <div class="d-flex align-items-center">
                    <i class="bi bi-person-gear fs-3 text-primary me-3"></i>
                    <div>
                        <h6 class="mb-1">Administrador Municipal</h6>
                        <small class="text-muted">Gestión completa del sistema</small>
                    </div>
                </div>
            </div>

            <div class="role-card" onclick="selectRole('sereno', event)">
                <div class="d-flex align-items-center">
                    <i class="bi bi-person-badge fs-3 text-warning me-3"></i>
                    <div>
                        <h6 class="mb-1">Sereno Municipal</h6>
                        <small class="text-muted">Reportar incidencias</small>
                    </div>
                </div>
            </div>

            <div class="role-card" onclick="selectRole('vecino', event)">
                <div class="d-flex align-items-center">
                    <i class="bi bi-person-circle fs-3 text-success me-3"></i>
                    <div>
                        <h6 class="mb-1">Vecino Municipal</h6>
                        <small class="text-muted">Reportes ciudadanos</small>
                    </div>
                </div>
            </div>

            <form id="loginForm" style="display:none;" action="LoginServlet" method="post">
                <input type="hidden" id="selectedRole" name="rol" value="">
                <div class="mb-3">
                    <label class="form-label">Usuario</label>
                    <input type="text" class="form-control" name="username" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Contraseña</label>
                    <input type="password" class="form-control" name="password" required>
                </div>
                <button type="submit" class="btn btn-primary w-100 mb-3">
                    <i class="bi bi-box-arrow-in-right"></i> Iniciar Sesión
                </button>
                <button type="button" class="btn btn-outline-secondary w-100" onclick="goBack()">
                    <i class="bi bi-arrow-left"></i> Cambiar Rol
                </button>
            </form>
        </div>
    </div>

    <script>
        function selectRole(role, event) {
            document.querySelectorAll('.role-card').forEach(c => c.classList.remove('selected'));
            event.currentTarget.classList.add('selected');
            document.getElementById('selectedRole').value = role;
            document.getElementById('loginForm').style.display = 'block';
        }

        function goBack() {
            document.querySelectorAll('.role-card').forEach(c => c.classList.remove('selected'));
            document.getElementById('loginForm').style.display = 'none';
            document.getElementById('selectedRole').value = '';
        }
    </script>
</body>
</html>
