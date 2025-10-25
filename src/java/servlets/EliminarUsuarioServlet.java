package servlets;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import utils.Conexion;

@WebServlet("/EliminarUsuarioServlet")
public class EliminarUsuarioServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect("admin/usuarios.jsp");
            return;
        }

        int id = Integer.parseInt(idParam);

        try (Connection conn = Conexion.getConnection()) {
            String sql = "DELETE FROM usuarios WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                System.out.println("🗑️ Usuario eliminado correctamente (ID: " + id + ")");
            } else {
                System.out.println("⚠️ No se encontró el usuario con ID: " + id);
            }

            response.sendRedirect("admin/usuarios.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin/usuarios.jsp?error=db");
        }
    }
}
