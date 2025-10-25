package servlets;

import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;
import utils.Conexion;

@WebServlet("/AgregarReporteServlet")
@MultipartConfig
public class AgregarReporteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // ✅ Verificar sesión
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario_id") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int usuarioId = (int) session.getAttribute("usuario_id");
        String nombreReportante = (String) session.getAttribute("username");

        // ✅ Datos del formulario
        String categoria = request.getParameter("categoria");
        String lugar = request.getParameter("lugar");
        String descripcion = request.getParameter("descripcion");
        String telefono = request.getParameter("telefono");
        boolean urgente = request.getParameter("urgente") != null;

        // ✅ Manejo de imagen
        Part fotoPart = request.getPart("foto");
        String fotoNombre = null;
        if (fotoPart != null && fotoPart.getSize() > 0) {
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            fotoNombre = System.currentTimeMillis() + "_" + fotoPart.getSubmittedFileName();
            fotoPart.write(uploadPath + File.separator + fotoNombre);
        }

        // ✅ Guardar en la base de datos
        try (Connection conn = Conexion.getConnection()) {
            String sql = "INSERT INTO reportes (usuario_id, categoria, lugar, descripcion, nombre_reportante, telefono, foto, urgente, estado) VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'pendiente')";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, usuarioId);
            ps.setString(2, categoria);
            ps.setString(3, lugar);
            ps.setString(4, descripcion);
            ps.setString(5, nombreReportante);
            ps.setString(6, telefono);
            ps.setString(7, fotoNombre);
            ps.setBoolean(8, urgente);
            ps.executeUpdate();

            System.out.println("✅ Reporte insertado correctamente por usuario: " + nombreReportante);

            String rol = (String) session.getAttribute("rol");

            if ("sereno".equals(rol)) {
                response.sendRedirect("sereno.jsp?msg=ok");
            } else if ("vecino".equals(rol)) {
                response.sendRedirect("vecino.jsp?msg=ok");
            } else {
                response.sendRedirect("login.jsp");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("❌ Error SQL: " + e.getMessage());
        }
    }
}
