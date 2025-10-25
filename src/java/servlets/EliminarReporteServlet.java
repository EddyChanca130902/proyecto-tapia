package servlets;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import utils.Conexion;

@WebServlet("/EliminarReporteServlet")
public class EliminarReporteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null) {
            response.sendRedirect("sereno.jsp?error=missing_id");
            return;
        }

        int id = Integer.parseInt(idParam);

        try (Connection conn = Conexion.getConnection()) {
            String sql = "DELETE FROM reportes WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            int filas = ps.executeUpdate();

            if (filas > 0) {
                System.out.println("✅ Reporte eliminado correctamente (ID: " + id + ")");
            } else {
                System.out.println("⚠ No se encontró el reporte con ID: " + id);
            }

            // Redirigir según el rol
            HttpSession session = request.getSession(false);
            if (session != null && "admin".equals(session.getAttribute("rol"))) {
                response.sendRedirect("admin.jsp?msg=deleted");
            } else {
                response.sendRedirect("sereno.jsp?msg=deleted");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error al eliminar reporte: " + e.getMessage());
        }
    }
}
