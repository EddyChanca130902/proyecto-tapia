package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import utils.Conexion;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AgregarUsuarioServlet")
public class AgregarUsuarioServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nombre = request.getParameter("nombre");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String rol = request.getParameter("rol");
        String estado = request.getParameter("estado");

        try (Connection conn = Conexion.getConnection()) {
            String sql = "INSERT INTO usuarios (nombre, username, password_hash, rol, estado) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, nombre);
            ps.setString(2, username);
            ps.setString(3, password);
            ps.setString(4, rol);
            ps.setString(5, estado);
            ps.executeUpdate();

            // Redirigir de vuelta al listado de usuarios
            response.sendRedirect("admin/usuarios.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin/agregarUsuario.jsp?error=" + e.getMessage());
        }
    }
}

