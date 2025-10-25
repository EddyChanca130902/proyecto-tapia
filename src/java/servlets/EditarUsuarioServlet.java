package servlets;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import utils.Conexion;

@WebServlet("/EditarUsuarioServlet")
public class EditarUsuarioServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        int id = Integer.parseInt(request.getParameter("id"));
        String nombre = request.getParameter("nombre");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String rol = request.getParameter("rol");
        String estado = request.getParameter("estado");

        try (Connection conn = Conexion.getConnection()) {

            PreparedStatement ps;
            // Si el campo contraseña está vacío, no se actualiza
            if (password == null || password.isEmpty()) {
                String sql = "UPDATE usuarios SET nombre=?, username=?, rol=?, estado=? WHERE id=?";
                ps = conn.prepareStatement(sql);
                ps.setString(1, nombre);
                ps.setString(2, username);
                ps.setString(3, rol);
                ps.setString(4, estado);
                ps.setInt(5, id);
            } else {
                String sql = "UPDATE usuarios SET nombre=?, username=?, password_hash=?, rol=?, estado=? WHERE id=?";
                ps = conn.prepareStatement(sql);
                ps.setString(1, nombre);
                ps.setString(2, username);
                ps.setString(3, password);
                ps.setString(4, rol);
                ps.setString(5, estado);
                ps.setInt(6, id);
            }

            int rows = ps.executeUpdate();
            if (rows > 0) {
                System.out.println("✅ Usuario actualizado correctamente: ID " + id);
            } else {
                System.out.println("⚠️ No se encontró el usuario con ID " + id);
            }

            response.sendRedirect("admin/usuarios.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin/usuarios.jsp?error=db");
        }
    }
}
